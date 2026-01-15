import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;

import '../../../../app/modules/bottom_nav/bottom_nav_page.dart';
import '../../../../app/user_app_store.dart';
import '../../../../constant/color.dart';
import '../../../../di/locator.dart';
import '../../../../utils/app_extensions.dart';
import '../../../../utils/crm_message_parser.dart';
import '../../../../utils/date_time_custom_utils.dart';

import '../../../../utils/qr_scanner_screen.dart';
import '../../../relatives/data/models/relative_model.dart';
import '../../../relatives/presentation/cubit/relative_list_cubit.dart';
import '../../data/models/booking_request.dart';
import '../../data/models/picklist_cities_response.dart';
import '../../data/models/picklist_states_response.dart';
import '../../domain/entities/lead_service.dart';
import '../cubits/booking_location_cubit.dart';
import '../cubits/booking_location_state.dart';
import '../cubits/lead_service_cubit.dart';
import '../cubits/booking_submit_cubit.dart';
import '../cubits/booking_history_cubit.dart';
import '../cubits/booking_history_state.dart';
import 'booking_history_screen.dart';

// Blue & White Color Scheme
class BookingColors {
  static const primaryBlue = Color(0xFF1976D2);
  static const lightBlue = Color(0xFF42A5F5);
  static const darkBlue = Color(0xFF0D47A1);
  static const accentBlue = Color(0xFF2196F3);
  static const white = Color(0xFFFFFFFF);
  static const lightGray = Color(0xFFF5F7FA);
  static const borderGray = Color(0xFFE0E0E0);
  static const textDark = Color(0xFF212121);
  static const textGray = Color(0xFF757575);
}

class BookingPage extends StatefulWidget {
  const BookingPage({
    super.key,
    this.accessKey = 'TXEjpPNBINpFYD70',
    this.inputSource = 'APP MOBILE',
  });

  final String accessKey;
  final String inputSource;

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage>
    with SingleTickerProviderStateMixin {
  // Controllers (personal info)
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _cccdController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _ageController = TextEditingController();
  final _idIssueDateController = TextEditingController();
  final _idIssuePlaceController = TextEditingController();

  // Booking-specific
  final _noteController = TextEditingController();
  final _branchController =
      TextEditingController(text: "Bệnh viện Phụ sản Thái Bình");

  String _gender = 'Nam';
  LeadService? _selectedService;
  DateTime _visitDate = DateTime.now().add(const Duration(days: 1));
  DateTime? _idIssueAt;

  // người thân
  RelativeModel? _selectedRelative;

  // cubits (from DI)
  late final LeadServiceCubit _lsCubit;
  late final BookingSubmitCubit _submitCubit;
  //late final BookingHistoryCubit _historyCubit;
  late final RelativeListCubit _relativeCubit;

  // user store (MobX)
  late final UserAppStore _userStore;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final _streetController = TextEditingController(); // mailingstreet

  String? _selectedCityId; // mailingcity
  String? _selectedWardId; // mailingstate

  late final BookingLocationCubit _locationCubit; // NEW

  @override
  void initState() {
    super.initState();

    // Animation setup
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );
    _animationController.forward();

    // DI: get cubits
    _lsCubit = LeadServiceCubit();
    _submitCubit = BookingSubmitCubit();
    //_historyCubit = BookingHistoryCubit();

    try {
      _relativeCubit = Modular.get<RelativeListCubit>();
    } catch (_) {
      _relativeCubit = serviceLocator<RelativeListCubit>();
    }

    try {
      _userStore = Modular.get<UserAppStore>();
    } catch (_) {
      _userStore = serviceLocator<UserAppStore>();
    }

    _prefillFromUserStore();
    _loadInitial();

    // nếu muốn: khi CCCD chính thay đổi đủ 12 số thì reload người thân
    // _cccdController.addListener(() {
    //   final main = _cccdController.text.trim();
    //   if (main.length == 12) {
    //     _relativeCubit.load("037200009029");
    //   }
    // });
    _locationCubit = BookingLocationCubit();
    _locationCubit.loadCities();
  }

  void _prefillFromUserStore() {
    final user = _userStore.user;
    final name = _userStore.getUserName;
    final phone = _userStore.getUserPhone;
    final email = _userStore.getUserEmail;
    final personalId = user.personalId ?? '';
    final dob = _userStore.getUserDob;

    if (name.isNotEmpty) _nameController.text = name;
    if (phone.isNotEmpty) _phoneController.text = phone;
    if (email.isNotEmpty) _emailController.text = email;
    if (personalId.isNotEmpty) _cccdController.text = personalId;
    if (dob.isNotEmpty) {
      _birthDateController.text = dob;
      try {
        final parsed = DateFormat('dd/MM/yyyy').parseLoose(dob);
        final years = DateTime.now().difference(parsed).inDays ~/ 365;
        _ageController.text = years.toString();
      } catch (_) {
        _ageController.text = '';
      }
    }
  }

