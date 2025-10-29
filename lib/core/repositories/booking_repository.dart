import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/user_app_store.dart'; // đổi path nếu file store ở nơi khác
import 'package:pstb/utils/app_extensions.dart';
import 'package:uuid/uuid.dart';

import '../../feature/booking/data/models/booking_request.dart';
import '../../feature/booking/data/models/crm_booking_response.dart';
import '../../feature/booking/datasources/local/history_local_ds.dart';
import '../../feature/booking/datasources/remote/crm_booking_service.dart';
import '../../feature/booking/domain/entities/history_entry.dart';
import '../../feature/booking/domain/entities/lead_service.dart';
import '../../feature/booking/domain/entities/time_slot.dart';
import '../../feature/booking/datasources/remote/catalog_service.dart';
import '../../utils/crm_message_parser.dart';

abstract class BookingRepository {
  Future<List<LeadService>> getLeadServices(Map<String, dynamic> body);
  Future<List<TimeSlot>> getTimeSlots(Map<String, dynamic> body);
  Future<CrmBookingResponse> createBooking(BookingRequest request);

  Future<void> addHistory(HistoryEntry e);
  Future<List<HistoryEntry>> getHistory();
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
    final res = await catalogService.fetchLeadServices(body);
    return res.data ?? [];
  }

  @override
  Future<List<TimeSlot>> getTimeSlots(Map<String, dynamic> body) async {
    final res = await catalogService.fetchTimeSlots(body);
    return res.data ?? [];
  }

  @override
  Future<CrmBookingResponse> createBooking(BookingRequest request) async {
    final rsp = await bookingService.createBooking(request);

    // Parse Booking/Customer IDs từ message: "Saved Customer ID: 52575 - Booking ID: 52590"
    final ids = parseCrmIds(rsp.message);
    final bookingIdPref = ids.bookingId ?? rsp.id;
    final generatedOrParsedId = bookingIdPref ?? const Uuid().v4();

    // Lưu lịch sử local theo sđt user
    final data = request.data;
    final entry = HistoryEntry(
      id: generatedOrParsedId,
      patientName: data.firstname,
      phone: data.mobile,
      serviceName: data.leads_interest_service,
      visitDateIso: _isoFromDdMmDash(data.start_day),
      visitTimeIso: _isoFromViTime(data.start_day, data.start_time.first),
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

  // Helpers chuyển định dạng chuỗi CRM về ISO
  String _isoFromDdMmDash(String ddMMyyyyDash) {
    // "11-06-2025" -> "2025-06-11T00:00:00.000Z"
    final p = ddMMyyyyDash.split('-'); // [dd, MM, yyyy]
    return DateTime.utc(int.parse(p[2]), int.parse(p[1]), int.parse(p[0]))
        .toIso8601String();
  }

  String _isoFromViTime(String ddMMyyyyDash, String hmVi) {
    // "10:00 Sáng" -> 10:00 ; "02:30 Chiều" -> 14:30
    final parts = hmVi.split(' ');
    final hm = parts[0];
    final ampm = parts.length > 1 ? parts[1] : 'Sáng';
    final hmp = hm.split(':');
    var h = int.parse(hmp[0]);
    final m = int.parse(hmp[1]);
    if (ampm == 'Chiều' && h < 12) h += 12;

    final d = ddMMyyyyDash.split('-'); // [dd, MM, yyyy]
    return DateTime.utc(int.parse(d[2]), int.parse(d[1]), int.parse(d[0]), h, m)
        .toIso8601String();
  }
}
