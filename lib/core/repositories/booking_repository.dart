import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/user_app_store.dart'; // đổi path nếu file store ở nơi khác
import 'package:pstb/utils/app_extensions.dart';
import 'package:uuid/uuid.dart';

import '../../feature/booking/data/models/booking_request.dart';
import '../../feature/booking/data/models/crm_booking_item.dart';
import '../../feature/booking/data/models/crm_booking_response.dart';
import '../../feature/booking/data/models/location_item.dart';
import '../../feature/booking/data/models/picklist_cities_response.dart';
import '../../feature/booking/data/models/picklist_states_response.dart';
import '../../feature/booking/datasources/local/history_local_ds.dart';
import '../../feature/booking/datasources/remote/crm_booking_service.dart';
import '../../feature/booking/domain/entities/history_entry.dart';
import '../../feature/booking/domain/entities/lead_service.dart';
import '../../feature/booking/domain/entities/time_slot.dart';
import '../../feature/booking/datasources/remote/catalog_service.dart';
import '../../utils/crm_message_parser.dart';

abstract class BookingRepository {
  Future<List<LeadService>> getLeadServices(Map<String, dynamic> body);
  Future<CrmBookingResponse> createBooking(BookingRequest request);

  Future<void> addHistory(HistoryEntry e);
  Future<List<HistoryEntry>> getHistory();
  Future<List<CrmBookingItem>> getHistoryRemote({
    required DateTime from,
    required DateTime to,
    int offset,
    int maxRows,
  });
  Future<List<MailingCityItem>> getCities();
  Future<List<MailingStateItem>> getWardsByCity(String cityKey);
}

class BookingRepositoryImpl implements BookingRepository {
  final CrmBookingService bookingService;
  final CatalogService catalogService;
  final HistoryLocalSqliteDs historyLocal; // DS SQLite
  final String accessKey; // ví dụ: "TXEjpPNBINpFYD70"
  final String inputSource; // ví dụ: "APP MOBILE"

  BookingRepositoryImpl({
    required this.bookingService,
    required this.catalogService,
    required this.historyLocal,
    required this.accessKey,
    this.inputSource = 'APP MOBILE',
  });

  @override
  Future<List<LeadService>> getLeadServices(Map<String, dynamic> body) async {
    final authRes =
        await catalogService.auth("it.crm", "278bac897ff389ef3af754c6cf34df96");
    final token = authRes.access_token;
    print("token $token");
    // 2. Lấy danh sách services
    final res = await catalogService.getServices(
      token,
      "Services",
      "modifiedtime",
      "DESC",
      0,
      5,
    );

    final list = res.entry_list ?? [];

    return list;
  }

  @override
  Future<CrmBookingResponse> createBooking(BookingRequest request) async {
    final rsp = await bookingService.createBooking(request);
    print(rsp.message);
    // Parse Booking/Customer IDs từ message: "Saved Customer ID: 52575 - Booking ID: 52590"
    final ids = parseCrmIds(rsp.message);
    final bookingIdPref = ids.bookingId ?? rsp.id;
    final generatedOrParsedId = bookingIdPref ?? const Uuid().v4();
    print("ok");
    // Lưu lịch sử local theo sđt user
    final data = request.data;
    final entry = HistoryEntry(
      id: generatedOrParsedId,
      patientName: data.firstname,
      phone: data.mobile,
      serviceName: data.leads_interest_service,
      visitDateIso: _isoFromDdMmDash(data.start_day),
      visitTimeIso: _isoFromDdMmDash(data.start_day),
      branch: data.branch,
      status: rsp.success == true ? 'Xác nhận' : (rsp.message ?? 'Chờ'),
      createdAtIso: DateTime.now().toViTimeLabel(),
    );

    final userPhone = Modular.get<UserAppStore>().getUserPhone;
    await historyLocal.add(userPhone, entry);

    return rsp;
  }

  @override
  Future<void> addHistory(HistoryEntry e) {
    final userPhone = Modular.get<UserAppStore>().getUserPhone;
    return historyLocal.add(userPhone, e);
  }

  @override
  Future<List<HistoryEntry>> getHistory() {
    final userPhone = Modular.get<UserAppStore>().getUserPhone;
    return historyLocal.getAll(userPhone);
  }

  @override
  Future<List<CrmBookingItem>> getHistoryRemote({
    required DateTime from,
    required DateTime to,
    int offset = 0,
    int maxRows = 20,
  }) async {
    final authRes = await catalogService.auth(
      "it.crm",
      "278bac897ff389ef3af754c6cf34df96",
    );
    final token = authRes.access_token;

    // Lấy CCCD từ app store
    final store = Modular.get<UserAppStore>();
    final cccd = (store.user.personalId ?? '')
        .toString()
        .trim(); // <-- bé đổi đúng getter thực tế

    final filters = <Map<String, dynamic>>[
      // {
      //   "name": "start_day",
      //   "value": "${_fmtYyyyMmDd(from)},${_fmtYyyyMmDd(to)}",
      //   "operator": "bw",
      // },
    ];

    // Nếu có CCCD thì mới filter, tránh làm rỗng kết quả
    if (cccd.isNotEmpty) {
      filters.add({
        "name": "cf_related_contact__identification_number",
        "value": cccd,
        "operator": "e",
      });
    }

    final filterJson = jsonEncode(filters);

    final res = await catalogService.getBookings(
      token,
      "CPBooking",
      "modifiedtime",
      "DESC",
      offset,
      maxRows,
      filterJson,
    );

    return res.entry_list ?? <CrmBookingItem>[];
  }

  String _fmtYyyyMmDd(DateTime d) {
    final y = d.year.toString().padLeft(4, '0');
    final m = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    return '$y-$m-$day';
  }

  // Helpers chuyển định dạng chuỗi CRM về ISO
  String _isoFromDdMmDash(String ddMMyyyyDash) {
    // "11-06-2025" -> "2025-06-11T00:00:00.000Z"
    final p = ddMMyyyyDash.split('-'); // [dd, MM, yyyy]
    return DateTime.utc(int.parse(p[2]), int.parse(p[1]), int.parse(p[0]))
        .toIso8601String();
  }

  @override
  Future<List<MailingCityItem>> getCities() async {
    final authRes = await catalogService.auth(
      "it.crm",
      "278bac897ff389ef3af754c6cf34df96",
    );
    final token = authRes.access_token;
    final res = await catalogService.getMailingCities(
      token,
      "Contacts",
      "mailingcity",
    );
    if (!res.success) return <MailingCityItem>[];
    return res.picklistOptions;
  }

  @override
  Future<List<MailingStateItem>> getWardsByCity(String cityKey) async {
    final authRes = await catalogService.auth(
      "it.crm",
      "278bac897ff389ef3af754c6cf34df96",
    );
    final token = authRes.access_token;
    final res = await catalogService.getMailingStates(
      token,
      "Contacts",
      "mailingstate",
      "mailingcity",
      cityKey, // parentKey = city.key
    );
    if (!res.success) return <MailingStateItem>[];
    return res.picklistOptions;
  }
}