  void _loadInitial() {
    _lsCubit.fetchLeadServices({});
    //_historyCubit.load();

    // load danh sách người thân theo CCCD chính
    final mainCccd = _userStore.user.personalId ?? _cccdController.text.trim();
    if (mainCccd.isNotEmpty) {
      _relativeCubit.load("037200009029");
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _cccdController.dispose();
    _birthDateController.dispose();
    _ageController.dispose();
    _idIssueDateController.dispose();
    _noteController.dispose();
    _branchController.dispose();
    _streetController.dispose();
    _idIssuePlaceController.dispose();

    super.dispose();
  }

  // --- QR handling ---
  Future<void> _onScanQR() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => QRScannerScreen(onQRScanned: _handleScannedQr),
      ),
    );
  }

  void _handleScannedQr(String raw) {
    final parsed = _tryParseQr(raw);
    if (parsed['name'] != null) _nameController.text = parsed['name']!;
    if (parsed['cccd'] != null) _cccdController.text = parsed['cccd']!;
    if (parsed['dob'] != null) {
      final dobRaw = parsed['dob']!;
      final dobFormatted = _normalizeDobToDdMMyyyy(dobRaw);
      if (dobFormatted != null) {
        _birthDateController.text = dobFormatted;
        try {
          final parsedDate = DateFormat('dd/MM/yyyy').parseLoose(dobFormatted);
          final years = DateTime.now().difference(parsedDate).inDays ~/ 365;
          _ageController.text = years.toString();
        } catch (_) {}
      }
    }
    if (parsed['idIssue'] != null) {
      final idIssueRaw = parsed['idIssue']!;
      DateTime? dt;
      try {
        dt = DateTime.parse(idIssueRaw);
      } catch (_) {
        try {
          dt = DateFormat('dd/MM/yyyy').parseLoose(idIssueRaw);
        } catch (_) {
          dt = null;
        }
      }
      if (dt != null) {
        _idIssueAt = dt;
        _idIssueDateController.text = DateTimeCustomUtils.parseDateTimeIso(
          dateTime: dt.toIso8601String(),
        );
      }
    }
    if (parsed['place'] != null) {
      _branchController.text = parsed['place']!;
    }
    if (parsed['phone'] != null) _phoneController.text = parsed['phone']!;
    if (parsed['email'] != null) _emailController.text = parsed['email']!;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 12),
            Expanded(
              child: Text('Đã nhập thông tin từ QR. Vui lòng kiểm tra lại.'),
            ),
          ],
        ),
        backgroundColor: BookingColors.primaryBlue,
        behavior: SnackBarBehavior.fixed,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Map<String, String?> _tryParseQr(String raw) {
    final out = <String, String?>{
      'name': null,
      'cccd': null,
      'dob': null,
      'idIssue': null,
      'place': null,
      'phone': null,
      'email': null,
    };

    try {
      final j = json.decode(raw);
      if (j is Map) {
        out['name'] =
            (j['name'] ?? j['hoTen'] ?? j['fullName'] ?? j['Họ và tên'])
                ?.toString();
        out['cccd'] = (j['id'] ?? j['cccd'] ?? j['cmnd'] ?? j['identifyNumber'])
            ?.toString();
        out['dob'] = (j['dob'] ?? j['birthDate'] ?? j['ngaySinh'])?.toString();
        out['idIssue'] = (j['issueDate'] ?? j['ngayCap'])?.toString();
        out['place'] = (j['issuePlace'] ?? j['noiCap'])?.toString();
        out['phone'] = (j['phone'] ?? j['mobile'])?.toString();
        out['email'] = (j['email'])?.toString();
        return out;
      }
    } catch (_) {}

    final separators = ['\n', '|', ';', ','];
    for (final sep in separators) {
      if (raw.contains(sep)) {
        final parts = raw.split(sep);
        for (final p in parts) {
          final kv = p.split(RegExp(r'[:=]'));
          if (kv.length >= 2) {
            final k = kv[0].trim().toLowerCase();
            final v = kv.sublist(1).join(':').trim();
            if (k.contains('name') ||
                k.contains('hoten') ||
                k.contains('ho ten') ||
                k.contains('fullname')) {
              out['name'] = v;
            }
            if (k.contains('cccd') ||
                k.contains('cmnd') ||
                k.contains('id') ||
                k.contains('identify')) {
              out['cccd'] = v.replaceAll(RegExp(r'[^0-9]'), '');
            }
            if (k.contains('dob') ||
                k.contains('birth') ||
                k.contains('ngaysinh')) {
              out['dob'] = v;
            }
            if (k.contains('ngaycap') ||
                k.contains('issue') ||
                k.contains('ngày cấp') ||
                k.contains('ngaycap')) {
              out['idIssue'] = v;
            }
            if (k.contains('noicap') ||
                k.contains('noi cap') ||
                k.contains('place')) {
              out['place'] = v;
            }
            if (k.contains('phone') || k.contains('mobile')) {
              out['phone'] = v.replaceAll(RegExp(r'[^0-9+]'), '');
            }
            if (k.contains('email')) out['email'] = v;
          }
        }
        if (out['cccd'] != null || out['name'] != null) return out;
      }
    }

    final idMatch = RegExp(r'\b(\d{12}|\d{9})\b').firstMatch(raw);
    if (idMatch != null) {
      out['cccd'] = idMatch.group(1);
    }

    final lines = raw.split(RegExp(r'[\r\n]+'));
    for (final l in lines) {
      final t = l.trim();
      if (t.length > 4 &&
          RegExp(r'^[\p{L} \.\-]+$', unicode: true).hasMatch(t)) {
        if (out['name'] == null) out['name'] = t;
      }
      final dateMatch = RegExp(r'(\d{2}[/\-]\d{2}[/\-]\d{4})').firstMatch(t);
      if (dateMatch != null && out['dob'] == null) {
        out['dob'] = dateMatch.group(1);
      }
    }

    return out;
  }

  String? _normalizeDobToDdMMyyyy(String raw) {
    final tries = [
      () {
        try {
          final d = DateTime.parse(raw);
          return DateFormat('dd/MM/yyyy').format(d);
        } catch (_) {
          return null;
        }
      },
      () {
        try {
          final d = DateFormat('dd/MM/yyyy').parseLoose(raw);
          return DateFormat('dd/MM/yyyy').format(d);
        } catch (_) {
          try {
            final d2 = DateFormat('dd-MM-yyyy').parseLoose(raw);
            return DateFormat('dd/MM/yyyy').format(d2);
          } catch (_) {
            return null;
          }
        }
      },
      () {
        try {
          final d = DateFormat('yyyyMMdd').parseLoose(raw);
          return DateFormat('dd/MM/yyyy').format(d);
        } catch (_) {
          return null;
        }
      }
    ];

    for (final f in tries) {
      final r = f();
      if (r != null) return r;
    }
    return null;
  }

  bool _validateFormBeforeSubmit() {
    final nameOk = _nameController.text.trim().isNotEmpty;
    final phoneOk = RegExp(r'^\d{10}$').hasMatch(_phoneController.text.trim());
    final cccdOk = RegExp(r'^\d{12}$').hasMatch(_cccdController.text.trim());
    final idIssuePlaceOk = _idIssuePlaceController.text.trim().isNotEmpty;

    final emailOk = _emailController.text.isEmpty ||
        RegExp(r'^\S+@\S+\.\S+$').hasMatch(_emailController.text.trim());
    final branchOk = _branchController.text.trim().isNotEmpty;
    final idIssueOk = _idIssueAt != null;
    final serviceOk = _selectedService != null;
    final cityOk = (_selectedCityId ?? '').isNotEmpty;
    final wardOk = (_selectedWardId ?? '').isNotEmpty;
    // final streetOk = _streetController.text.trim().isNotEmpty;
    if (!nameOk) {
      _showSnack('Họ tên không được để trống', isError: true);
    } else if (!phoneOk) {
      _showSnack('Số điện thoại phải đủ 10 số', isError: true);
    } else if (!cccdOk) {
      _showSnack('CCCD phải đủ 12 số', isError: true);
    } else if (!emailOk) {
      _showSnack('Email không hợp lệ', isError: true);
    } else if (!branchOk) {
      _showSnack('Vui lòng nhập cơ sở khám (branch)', isError: true);
    } else if (!idIssueOk) {
      _showSnack('Vui lòng chọn ngày giờ cấp CCCD', isError: true);
    } else if (!serviceOk) {
      _showSnack('Vui lòng chọn dịch vụ', isError: true);
    } else if (!cityOk) {
      _showSnack('Vui lòng chọn Tỉnh/TP', isError: true);
    } else if (!wardOk) {
      _showSnack('Vui lòng chọn Xã/Phường', isError: true);
    } else if (!idIssuePlaceOk) {
      _showSnack('Vui lòng nhập nơi cấp CCCD', isError: true);
    }

    return nameOk &&
        phoneOk &&
        cccdOk &&
        idIssuePlaceOk &&
        emailOk &&
        branchOk &&
        idIssueOk &&
        serviceOk &&
        cityOk &&
        wardOk;
  }

  Future<void> _showCenterErrorDialog({
    String title = 'Lỗi đặt lịch',
    String message = 'Đã xảy ra lỗi. Vui lòng thử lại sau.',
  }) async {
    FocusManager.instance.primaryFocus?.unfocus();

    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 24),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child:
                  const Icon(Icons.error_rounded, color: Colors.red, size: 28),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  color: BookingColors.textDark,
                ),
              ),
            ),
          ],
        ),
        content: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red.withOpacity(0.2)),
                ),
                child: Text(
                  message,
                  style: const TextStyle(
                    fontSize: 15,
                    color: BookingColors.textDark,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Vui lòng thử lại sau ít phút hoặc liên hệ hỗ trợ nếu lỗi tiếp diễn.',
                style: TextStyle(fontSize: 12, color: BookingColors.textGray),
              ),
            ],
          ),
        ),
        actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Đóng',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  void _showSnack(String msg, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isError ? Icons.error_outline : Icons.info_outline,
              color: Colors.white,
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(msg)),
          ],
        ),
        backgroundColor:
            isError ? Colors.red.shade600 : BookingColors.primaryBlue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        behavior: SnackBarBehavior.fixed,
      ),
    );
  }

  String _toDdMmYyyy(String ddMmYyyy) {
    try {
      final d = DateFormat('dd/MM/yyyy').parseLoose(ddMmYyyy.trim());
      return DateFormat('dd/MM/yyyy').format(d);
    } catch (_) {
      // nếu user nhập sai format, fallback: trả nguyên văn (BE tự validate)
      return ddMmYyyy.trim();
    }
  }

  String _genderToId(String gender) {
    // yêu cầu: 0=Nữ; 1=Nam
    return (gender.toLowerCase() == 'nữ' || gender.toLowerCase() == 'nu')
        ? 'Female'
        : 'Male';
  }

  Future<void> _confirmAndSubmit() async {
    _unfocusAll();
    if (!_validateFormBeforeSubmit()) return;

    final idIssueStr = DateTimeCustomUtils.parseDateIso(
      dateTime: _idIssueAt!.toIso8601String(),
    );
    final startDayStr = DateFormat('dd-MM-yyyy').format(_visitDate);
    final timeStrUi = DateFormat('dd/MM/yyyy').format(_visitDate);
    final birthdayDdMmYy = _toDdMmYyyy(_birthDateController.text);
    const countryIdDefault = "C341E4B6-3426-4E40-AC06-6C0212F180B9";
    final genderId = _genderToId(_gender);
    final req = BookingRequest(
      access_key: widget.accessKey,
      simple_params: "0",
      input_source: widget.inputSource,
      data: BookingData(
        firstname: _nameController.text.trim(),
        mobile: _phoneController.text.trim(),
        email: _emailController.text.trim(),
        leads_interest_service: _selectedService!.code,
        identification_number: _cccdController.text.trim(),
        identity_card_issue_date: idIssueStr,
        branch: _branchController.text.trim(),
        start_day: startDayStr,
        start_time: const [], // Không chọn giờ, để rỗng
        note: _noteController.text.trim(),
        cpbooking_source: widget.inputSource,
        source_description: widget.inputSource,
        cf_related_contact__identification_number:
            _cccdController.text.trim(), // NEW
        birthday: birthdayDdMmYy,
        mailingcountry: countryIdDefault,
        gender: genderId,
        mailingcity: _selectedCityId ?? '',
        mailingstate: _selectedWardId ?? '',
        mailingstreet: _streetController.text.trim(),
        identity_card_issue_place: _idIssuePlaceController.text.trim(),
      ),
    );

    final ok = await showModalBottomSheet<bool>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _ReviewSheet(
        name: _nameController.text,
        phone: _phoneController.text,
        email: _emailController.text,
        service: _selectedService!.name,
        branch: _branchController.text,
        dateStr: timeStrUi,
        timeStr: timeStrUi,
        idIssueStr: DateTimeCustomUtils.parseDateTimeIso(
          dateTime: _idIssueAt!.toIso8601String(),
        ),
        note: _noteController.text,
      ),
    );

    if (ok != true) return;

    _submitCubit.submit(req);
  }

  InputDecoration _buildInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: BookingColors.primaryBlue, size: 22),
      filled: true,
      fillColor: BookingColors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: BookingColors.borderGray),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: BookingColors.borderGray),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide:
            const BorderSide(color: BookingColors.primaryBlue, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
      labelStyle: const TextStyle(color: BookingColors.textGray),
    );
  }

  void _unfocusAll() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void _goHome(BuildContext context) {
    try {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const BottomNavPage()),
      );
      return;
    } catch (_) {}
  }

  void _fillFromRelative(RelativeModel r) {
    setState(() {
      _selectedRelative = r;
      _nameController.text = r.fullName;
      _cccdController.text = r.cccd;
      _phoneController.text = r.phone;

      // dob format YYYY-MM-DD
      try {
        final d = DateTime.parse(r.dob);
        _birthDateController.text = DateFormat('dd/MM/yyyy').format(d);
        final years = DateTime.now().difference(d).inDays ~/ 365;
        _ageController.text = years.toString();
      } catch (_) {
        // nếu parse lỗi thì giữ nguyên
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _lsCubit),
        BlocProvider.value(value: _submitCubit),
        //BlocProvider.value(value: _historyCubit),
        BlocProvider.value(value: _relativeCubit),
        BlocProvider.value(value: _locationCubit),
      ],
      child: BlocListener<BookingSubmitCubit, BookingSubmitState>(
        listener: (context, st) async {
          if (st is BookingSubmitSuccess) {
            //_historyCubit.load();

            final dayOnly = DateFormat('dd/MM/yyyy').format(_visitDate);

            await showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              useSafeArea: true,
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              builder: (_) => _SuccessSheet(
                title: 'Đặt khám thành công!',
                note1:
                    "Cảm ơn bạn đã đăng ký sử dụng dịch vụ. Bộ phận chăm sóc khách hàng của bệnh viện sẽ liên hệ với bạn trong thời gian sớm nhất.",
                note2: "",
                hospital: _branchController.text,
                service: _selectedService?.name ?? '',
                timeStr: dayOnly,
                symptom: _noteController.text,
                onHome: () {
                  Navigator.of(context).pop();
                  _goHome(context);
                },
              ),
            );
          }

          if (st is BookingSubmitError) {
            await _showCenterErrorDialog(
              title: 'Không thể đặt lịch',
              message: 'Đã xảy ra lỗi. Vui lòng thử lại sau.',
            );
          }
        },
        child: Scaffold(
          backgroundColor: BookingColors.lightGray,
          appBar: AppBar(
            title: const Text(
              'Đặt lịch khám',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: BookingColors.white,
                fontSize: 20,
              ),
            ),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(color: BookingColors.white),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    BookingColors.primaryBlue,
                    BookingColors.lightBlue,
                  ],
                ),
              ),
            ),
          ),
          body: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 100),
                    children: [
                      // Relative selector
                      // Thay thế phần _BlueWhiteCard đầu tiên (có title: 'Đặt khám cho')
// Bắt đầu từ dòng ~280 trong code gốc

                      // _BlueWhiteCard(
                      //   title: 'Đặt khám cho',
                      //   icon: Icons.family_restroom,
                      //   child:
                      //       BlocBuilder<RelativeListCubit, RelativeListState>(
                      //     builder: (context, st) {
                      //       // if (st.loading) {
                      //       //   return const LinearProgressIndicator(
                      //       //     color: BookingColors.primaryBlue,
                      //       //     backgroundColor: BookingColors.lightGray,
                      //       //   );
                      //       // }
                      //
                      //       if (st.error != null && st.error!.isNotEmpty) {
                      //         return Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             _ErrorBox(
                      //                 message:
                      //                     'Không thể tải danh sách người thân'),
                      //             const SizedBox(height: 8),
                      //             TextButton.icon(
                      //               onPressed: () {
                      //                 final main = _userStore.user.personalId ??
                      //                     _cccdController.text.trim();
                      //                 if (main.isNotEmpty) {
                      //                   _relativeCubit.load("037200009029");
                      //                 }
                      //               },
                      //               icon: const Icon(Icons.refresh, size: 18),
                      //               label: const Text('Thử lại'),
                      //               style: TextButton.styleFrom(
                      //                 foregroundColor:
                      //                     BookingColors.primaryBlue,
                      //               ),
                      //             ),
                      //           ],
                      //         );
                      //       }
                      //
                      //       final relatives = st.items;
                      //
                      //       // Tạo danh sách dropdown items
                      //       final dropdownItems = <DropdownMenuItem<int>>[
                      //         const DropdownMenuItem(
                      //           value: -1,
                      //           child: Row(
                      //             children: [
                      //               Icon(Icons.person,
                      //                   size: 20,
                      //                   color: BookingColors.primaryBlue),
                      //               SizedBox(width: 12),
                      //               Expanded(
                      //                 child: Column(
                      //                   crossAxisAlignment:
                      //                       CrossAxisAlignment.start,
                      //                   mainAxisSize: MainAxisSize.min,
                      //                   children: [
                      //                     Text(
                      //                       'Bản thân',
                      //                       style: TextStyle(
                      //                         fontWeight: FontWeight.w600,
                      //                         fontSize: 15,
                      //                       ),
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //         ...relatives.map((r) {
                      //           return DropdownMenuItem(
                      //             value: r.id,
                      //             child: Row(
                      //               children: [
                      //                 Icon(Icons.person_outline,
                      //                     size: 20,
                      //                     color: BookingColors.lightBlue),
                      //                 const SizedBox(width: 12),
                      //                 Expanded(
                      //                   child: Column(
                      //                     crossAxisAlignment:
                      //                         CrossAxisAlignment.start,
                      //                     mainAxisSize: MainAxisSize.min,
                      //                     children: [
                      //                       Text(
                      //                         "${r.fullName} - ${_getRelationship(r.relationship).label}",
                      //                         style: const TextStyle(
                      //                           fontWeight: FontWeight.w600,
                      //                           fontSize: 15,
                      //                         ),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           );
                      //         }).toList(),
                      //       ];
                      //
                      //       final currentValue = _selectedRelative?.id ?? -1;
                      //
                      //       return Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           DropdownButtonFormField<int>(
                      //             value: currentValue,
                      //             items: dropdownItems,
                      //             onChanged: (value) {
                      //               if (value == -1) {
                      //                 setState(() {
                      //                   _selectedRelative = null;
                      //                   _prefillFromUserStore();
                      //                 });
                      //               } else {
                      //                 final relative = relatives
                      //                     .firstWhere((r) => r.id == value);
                      //                 _fillFromRelative(relative);
                      //               }
                      //             },
                      //             decoration: InputDecoration(
                      //               labelText: 'Chọn người cần đặt khám',
                      //               filled: true,
                      //               fillColor: BookingColors.white,
                      //               contentPadding: const EdgeInsets.symmetric(
                      //                 vertical: 16,
                      //                 horizontal: 16,
                      //               ),
                      //               border: OutlineInputBorder(
                      //                 borderRadius: BorderRadius.circular(12),
                      //                 borderSide: const BorderSide(
                      //                     color: BookingColors.borderGray),
                      //               ),
                      //               enabledBorder: OutlineInputBorder(
                      //                 borderRadius: BorderRadius.circular(12),
                      //                 borderSide: const BorderSide(
                      //                     color: BookingColors.borderGray),
                      //               ),
                      //               focusedBorder: OutlineInputBorder(
                      //                 borderRadius: BorderRadius.circular(12),
                      //                 borderSide: const BorderSide(
                      //                   color: BookingColors.primaryBlue,
                      //                   width: 2,
                      //                 ),
                      //               ),
                      //               labelStyle: const TextStyle(
                      //                   color: BookingColors.textGray),
                      //             ),
                      //             isExpanded: true,
                      //             icon: const Icon(Icons.keyboard_arrow_down),
                      //             dropdownColor: BookingColors.white,
                      //             menuMaxHeight: 400,
                      //           ),
                      //           if (relatives.isEmpty) ...[
                      //             const SizedBox(height: 12),
                      //             Container(
                      //               padding: const EdgeInsets.all(12),
                      //               decoration: BoxDecoration(
                      //                 color: BookingColors.lightGray,
                      //                 borderRadius: BorderRadius.circular(10),
                      //               ),
                      //               child: Row(
                      //                 children: [
                      //                   Icon(
                      //                     Icons.info_outline,
                      //                     size: 18,
                      //                     color: BookingColors.textGray,
                      //                   ),
                      //                   const SizedBox(width: 10),
                      //                   Expanded(
                      //                     child: Text(
                      //                       'Thêm người thân trong hồ sơ để đặt khám nhanh hơn',
                      //                       style: const TextStyle(
                      //                         fontSize: 12,
                      //                         color: BookingColors.textGray,
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 ],
                      //               ),
                      //             ),
                      //           ],
                      //         ],
                      //       );
                      //     },
                      //   ),
                      // ),
                      //
                      // SizedBox(height: 20),

                      // Personal Information Section
                      _BlueWhiteCard(
                        title: 'Thông tin cá nhân',
                        icon: Icons.person_outline,
                        child: Column(
                          children: [
                            // QR Scan Button
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    BookingColors.primaryBlue,
                                    BookingColors.lightBlue,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: BookingColors.primaryBlue
                                        .withOpacity(0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: ElevatedButton.icon(
                                onPressed: _onScanQR,
                                icon: const Icon(
                                  Icons.qr_code_scanner,
                                  color: BookingColors.white,
                                ),
                                label: const Text(
                                  'Quét QR CCCD',
                                  style: TextStyle(
                                    color: BookingColors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Vui lòng kiểm tra kỹ lại các thông tin khi quét',
                              style: TextStyle(
                                fontSize: 13,
                                color: BookingColors.textGray,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),

                            // Name Field
                            TextField(
                              controller: _nameController,
                              decoration: _buildInputDecoration(
                                'Họ & tên *',
                                Icons.person,
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Phone Field
                            TextField(
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              decoration: _buildInputDecoration(
                                'Điện thoại *',
                                Icons.phone,
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Email Field
                            TextField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: _buildInputDecoration(
                                'Email',
                                Icons.email,
                              ),
                            ),
                            const SizedBox(height: 16),

                            // CCCD Field
                            TextField(
                              controller: _cccdController,
                              keyboardType: TextInputType.number,
                              decoration: _buildInputDecoration(
                                'CCCD *',
                                Icons.badge,
                              ),
                            ),
                            const SizedBox(height: 16),

                            // ID Issue Date
                            GestureDetector(
                              onTap: () {
                                picker.DatePicker.showDatePicker(
                                  context,
                                  showTitleActions: true,
                                  minTime: DateTime(2000, 1, 1),
                                  maxTime: DateTime.now(),
                                  currentTime: _idIssueAt ?? DateTime.now(),
                                  locale: picker.LocaleType.vi,
                                  onConfirm: (date) {
                                    setState(() {
                                      _idIssueAt = date;
                                      _idIssueDateController.text =
                                          DateFormat('dd/MM/yyyy').format(date);
                                    });
                                  },
                                );
                              },
                              child: AbsorbPointer(
                                child: TextField(
                                  controller: _idIssueDateController,
                                  decoration: _buildInputDecoration(
                                    'Ngày cấp CCCD *',
                                    Icons.calendar_today,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
// ID Issue Date
                            // ID Issue Place
                            TextField(
                              controller: _idIssuePlaceController,
                              decoration: _buildInputDecoration(
                                'Nơi cấp CCCD *',
                                Icons.location_on,
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Birth Date
                            GestureDetector(
                              onTap: () {
                                final now = DateTime.now();
                                DateTime current;
                                try {
                                  current = _birthDateController.text.isNotEmpty
                                      ? DateFormat('dd/MM/yyyy')
                                          .parseLoose(_birthDateController.text)
                                      : DateTime(
                                          now.year - 25,
                                          now.month,
                                          now.day,
                                        );
                                } catch (_) {
                                  current = DateTime(
                                    now.year - 25,
                                    now.month,
                                    now.day,
                                  );
                                }

                                picker.DatePicker.showDatePicker(
                                  context,
                                  showTitleActions: true,
                                  minTime: DateTime(1900, 1, 1),
                                  maxTime: DateTime.now(),
                                  currentTime: current,
                                  locale: picker.LocaleType.vi,
                                  onConfirm: (date) {
                                    setState(() {
                                      _birthDateController.text =
                                          DateFormat('dd/MM/yyyy').format(date);
                                      final years = DateTime.now()
                                              .difference(date)
                                              .inDays ~/
                                          365;
                                      _ageController.text = years.toString();
                                    });
                                  },
                                );
                              },
                              child: AbsorbPointer(
                                child: TextField(
                                  controller: _birthDateController,
                                  decoration: _buildInputDecoration(
                                    'Ngày sinh (dd/MM/yyyy) *',
                                    Icons.cake,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Age Field
                            TextField(
                              controller: _ageController,
                              enabled: false,
                              decoration: _buildInputDecoration(
                                'Tuổi *',
                                Icons.timelapse,
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Gender Dropdown
                            DropdownButtonFormField<String>(
                              value: _gender,
                              decoration: _buildInputDecoration(
                                'Giới tính',
                                Icons.wc,
                              ),
                              items: const [
                                DropdownMenuItem(
                                  value: 'Nam',
                                  child: Text('Nam'),
                                ),
                                DropdownMenuItem(
                                  value: 'Nữ',
                                  child: Text('Nữ'),
                                ),
                              ],
                              onChanged: (v) {
                                if (v != null) {
                                  setState(() => _gender = v);
                                }
                              },
                            ),
                            const SizedBox(height: 20),
                            BlocBuilder<BookingLocationCubit,
                                BookingLocationState>(
                              builder: (_, st) {
                                final cities = st.cities;
                                final wards = st.wards;

                                MailingCityItem? selectedCity;
                                if ((_selectedCityId ?? '').isNotEmpty) {
                                  try {
                                    selectedCity = cities.firstWhere(
                                        (x) => x.key == _selectedCityId);
                                  } catch (_) {
                                    selectedCity = null;
                                  }
                                }

                                MailingStateItem? selectedWard;
                                if ((_selectedWardId ?? '').isNotEmpty) {
                                  try {
                                    selectedWard = wards.firstWhere((x) =>
                                        x.mailingstate == _selectedWardId);
                                  } catch (_) {
                                    selectedWard = null;
                                  }
                                }

                                return Column(
                                  children: [
                                    // --- CITY: searchable ---
                                    DropdownSearch<MailingCityItem>(
                                      items: cities,
                                      selectedItem: selectedCity,
                                      itemAsString: (e) => e.label,
                                      compareFn: (a, b) => a.key == b.key,
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            _buildInputDecoration(
                                          'Tỉnh/TP *',
                                          Icons.location_city,
                                        ),
                                      ),
                                      popupProps: PopupProps.bottomSheet(
                                        showSearchBox: true,
                                        bottomSheetProps: BottomSheetProps(
                                          backgroundColor: Colors.white,
                                          elevation: 0,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(16)),
                                          ),
                                        ),
                                        searchDelay:
                                            const Duration(milliseconds: 150),
                                        searchFieldProps: TextFieldProps(
                                          decoration: InputDecoration(
                                            hintText: 'Tìm tỉnh/thành...',
                                            filled: true,
                                            fillColor: BookingColors.white,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 14,
                                                    horizontal: 14),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide: const BorderSide(
                                                  color:
                                                      AppColors.primaryColor),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide: const BorderSide(
                                                  color:
                                                      AppColors.primaryColor),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide: const BorderSide(
                                                  color:
                                                      AppColors.primaryColor),
                                            ),
                                            prefixIcon: const Icon(
                                              Icons.search,
                                              color: BookingColors.primaryBlue,
                                            ),
                                          ),
                                        ),
                                        itemBuilder:
                                            (context, item, isSelected) =>
                                                ListTile(
                                          title: Text(
                                            item.label,
                                            style: TextStyle(
                                              fontWeight: isSelected
                                                  ? FontWeight.w700
                                                  : FontWeight.w500,
                                              color: BookingColors.textDark,
                                            ),
                                          ),
                                        ),
                                      ),
                                      filterFn: (item, filter) => item.label
                                          .toLowerCase()
                                          .contains(filter.toLowerCase()),
                                      onChanged: (city) {
                                        setState(() {
                                          _selectedCityId = city?.key;
                                          _selectedWardId = null;
                                        });
                                        _locationCubit.selectCity(city?.key);
                                      },
                                    ),

                                    const SizedBox(height: 16),

                                    // --- WARD: searchable ---
                                    if (st.loadingWards)
                                      const LinearProgressIndicator(
                                        color: BookingColors.primaryBlue,
                                        backgroundColor:
                                            BookingColors.lightGray,
                                      )
                                    else
                                      DropdownSearch<MailingStateItem>(
                                        items: wards,
                                        selectedItem: selectedWard,
                                        itemAsString: (e) =>
                                            (e.label ?? e.displayLabel),
                                        compareFn: (a, b) =>
                                            a.mailingstate == b.mailingstate,
                                        dropdownDecoratorProps:
                                            DropDownDecoratorProps(
                                          dropdownSearchDecoration:
                                              _buildInputDecoration(
                                            'Xã/Phường *',
                                            Icons.map_outlined,
                                          ),
                                        ),
                                        popupProps: PopupProps.bottomSheet(
                                          showSearchBox: true,
                                          bottomSheetProps: BottomSheetProps(
                                            backgroundColor: Colors.white,
                                            elevation: 0,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                      top: Radius.circular(16)),
                                            ),
                                          ),
                                          searchDelay:
                                              const Duration(milliseconds: 150),
                                          searchFieldProps: TextFieldProps(
                                            decoration: InputDecoration(
                                              hintText: 'Tìm xã/phường...',
                                              filled: true,
                                              fillColor: BookingColors.white,
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 14,
                                                      horizontal: 14),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                borderSide: const BorderSide(
                                                    color:
                                                        AppColors.primaryColor),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                borderSide: const BorderSide(
                                                    color:
                                                        AppColors.primaryColor),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                borderSide: const BorderSide(
                                                    color:
                                                        AppColors.primaryColor),
                                              ),
                                              prefixIcon: const Icon(
                                                Icons.search,
                                                color:
                                                    BookingColors.primaryBlue,
                                              ),
                                            ),
                                          ),
                                          itemBuilder:
                                              (context, item, isSelected) =>
                                                  ListTile(
                                            title: Text(
                                              item.label ?? item.displayLabel,
                                              style: TextStyle(
                                                fontWeight: isSelected
                                                    ? FontWeight.w700
                                                    : FontWeight.w500,
                                                color: BookingColors.textDark,
                                              ),
                                            ),
                                          ),
                                        ),
                                        filterFn: (item, filter) {
                                          final s =
                                              (item.label ?? item.displayLabel)
                                                  .toLowerCase();
                                          return s
                                              .contains(filter.toLowerCase());
                                        },
                                        onChanged: (ward) {
                                          setState(() => _selectedWardId =
                                              ward?.mailingstate);
                                          _locationCubit
                                              .selectWard(ward?.mailingstate);
                                        },
                                      ),
                                  ],
                                );
                              },
                            ),

                            // BlocBuilder<BookingLocationCubit,
                            //     BookingLocationState>(
                            //   builder: (_, st) {
                            //     final cities = st.cities;
                            //     final wards = st.wards;
                            //
                            //     return Column(
                            //       children: [
                            //         DropdownButtonFormField<String>(
                            //           value: _selectedCityId,
                            //           decoration: _buildInputDecoration(
                            //               'Tỉnh/TP *', Icons.location_city),
                            //           items: cities
                            //               .map((e) => DropdownMenuItem(
                            //                     value: e.key,
                            //                     child: Text(e.label),
                            //                   ))
                            //               .toList(),
                            //           onChanged: (v) {
                            //             setState(() {
                            //               _selectedCityId = v;
                            //               _selectedWardId = null;
                            //             });
                            //             _locationCubit.selectCity(v);
                            //           },
                            //         ),
                            //         const SizedBox(height: 16),
                            //         if (st.loadingWards)
                            //           const LinearProgressIndicator(
                            //             color: BookingColors.primaryBlue,
                            //             backgroundColor:
                            //                 BookingColors.lightGray,
                            //           )
                            //         else
                            //           DropdownButtonFormField<String>(
                            //             value: _selectedWardId,
                            //             decoration: _buildInputDecoration(
                            //                 'Xã/Phường *', Icons.map_outlined),
                            //             items: wards
                            //                 .map((e) => DropdownMenuItem(
                            //                       value: e.mailingstate,
                            //                       child: Text(e.label ?? "-"),
                            //                     ))
                            //                 .toList(),
                            //             onChanged: (v) {
                            //               setState(() => _selectedWardId = v);
                            //               _locationCubit.selectWard(v);
                            //             },
                            //           ),
                            //       ],
                            //     );
                            //   },
                            // ),
                            const SizedBox(height: 16),
                            TextField(
                              controller: _streetController,
                              decoration: _buildInputDecoration(
                                  'Địa chỉ cụ thể', Icons.home_outlined),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Service Section
                      _BlueWhiteCard(
                        title: 'Dịch vụ khám',
                        icon: Icons.medical_services,
                        child: BlocBuilder<LeadServiceCubit, LeadServiceState>(
                          builder: (_, st) {
                            if (st is LeadServiceLoading) {
                              return const LinearProgressIndicator(
                                color: BookingColors.primaryBlue,
                                backgroundColor: BookingColors.lightGray,
                              );
                            }
                            if (st is LeadServiceLoaded) {
                              return DropdownButtonFormField<LeadService>(
                                value: _selectedService,
                                items: st.list
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e.name),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (v) =>
                                    setState(() => _selectedService = v),
                                decoration: _buildInputDecoration(
                                  'Chọn dịch vụ *',
                                  Icons.local_hospital,
                                ),
                              );
                            }
                            if (st is LeadServiceError) {
                              return const _ErrorBox(
                                message: 'Không thể tải dịch vụ',
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Date Section (no time slot)
                      _BlueWhiteCard(
                        title: 'Thời gian khám',
                        icon: Icons.calendar_month,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color:
                                    BookingColors.primaryBlue.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: BookingColors.primaryBlue
                                      .withOpacity(0.2),
                                ),
                              ),
                              child: ListTile(
                                leading: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: BookingColors.primaryBlue,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(
                                    Icons.calendar_today,
                                    color: BookingColors.white,
                                    size: 20,
                                  ),
                                ),
                                title: const Text(
                                  'Ngày khám',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: BookingColors.textGray,
                                  ),
                                ),
                                subtitle: Text(
                                  DateFormat('EEEE, dd/MM/yyyy', 'vi')
                                      .format(_visitDate),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: BookingColors.textDark,
                                  ),
                                ),
                                trailing: Container(
                                  decoration: BoxDecoration(
                                    color: BookingColors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: BookingColors.primaryBlue
                                          .withOpacity(0.3),
                                    ),
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      picker.DatePicker.showDatePicker(
                                        context,
                                        showTitleActions: true,
                                        minTime: DateTime.now(),
                                        currentTime: _visitDate,
                                        locale: picker.LocaleType.vi,
                                        onConfirm: (date) {
                                          setState(() => _visitDate = date);
                                        },
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.edit_calendar,
                                      color: BookingColors.primaryBlue,
                                      size: 22,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      // _BlueWhiteCard(
                      //   title: 'Địa chỉ',
                      //   icon: Icons.location_on_outlined,
                      //   child: BlocBuilder<BookingLocationCubit,
                      //       BookingLocationState>(
                      //     builder: (_, st) {
                      //       final cities = st.cities;
                      //       final wards = st.wards;
                      //
                      //       return Column(
                      //         children: [
                      //           DropdownButtonFormField<String>(
                      //             value: _selectedCityId,
                      //             decoration: _buildInputDecoration(
                      //                 'Tỉnh/TP *', Icons.location_city),
                      //             items: cities
                      //                 .map((e) => DropdownMenuItem(
                      //                       value: e.id,
                      //                       child: Text(e.name),
                      //                     ))
                      //                 .toList(),
                      //             onChanged: (v) {
                      //               setState(() {
                      //                 _selectedCityId = v;
                      //                 _selectedWardId = null;
                      //               });
                      //               _locationCubit.selectCity(v);
                      //             },
                      //           ),
                      //           const SizedBox(height: 16),
                      //           if (st.loadingWards)
                      //             const LinearProgressIndicator(
                      //               color: BookingColors.primaryBlue,
                      //               backgroundColor: BookingColors.lightGray,
                      //             )
                      //           else
                      //             DropdownButtonFormField<String>(
                      //               value: _selectedWardId,
                      //               decoration: _buildInputDecoration(
                      //                   'Xã/Phường *', Icons.map_outlined),
                      //               items: wards
                      //                   .map((e) => DropdownMenuItem(
                      //                         value: e.id,
                      //                         child: Text(e.name),
                      //                       ))
                      //                   .toList(),
                      //               onChanged: (v) {
                      //                 setState(() => _selectedWardId = v);
                      //                 _locationCubit.selectWard(v);
                      //               },
                      //             ),
                      //           const SizedBox(height: 16),
                      //           TextField(
                      //             controller: _streetController,
                      //             decoration: _buildInputDecoration(
                      //                 'Địa chỉ cụ thể *', Icons.home_outlined),
                      //           ),
                      //         ],
                      //       );
                      //     },
                      //   ),
                      // ),
                      // const SizedBox(height: 20),

                      // Notes Section
                      _BlueWhiteCard(
                        title: 'Ghi chú',
                        icon: Icons.note_alt,
                        child: TextField(
                          controller: _noteController,
                          minLines: 3,
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText:
                                'VD: Sốt nhẹ, đau đầu, cần khám tổng quát...',
                            hintStyle: const TextStyle(
                              color: BookingColors.textGray,
                            ),
                            filled: true,
                            fillColor: BookingColors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: BookingColors.borderGray,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: BookingColors.borderGray,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: BookingColors.primaryBlue,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                      //const SizedBox(height: 20),

                      // History Section
                      // _BlueWhiteCard(
                      //   title: 'Lịch sử đặt lịch',
                      //   icon: Icons.history,
                      //   child: BlocBuilder<BookingHistoryCubit,
                      //       BookingHistoryState>(
                      //     builder: (_, st) {
                      //       if (st is BookingHistoryLoading) {
                      //         return const LinearProgressIndicator(
                      //           color: BookingColors.primaryBlue,
                      //           backgroundColor: BookingColors.lightGray,
                      //         );
                      //       }
                      //       if (st is BookingHistoryLoaded) {
                      //         if (st.list.isEmpty) {
                      //           return Container(
                      //             padding: const EdgeInsets.all(16),
                      //             decoration: BoxDecoration(
                      //               color: BookingColors.lightGray,
                      //               borderRadius: BorderRadius.circular(12),
                      //             ),
                      //             child: const Row(
                      //               children: [
                      //                 Icon(
                      //                   Icons.inbox_outlined,
                      //                   color: BookingColors.textGray,
                      //                 ),
                      //                 SizedBox(width: 12),
                      //                 Text(
                      //                   'Chưa có lịch sử đặt lịch',
                      //                   style: TextStyle(
                      //                     color: BookingColors.textGray,
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           );
                      //         }
                      //         return Column(
                      //           children: st.list.take(3).map((h) {
                      //             return Container(
                      //               margin: const EdgeInsets.only(bottom: 12),
                      //               decoration: BoxDecoration(
                      //                 color: BookingColors.white,
                      //                 borderRadius: BorderRadius.circular(12),
                      //                 border: Border.all(
                      //                   color: BookingColors.borderGray,
                      //                 ),
                      //               ),
                      //               child: ListTile(
                      //                 contentPadding: const EdgeInsets.all(14),
                      //                 leading: Container(
                      //                   padding: const EdgeInsets.all(10),
                      //                   decoration: BoxDecoration(
                      //                     color: BookingColors.primaryBlue
                      //                         .withOpacity(0.1),
                      //                     borderRadius:
                      //                         BorderRadius.circular(10),
                      //                   ),
                      //                   child: const Icon(
                      //                     Icons.medical_information,
                      //                     color: BookingColors.primaryBlue,
                      //                   ),
                      //                 ),
                      //                 title: Text(
                      //                   '${h.patientName} • ${h.serviceName}',
                      //                   style: const TextStyle(
                      //                     fontWeight: FontWeight.w600,
                      //                     color: BookingColors.textDark,
                      //                   ),
                      //                 ),
                      //                 subtitle: Padding(
                      //                   padding:
                      //                       const EdgeInsets.only(top: 6.0),
                      //                   child: Column(
                      //                     crossAxisAlignment:
                      //                         CrossAxisAlignment.start,
                      //                     children: [
                      //                       Text(
                      //                         '📍 ${h.branch}',
                      //                         style:
                      //                             const TextStyle(fontSize: 13),
                      //                       ),
                      //                       Text(
                      //                         '📅 ${h.visitTimeIso.toDdMmYyyyHHmm()}',
                      //                         style:
                      //                             const TextStyle(fontSize: 13),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //                 trailing: Container(
                      //                   padding: const EdgeInsets.symmetric(
                      //                     horizontal: 10,
                      //                     vertical: 6,
                      //                   ),
                      //                   decoration: BoxDecoration(
                      //                     color: _getStatusColor(h.status)
                      //                         .withOpacity(0.1),
                      //                     borderRadius:
                      //                         BorderRadius.circular(8),
                      //                   ),
                      //                   child: Text(
                      //                     h.status,
                      //                     style: TextStyle(
                      //                       color: _getStatusColor(h.status),
                      //                       fontWeight: FontWeight.w600,
                      //                       fontSize: 12,
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             );
                      //           }).toList(),
                      //         );
                      //       }
                      //       if (st is BookingHistoryError) {
                      //         return const _ErrorBox(
                      //           message: "Lỗi tạo lịch hẹn",
                      //         );
                      //       }
                      //       return const SizedBox.shrink();
                      //     },
                      //   ),
                      // ),
                    ],
                  ),
                ),

                // Bottom Submit Button
                SafeArea(
                  top: false,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: BookingColors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 16,
                          offset: const Offset(0, -4),
                        )
                      ],
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    child: BlocBuilder<BookingSubmitCubit, BookingSubmitState>(
                      builder: (_, st) {
                        final loading = st is BookingSubmitting;
                        return Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                BookingColors.primaryBlue,
                                BookingColors.lightBlue,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    BookingColors.primaryBlue.withOpacity(0.4),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ElevatedButton.icon(
                            onPressed: loading
                                ? null
                                : () {
                                    _unfocusAll();
                                    _confirmAndSubmit();
                                  },
                            icon: loading
                                ? const SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        BookingColors.white,
                                      ),
                                    ),
                                  )
                                : const Icon(
                                    Icons.check_circle,
                                    color: BookingColors.white,
                                  ),
                            label: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: Text(
                                loading ? 'Đang xử lý...' : 'Xác nhận đặt lịch',
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: BookingColors.white,
                                ),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              minimumSize: const Size(double.infinity, 56),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
      case 'đã xác nhận':
        return BookingColors.primaryBlue;
      case 'pending':
      case 'chờ xác nhận':
        return Colors.orange;
      case 'cancelled':
      case 'đã hủy':
        return Colors.red;
      default:
        return BookingColors.textGray;
    }
  }

  ({IconData icon, String label, Color color}) _getRelationship(String? code) =>
      switch (code) {
        'CHA' => (
            icon: Icons.male_rounded,
            label: 'Cha',
            color: const Color(0xFF2563EB)
          ),
        'MẸ' || 'ME' => (
            icon: Icons.female_rounded,
            label: 'Mẹ',
            color: const Color(0xFFEC4899)
          ),
        'CON' => (
            icon: Icons.child_care_rounded,
            label: 'Con',
            color: const Color(0xFF16A34A)
          ),
        'VO_CHONG' => (
            icon: Icons.favorite_rounded,
            label: 'Vợ/Chồng',
            color: const Color(0xFFD946EF)
          ),
        'ANH_CHI_EM' => (
            icon: Icons.groups_rounded,
            label: 'Anh chị em',
            color: const Color(0xFFF97316)
          ),
        'ONG_BA' => (
            icon: Icons.elderly_rounded,
            label: 'Ông bà',
            color: const Color(0xFF8B5CF6)
          ),
        _ => (
            icon: Icons.person_rounded,
            label: 'Người thân',
            color: AppColors.primaryColor
          ),
      };
}

// ---------- Blue & White Card Widget ----------

class _BlueWhiteCard extends StatelessWidget {
  const _BlueWhiteCard({
    required this.title,
    required this.child,
    required this.icon,
  });

  final String title;
  final Widget child;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: BookingColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // nếu muốn hiển thị header card thì mở comment
            // Row(
            //   children: [
            //     Container(
            //       padding: const EdgeInsets.all(10),
            //       decoration: BoxDecoration(
            //         gradient: const LinearGradient(
            //           colors: [
            //             BookingColors.primaryBlue,
            //             BookingColors.lightBlue,
            //           ],
            //         ),
            //         borderRadius: BorderRadius.circular(12),
            //       ),
            //       child: Icon(icon, color: BookingColors.white, size: 22),
            //     ),
            //     const SizedBox(width: 12),
            //     Text(
            //       title,
            //       style: const TextStyle(
            //         fontSize: 17,
            //         fontWeight: FontWeight.w700,
            //         color: BookingColors.textDark,
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(height: 18),
            child,
          ],
        ),
      ),
    );
  }
}

class _ErrorBox extends StatelessWidget {
  const _ErrorBox({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Row(
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.red.shade700,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: Colors.red.shade900,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 18, color: BookingColors.primaryBlue),
          const SizedBox(width: 8),
          Text(
            '$label: ',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: BookingColors.textDark,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: BookingColors.textGray),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReviewSheet extends StatelessWidget {
  const _ReviewSheet({
    required this.name,
    required this.phone,
    required this.email,
    required this.service,
    required this.branch,
    required this.dateStr,
    required this.timeStr,
    required this.idIssueStr,
    required this.note,
  });

  final String name,
      phone,
      email,
      service,
      branch,
      dateStr,
      timeStr,
      idIssueStr,
      note;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: BookingColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            top: 12,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: BookingColors.textGray.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      BookingColors.primaryBlue,
                      BookingColors.lightBlue,
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.assignment_turned_in,
                  size: 34,
                  color: BookingColors.white,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Xác nhận thông tin đặt lịch',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: BookingColors.textDark,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Vui lòng kiểm tra kỹ thông tin trước khi xác nhận',
                style: TextStyle(
                  color: BookingColors.textGray,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: BookingColors.lightGray,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: BookingColors.borderGray,
                  ),
                ),
                child: Column(
                  children: [
                    _ReviewRow(
                      icon: Icons.person,
                      label: 'Họ tên',
                      value: name,
                    ),
                    _ReviewRow(
                      icon: Icons.phone,
                      label: 'Số điện thoại',
                      value: phone,
                    ),
                    if (email.isNotEmpty)
                      _ReviewRow(
                        icon: Icons.email,
                        label: 'Email',
                        value: email,
                      ),
                    _ReviewRow(
                      icon: Icons.medical_services,
                      label: 'Dịch vụ',
                      value: service,
                    ),
                    _ReviewRow(
                      icon: Icons.location_on,
                      label: 'Cơ sở',
                      value: branch,
                    ),
                    _ReviewRow(
                      icon: Icons.calendar_today,
                      label: 'Ngày khám',
                      value: dateStr,
                    ),
                    if (note.isNotEmpty)
                      _ReviewRow(
                        icon: Icons.note,
                        label: 'Mô tả bệnh',
                        value: note,
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => Navigator.pop(context, false),
                      icon: const Icon(
                        Icons.edit,
                        color: BookingColors.primaryBlue,
                      ),
                      label: const Text(
                        'Chỉnh sửa',
                        style: TextStyle(
                          color: BookingColors.primaryBlue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: const BorderSide(
                          color: BookingColors.primaryBlue,
                          width: 2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            BookingColors.primaryBlue,
                            BookingColors.lightBlue,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: BookingColors.primaryBlue.withOpacity(0.4),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ElevatedButton.icon(
                        onPressed: () => Navigator.pop(context, true),
                        icon: const Icon(
                          Icons.check_circle,
                          color: BookingColors.white,
                        ),
                        label: const Text(
                          'Xác nhận đặt lịch',
                          style: TextStyle(
                            color: BookingColors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReviewRow extends StatelessWidget {
  const _ReviewRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: BookingColors.primaryBlue),
          const SizedBox(width: 12),
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: BookingColors.textGray,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: BookingColors.textDark,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SuccessSheet extends StatelessWidget {
  const _SuccessSheet({
    required this.title,
    required this.note1,
    required this.note2,
    required this.hospital,
    required this.service,
    required this.timeStr,
    required this.onHome,
    this.symptom,
  });

  final String title;
  final String note1;
  final String note2;
  final String hospital;
  final String service;
  final String timeStr;
  final String? symptom;
  final VoidCallback onHome;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 6),
          Container(
            width: 64,
            height: 64,
            decoration: const BoxDecoration(
              color: Color(0xFFE8F3FF),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_rounded,
              size: 36,
              color: BookingColors.primaryBlue,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: BookingColors.textDark,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            note1,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: BookingColors.textGray,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            note2,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: BookingColors.textGray,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: BookingColors.lightGray,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: BookingColors.borderGray),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _kv('Nơi khám', hospital),
                const SizedBox(height: 8),
                _kv('Bác sĩ / dịch vụ', service),
                const SizedBox(height: 8),
                _kv('Ngày', timeStr),
                if ((symptom ?? '').isNotEmpty) ...[
                  const SizedBox(height: 8),
                  _kv('Triệu chứng', symptom!),
                ],
              ],
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onHome,
              style: ElevatedButton.styleFrom(
                backgroundColor: BookingColors.white,
                foregroundColor: BookingColors.primaryBlue,
                elevation: 0,
                side: const BorderSide(
                  color: BookingColors.primaryBlue,
                  width: 2,
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Trang chủ',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _kv(String k, String v) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130,
          child: Text(
            k,
            style: const TextStyle(
              color: BookingColors.textGray,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            v,
            style: const TextStyle(
              color: BookingColors.textDark,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
