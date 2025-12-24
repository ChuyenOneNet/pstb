// // import 'package:flutter/material.dart';
// // import 'package:flutter_modular/flutter_modular.dart';
// // import 'package:fluttertoast/fluttertoast.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// //
// // import 'package:pstb/app/modules/business/business_store.dart';
// // import 'package:pstb/app/user_app_store.dart';
// // import 'package:pstb/di/locator.dart';
// //
// // import '../../../../utils/colors.dart';
// // import '../../../../utils/images.dart';
// // import '../../../../utils/routes.dart';
// // import '../../../../widgets/stateless/app_bar.dart';
// //
// // // TODO: chỉnh lại path cho đúng với project của bạn
// // import 'package:pstb/feature/relatives/data/models/relative_model.dart';
// // import 'package:pstb/feature/relatives/presentation/cubit/relative_list_cubit.dart';
// //
// // class BusinessLoginPage extends StatefulWidget {
// //   const BusinessLoginPage({Key? key});
// //
// //   @override
// //   State<BusinessLoginPage> createState() => _BusinessLoginPageState();
// // }
// //
// // class _BusinessLoginPageState extends State<BusinessLoginPage> {
// //   final BusinessStore store = Modular.get<BusinessStore>();
// //   final UserAppStore _userAppStore = Modular.get<UserAppStore>();
// //
// //   late final RelativeListCubit _relativeCubit;
// //
// //   bool _isBusy = false;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _relativeCubit = serviceLocator<RelativeListCubit>();
// //     _loadRelatives();
// //   }
// //
// //   Future<void> _loadRelatives() async {
// //     final mainCccd = "037200009029";
// //     //_userAppStore.user.personalId ?? '';
// //     if (mainCccd.isEmpty) {
// //       Fluttertoast.showToast(
// //         msg: 'Không tìm thấy CCCD của tài khoản chính',
// //       );
// //       return;
// //     }
// //     await _relativeCubit.load(mainCccd);
// //   }
// //
// //   Future<void> _loginWithPatientCode(String patientCode) async {
// //     if (_isBusy) return;
// //     if (patientCode.isEmpty) {
// //       Fluttertoast.showToast(msg: 'Người này chưa có mã bệnh nhân');
// //       return;
// //     }
// //
// //     setState(() => _isBusy = true);
// //     try {
// //       final ok = await store.getUserBusiness(
// //         maYte: patientCode,
// //         password: patientCode,
// //       );
// //       if (!ok) {
// //         Fluttertoast.showToast(msg: 'Đăng nhập thất bại');
// //         return;
// //       }
// //       if (!mounted) return;
// //       Fluttertoast.showToast(msg: 'Đăng nhập thành công');
// //       Modular.to.pushReplacementNamed(AppRoutes.businessPage);
// //     } catch (_) {
// //       Fluttertoast.showToast(msg: 'Đăng nhập thất bại');
// //     } finally {
// //       if (mounted) setState(() => _isBusy = false);
// //     }
// //   }
// //
// //   @override
// //   void dispose() {
// //     _relativeCubit.close();
// //     super.dispose();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return BlocProvider.value(
// //       value: _relativeCubit,
// //       child: Scaffold(
// //         appBar: CustomAppBar(
// //           title: 'Hồ sơ sức khỏe',
// //           isBack: true,
// //         ),
// //         backgroundColor: Colors.white,
// //         body: Column(
// //           children: [
// //             if (_isBusy)
// //               const LinearProgressIndicator(
// //                 minHeight: 2,
// //               ),
// //             Expanded(
// //               child: SingleChildScrollView(
// //                 padding: const EdgeInsets.symmetric(horizontal: 24),
// //                 child: Column(
// //                   mainAxisAlignment: MainAxisAlignment.start,
// //                   children: [
// //                     const SizedBox(height: 10),
// //                     SizedBox(
// //                       height: 110,
// //                       width: 110,
// //                       child: Image.asset(ImageEnum.logopstbColor),
// //                     ),
// //                     const SizedBox(height: 12),
// //                     const Text(
// //                       'CỔNG TRA CỨU Y BẠ ĐIỆN TỬ\nBỆNH VIỆN Phụ Sản Thái Bình',
// //                       textAlign: TextAlign.center,
// //                       style: TextStyle(
// //                         fontWeight: FontWeight.bold,
// //                         fontSize: 15,
// //                         color: AppColors.primary,
// //                       ),
// //                     ),
// //                     const SizedBox(height: 24),
// //                     _buildPatientSelector(),
// //                     const SizedBox(height: 24),
// //                     const Text(
// //                       'Phát triển bởi Công ty cổ phần Onenet\n'
// //                       'Địa chỉ: Số 2 Nguyễn Hoàng, Nam Từ Liêm, Hà Nội\n',
// //                       //'Hotline: 0363.832.057 ',
// //                       textAlign: TextAlign.center,
// //                       style: TextStyle(fontSize: 12, color: Colors.black87),
// //                     ),
// //                     const SizedBox(height: 24),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   // ================== DANH SÁCH BẢN THÂN + NGƯỜI THÂN ==================
// //
// //   Widget _buildPatientSelector() {
// //     return BlocBuilder<RelativeListCubit, RelativeListState>(
// //       builder: (context, state) {
// //         if (state.loading && state.items.isEmpty) {
// //           return _buildLoadingList();
// //         }
// //
// //         if (state.items.isEmpty) {
// //           return Column(
// //             children: const [
// //               Icon(Icons.group_off_outlined, size: 64, color: Colors.grey),
// //               SizedBox(height: 8),
// //               Text(
// //                 'Chưa có thông tin bản thân / người thân\nđể tra cứu hồ sơ bệnh án.',
// //                 textAlign: TextAlign.center,
// //                 style: TextStyle(fontSize: 13),
// //               ),
// //             ],
// //           );
// //         }
// //
// //         final items = state.items;
// //
// //         return Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             const Text(
// //               'Chọn người để xem hồ sơ bệnh án',
// //               style: TextStyle(
// //                 fontWeight: FontWeight.w600,
// //                 fontSize: 14,
// //               ),
// //             ),
// //             const SizedBox(height: 8),
// //             ListView.separated(
// //               shrinkWrap: true,
// //               physics: const NeverScrollableScrollPhysics(),
// //               itemCount: items.length,
// //               separatorBuilder: (_, __) => const SizedBox(height: 8),
// //               itemBuilder: (context, index) {
// //                 final r = items[index];
// //                 final isSelf = index == 0; // phần tử đầu tiên là bản thân
// //                 return _buildPatientCard(r, isSelf);
// //               },
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }
// //
// //   Widget _buildLoadingList() {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         const Text(
// //           'Chọn người để xem hồ sơ bệnh án',
// //           style: TextStyle(
// //             fontWeight: FontWeight.w600,
// //             fontSize: 14,
// //           ),
// //         ),
// //         const SizedBox(height: 8),
// //         Column(
// //           children: List.generate(
// //             3,
// //             (index) => Container(
// //               margin: const EdgeInsets.only(bottom: 8),
// //               height: 72,
// //               decoration: BoxDecoration(
// //                 color: Colors.grey[200],
// //                 borderRadius: BorderRadius.circular(16),
// //               ),
// //             ),
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// //
// //   Widget _buildPatientCard(RelativeModel r, bool isSelf) {
// //     final pc = r.patientCode;
// //     final title = isSelf ? 'Bản thân' : r.fullName;
// //     final subtitle =
// //         isSelf ? 'Mã BN: ${r.patientCode}' : 'Mã BN: ${r.patientCode}';
// //
// //     return GestureDetector(
// //       onTap: _isBusy ? null : () => _loginWithPatientCode("25042411"),
// //       //_loginWithPatientCode(pc),
// //       child: Container(
// //         padding: const EdgeInsets.all(12),
// //         decoration: BoxDecoration(
// //           color: Colors.white,
// //           borderRadius: BorderRadius.circular(16),
// //           border: Border.all(
// //             color: isSelf ? AppColors.primary : Colors.grey[300]!,
// //           ),
// //           boxShadow: [
// //             BoxShadow(
// //               color: Colors.black.withOpacity(0.04),
// //               blurRadius: 8,
// //               offset: const Offset(0, 2),
// //             ),
// //           ],
// //         ),
// //         child: Row(
// //           children: [
// //             CircleAvatar(
// //               radius: 22,
// //               backgroundColor: AppColors.primary.withOpacity(0.08),
// //               child: Icon(
// //                 isSelf ? Icons.person : Icons.family_restroom,
// //                 size: 22,
// //                 color: AppColors.primary,
// //               ),
// //             ),
// //             const SizedBox(width: 12),
// //             Expanded(
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Row(
// //                     children: [
// //                       Expanded(
// //                         child: Text(
// //                           title,
// //                           maxLines: 1,
// //                           overflow: TextOverflow.ellipsis,
// //                           style: TextStyle(
// //                             fontWeight:
// //                                 isSelf ? FontWeight.w700 : FontWeight.w600,
// //                             fontSize: 14,
// //                           ),
// //                         ),
// //                       ),
// //                       if (isSelf)
// //                         Container(
// //                           padding: const EdgeInsets.symmetric(
// //                             horizontal: 8,
// //                             vertical: 2,
// //                           ),
// //                           decoration: BoxDecoration(
// //                             color: AppColors.primary.withOpacity(0.08),
// //                             borderRadius: BorderRadius.circular(999),
// //                           ),
// //                           child: Text(
// //                             'Tài khoản chính',
// //                             style: TextStyle(
// //                               fontSize: 11,
// //                               color: AppColors.primary,
// //                               fontWeight: FontWeight.w500,
// //                             ),
// //                           ),
// //                         ),
// //                     ],
// //                   ),
// //                   const SizedBox(height: 4),
// //                   Text(
// //                     subtitle,
// //                     maxLines: 1,
// //                     overflow: TextOverflow.ellipsis,
// //                     style: const TextStyle(fontSize: 12, color: Colors.black54),
// //                   ),
// //                   const SizedBox(height: 2),
// //                   const Text(
// //                     'Nhấn để đăng nhập và xem hồ sơ bệnh án',
// //                     style: TextStyle(fontSize: 11, color: Colors.black45),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //             const SizedBox(width: 8),
// //             const Icon(Icons.chevron_right, color: Colors.black38),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// import 'package:flutter/material.dart';
// import 'package:flutter_modular/flutter_modular.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:pstb/app/modules/business/business_store.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // ✅ secure password
//
// import '../../../../utils/colors.dart';
// import '../../../../utils/images.dart';
// import '../../../../utils/routes.dart';
// import '../../../../widgets/stateless/app_bar.dart';
//
// class BusinessLoginPage extends StatefulWidget {
//   const BusinessLoginPage({Key? key});
//
//   @override
//   State<BusinessLoginPage> createState() => _BusinessLoginPageState();
// }
//
// class _BusinessLoginPageState extends State<BusinessLoginPage> {
//   final _idController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final BusinessStore store = Modular.get<BusinessStore>();
//
//   // ✅ secure storage cho password
//   final FlutterSecureStorage _secure = const FlutterSecureStorage();
//
//   // Tránh bấm nhiều lần, giúp hiển thị loading
//   bool _isBusy = false;
//
//   // Khóa lưu trữ
//   static const _kIdKey = 'maYte';
//   static const _kPwKey = 'passwordBusiness';
//
//   @override
//   void initState() {
//     super.initState();
//     _loadAndAutoLogin(); // ✅ đọc & tự đăng nhập nếu có
//   }
//
//   Future<void> _loadAndAutoLogin() async {
//     final prefs = await SharedPreferences.getInstance();
//     final savedId = prefs.getString(_kIdKey);
//     final savedPw = await _secure.read(key: _kPwKey);
//
//     if ((savedId ?? '').isNotEmpty && (savedPw ?? '').isNotEmpty) {
//       _idController.text = savedId!;
//       _passwordController.text = savedPw!;
//       await _login(maYte: savedId, password: savedPw!, auto: true);
//     }
//   }
//
//   Future<void> _saveCredentials(String maYte, String password) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_kIdKey, maYte);
//     await _secure.write(key: _kPwKey, value: password);
//   }
//
//   Future<void> _clearSaved() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove(_kIdKey);
//     await _secure.delete(key: _kPwKey);
//     Fluttertoast.showToast(msg: 'Đã xoá tài khoản đã lưu');
//   }
//
//   Future<void> _login({
//     required String maYte,
//     required String password,
//     bool auto = false,
//   }) async {
//     if (_isBusy) return;
//     setState(() => _isBusy = true);
//
//     try {
//       final success =
//           await store.getUserBusiness(maYte: maYte, password: password);
//
//       if (!success) throw Exception('Sai tài khoản hoặc mật khẩu');
//
//       await _saveCredentials(maYte, password);
//
//       if (!mounted) return;
//       if (!auto) Fluttertoast.showToast(msg: 'Đăng nhập thành công');
//       Modular.to.pushReplacementNamed(AppRoutes.businessPage);
//     } catch (e) {
//       if (!auto) Fluttertoast.showToast(msg: 'Đăng nhập thất bại');
//     } finally {
//       if (mounted) setState(() => _isBusy = false);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         title: 'Hồ sơ sức khỏe',
//         isBack: true,
//       ),
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 24),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             SizedBox(
//               height: 140,
//               width: 140,
//               child: Image.asset(ImageEnum.logopstbColor),
//             ),
//             const SizedBox(height: 12),
//             const Text(
//               'CỔNG TRA CỨU Y BẠ ĐIỆN TỬ\nBệnh Viện Phụ sản Thái Bình',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16,
//                 color: AppColors.primary,
//               ),
//             ),
//             const SizedBox(height: 24),
//
//             TextField(
//               controller: _idController,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(
//                 prefixIcon: Icon(Icons.person),
//                 labelText: 'Mã',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 16),
//
//             TextField(
//               controller: _passwordController,
//               obscureText: true,
//               decoration: const InputDecoration(
//                 prefixIcon: Icon(Icons.lock),
//                 labelText: 'Mật khẩu',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 24),
//
//             SizedBox(
//               width: double.infinity,
//               height: 48,
//               child: ElevatedButton(
//                 onPressed: _isBusy
//                     ? null
//                     : () async {
//                         final maYte = _idController.text.trim();
//                         final password = _passwordController.text.trim();
//
//                         if (maYte.isEmpty || password.isEmpty) {
//                           Fluttertoast.showToast(
//                               msg: 'Vui lòng nhập đầy đủ thông tin');
//                           return;
//                         }
//                         await _login(maYte: maYte, password: password);
//                       },
//                 style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.primary),
//                 child: _isBusy
//                     ? const SizedBox(
//                         width: 18,
//                         height: 18,
//                         child: CircularProgressIndicator(
//                             strokeWidth: 2, color: Colors.white))
//                     : const Text('Đăng Nhập',
//                         style: TextStyle(color: Colors.white)),
//               ),
//             ),
//
//             const SizedBox(height: 12),
//
//             GestureDetector(
//               onTap: () =>
//                   Modular.to.pushNamed(AppRoutes.resetPasswordBusiness),
//               child: const Text(
//                 'Đặt lại mật khẩu',
//                 style: TextStyle(
//                     decoration: TextDecoration.underline, color: Colors.blue),
//               ),
//             ),
//
//             const SizedBox(height: 8),
//
//             // (tuỳ chọn) Nút xoá thông tin đã lưu
//             TextButton(
//               onPressed: _clearSaved,
//               child: const Text(
//                 'Xoá tài khoản đã lưu',
//                 style: TextStyle(color: Colors.red),
//               ),
//             ),
//
//             const SizedBox(height: 24),
//             const Text(
//               'Phát triển bởi Công ty cổ phần Onenet\n'
//               'Địa chỉ: Số 2 Nguyễn Hoàng, Nam Từ Liêm, Hà Nội\n',
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 12, color: Colors.black87),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:pstb/app/modules/business/business_store.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/images.dart';
import '../../../../utils/routes.dart';
import '../../../../widgets/stateless/app_bar.dart';

class BusinessLoginPage extends StatefulWidget {
  const BusinessLoginPage({Key? key});

  @override
  State<BusinessLoginPage> createState() => _BusinessLoginPageState();
}

class _BusinessLoginPageState extends State<BusinessLoginPage> {
  final BusinessStore store = Modular.get<BusinessStore>();

  final _patientCodeCtrl = TextEditingController();
  bool _isBusy = false;

  // OTP state
  String? _serverOtp; // OTP trả về từ API send-sms
  DateTime? _lastOtpTime;
  int _otpAttemptsToday = 0;

  final ValueNotifier<int> _cooldown = ValueNotifier<int>(0);
  Timer? _cooldownTimer;

  static const _kSavedPatientCode = 'saved_patient_code';
  static const _kOtpDate = 'otp_date_login';
  static const _kOtpAttempts = 'otp_attempts_login';
  static const _kBusinessLoggedIn = 'business_logged_in';

  @override
  void initState() {
    super.initState();
    _loadSavedPatientCode();
    _loadOtpAttemptData();
    _autoLoginIfPossible();
  }

  @override
  void dispose() {
    _patientCodeCtrl.dispose();
    _cooldown.dispose();
    _cooldownTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadSavedPatientCode() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_kSavedPatientCode) ?? '';
    if (saved.isNotEmpty) _patientCodeCtrl.text = saved;
  }

  Future<void> _savePatientCode(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kSavedPatientCode, code);
  }

  Future<void> _clearSavedPatientCode() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kSavedPatientCode);
    await prefs.remove(_kBusinessLoggedIn);

    Fluttertoast.showToast(msg: 'Đã xoá mã bệnh nhân đã lưu');
  }

  Future<void> _loadOtpAttemptData() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now().toIso8601String().substring(0, 10);
    final storedDate = prefs.getString(_kOtpDate) ?? '';
    final attempts = prefs.getInt(_kOtpAttempts) ?? 0;

    if (storedDate == today) {
      setState(() => _otpAttemptsToday = attempts);
    } else {
      await prefs.setString(_kOtpDate, today);
      await prefs.setInt(_kOtpAttempts, 0);
      setState(() => _otpAttemptsToday = 0);
    }
  }

  Future<void> _autoLoginIfPossible() async {
    final prefs = await SharedPreferences.getInstance();
    final savedCode = prefs.getString(_kSavedPatientCode) ?? '';
    final loggedIn = prefs.getBool(_kBusinessLoggedIn) ?? false;

    // Chỉ tự login nếu đã từng login thành công và chưa logout
    if (!loggedIn || savedCode.isEmpty) return;

    if (_isBusy) return;
    setState(() => _isBusy = true);
    try {
      // auto login như code cũ (không OTP)
      final ok =
          await store.getUserBusiness(maYte: savedCode, password: savedCode);
      if (!ok) {
        // Nếu fail thì buộc quay về flow OTP ở lần sau
        await prefs.setBool(_kBusinessLoggedIn, false);
        return;
      }
      if (!mounted) return;
      Modular.to.pushReplacementNamed(AppRoutes.businessPage);
    } finally {
      if (mounted) setState(() => _isBusy = false);
    }
  }

  String _maskPhone(String phone) {
    // 0904xxxx29
    final p = phone.trim();
    if (p.length < 7) return p;
    return '${p.substring(0, 4)}xxxx${p.substring(p.length - 2)}';
  }

  void _startCooldown(int seconds) {
    _cooldownTimer?.cancel();
    _cooldown.value = seconds;
    _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) {
        t.cancel();
        return;
      }
      if (_cooldown.value > 0) {
        _cooldown.value--;
      } else {
        t.cancel();
      }
    });
  }

  Future<String?> _fetchPhoneByPatientCode(String patientCode) async {
    // GET: /api/App/phone?patientCode=...
    final uri = Uri.parse(
      'https://113.160.200.31:6443/api/App/phone?patientCode=$patientCode',
    );

    final res = await http.get(uri);
    if (res.statusCode != 200) return null;

    final jsonBody = jsonDecode(res.body);
    final data = jsonBody['data'];
    if (data is List && data.isNotEmpty) {
      return data.first.toString().trim();
    }
    return null;
  }

  String normalizeVietnamPhone(String phone) {
    var p = phone.trim();

    // remove spaces
    p = p.replaceAll(' ', '');

    // +84xxxx → 84xxxx
    if (p.startsWith('+84')) {
      return p.substring(1);
    }

    // 0xxxx → 84xxxx
    if (p.startsWith('0')) {
      return '84${p.substring(1)}';
    }

    // đã là 84xxxx
    if (p.startsWith('84')) {
      return p;
    }

    throw FormatException('Invalid phone number format');
  }

  Future<String?> _sendOtpToPhone(String phone) async {
    late final String formatted;

    try {
      formatted = normalizeVietnamPhone(phone);
    } catch (e) {
      print('Invalid phone number: $phone');
      return null;
    }

    print("SĐT gửi OTP: $formatted");

    final res = await http.post(
      Uri.parse('https://113.160.200.31:6443/api/User/send-sms'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'Phone': formatted}),
    );

    if (res.statusCode != 200) return null;

    final jsonBody = jsonDecode(res.body);
    final otp = jsonBody['data']?.toString().trim();

    if (otp == null || otp.isEmpty) return null;
    return otp;
  }

  Future<void> _requestOtpFlow() async {
    if (_isBusy) return;

    final patientCode = _patientCodeCtrl.text.trim();
    if (patientCode.isEmpty) {
      Fluttertoast.showToast(msg: 'Vui lòng nhập mã bệnh nhân');
      return;
    }

    // limit attempts/day
    if (_otpAttemptsToday >= 3) {
      Fluttertoast.showToast(msg: 'Đã vượt quá 3 lần gửi OTP trong ngày');
      return;
    }

    // cooldown 90s
    final now = DateTime.now();
    if (_lastOtpTime != null && now.difference(_lastOtpTime!).inSeconds < 90) {
      final remain = 90 - now.difference(_lastOtpTime!).inSeconds;
      Fluttertoast.showToast(msg: 'Vui lòng đợi ${remain}s để gửi lại OTP');
      return;
    }

    setState(() => _isBusy = true);
    try {
      final phone = await _fetchPhoneByPatientCode(patientCode);
      if (phone == null || phone.isEmpty) {
        Fluttertoast.showToast(
            msg: 'Không lấy được số điện thoại theo mã bệnh nhân');
        return;
      }

      final otp = await _sendOtpToPhone(phone);
      if (otp == null) {
        Fluttertoast.showToast(msg: 'Gửi OTP thất bại');
        return;
      }

      // save attempts/day
      final prefs = await SharedPreferences.getInstance();
      _otpAttemptsToday += 1;
      await prefs.setInt(_kOtpAttempts, _otpAttemptsToday);

      _serverOtp = otp;
      _lastOtpTime = now;
      _startCooldown(90);

      final entered = await showModalBottomSheet<String>(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (_) => _OtpSheet(
          maskedPhone: _maskPhone(phone),
          cooldown: _cooldown,
          onResend:
              _requestOtpFlow, // resend giữ nguyên flow (tự check cooldown/attempt)
        ),
      );

      if (!mounted) return;
      if (entered == null || entered.trim().length != 6) return;

      if (entered.trim() != _serverOtp) {
        Fluttertoast.showToast(msg: 'Mã OTP không đúng');
        return;
      }

      // OTP OK => login, ẩn password (password = patientCode)
      await _loginWithPatientCode(patientCode);
    } finally {
      if (mounted) setState(() => _isBusy = false);
    }
  }

  Future<void> _loginWithPatientCode(String patientCode) async {
    if (patientCode.isEmpty) return;

    final ok = await store.getUserBusiness(
      maYte: patientCode,
      password: patientCode,
    );

    if (!ok) {
      Fluttertoast.showToast(msg: 'Đăng nhập thất bại');
      return;
    }

    await _savePatientCode(patientCode);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kBusinessLoggedIn, true);

    if (!mounted) return;
    Fluttertoast.showToast(msg: 'Đăng nhập thành công');
    Modular.to.pushReplacementNamed(AppRoutes.businessPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Hồ sơ sức khỏe',
        isBack: true,
      ),
      backgroundColor: const Color(0xFFF6F7FB),
      body: Stack(
        children: [
          // Header background
          Container(
            height: 220,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withOpacity(0.95),
                  AppColors.primary.withOpacity(0.70),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(18, 16, 18, 24),
              child: Column(
                children: [
                  const SizedBox(height: 8),

                  // Logo + Title
                  Row(
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 16,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Image.asset(ImageEnum.logopstbColor),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'CỔNG TRA CỨU Y BẠ ĐIỆN TỬ\nBệnh Viện Phụ sản Thái Bình',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            height: 1.25,
                            fontSize: 14.5,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  // Main card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Đăng nhập bằng mã bệnh nhân',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Hệ thống sẽ gửi OTP về số điện thoại đã đăng ký.',
                          style: TextStyle(
                            fontSize: 12.5,
                            color: Colors.black.withOpacity(0.62),
                          ),
                        ),
                        const SizedBox(height: 14),

                        TextField(
                          controller: _patientCodeCtrl,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            labelText: 'Mã bệnh nhân',
                            hintText: 'Nhập mã (ví dụ: 25055656)',
                            prefixIcon: const Icon(Icons.badge_outlined),
                            filled: true,
                            fillColor: const Color(0xFFF7F8FC),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade300),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade300),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide(
                                  color: AppColors.primary, width: 1.3),
                            ),
                          ),
                        ),

                        const SizedBox(height: 14),

                        // Action buttons
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton.icon(
                            onPressed: _isBusy ? null : _requestOtpFlow,
                            icon: _isBusy
                                ? const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Icon(Icons.sms_outlined),
                            label: Text(_isBusy
                                ? 'Đang xử lý...'
                                : 'Gửi OTP & đăng nhập'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Giới hạn 3 lần/ngày. Gửi lại sau 90 giây.',
                                style: TextStyle(
                                  fontSize: 11.5,
                                  color: Colors.black.withOpacity(0.55),
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: _clearSavedPatientCode,
                              child: const Text(
                                'Xoá mã đã lưu',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),

                  // Footer
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      'Phát triển bởi Công ty cổ phần Onenet\n'
                      'Địa chỉ: Số 2 Nguyễn Hoàng, Nam Từ Liêm, Hà Nội',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black.withOpacity(0.65),
                        height: 1.35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OtpSheet extends StatefulWidget {
  final String maskedPhone;
  final ValueNotifier<int> cooldown;
  final Future<void> Function()? onResend;

  const _OtpSheet({
    required this.maskedPhone,
    required this.cooldown,
    this.onResend,
  });

  @override
  State<_OtpSheet> createState() => _OtpSheetState();
}

class _OtpSheetState extends State<_OtpSheet> {
  final _controllers = List.generate(6, (_) => TextEditingController());
  final _focusNodes = List.generate(6, (_) => FocusNode());
  bool _submitting = false;

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onCodeChanged(int i, String v) {
    if (v.isNotEmpty && i < 5) {
      _focusNodes[i + 1].requestFocus();
    }
    if (v.isEmpty && i > 0) {
      _focusNodes[i - 1].requestFocus();
    }
    if (i == 5 && v.isNotEmpty) _submit();
  }

  void _submit() {
    final code = _controllers.map((e) => e.text).join();
    if (code.length == 6) Navigator.pop(context, code);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom) +
                const EdgeInsets.fromLTRB(16, 14, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 44,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(99),
              ),
            ),
            const SizedBox(height: 14),
            const Icon(Icons.verified_user_outlined, size: 34),
            const SizedBox(height: 10),
            const Text(
              'Xác thực OTP',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 6),
            Text(
              'Mã OTP đã gửi tới ${widget.maskedPhone}',
              style: TextStyle(color: Colors.black.withOpacity(0.65)),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(6, (i) {
                return Container(
                  width: 46,
                  height: 54,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  child: TextField(
                    controller: _controllers[i],
                    focusNode: _focusNodes[i],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    decoration: InputDecoration(
                      counterText: '',
                      filled: true,
                      fillColor: const Color(0xFFF7F8FC),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide:
                            BorderSide(color: AppColors.primary, width: 1.3),
                      ),
                    ),
                    onChanged: (v) => _onCodeChanged(i, v),
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _submitting
                    ? null
                    : () {
                        setState(() => _submitting = true);
                        _submit();
                        if (mounted) setState(() => _submitting = false);
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: _submitting
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white),
                      )
                    : const Text('Xác nhận',
                        style: TextStyle(fontWeight: FontWeight.w700)),
              ),
            ),
            const SizedBox(height: 10),
            ValueListenableBuilder<int>(
              valueListenable: widget.cooldown,
              builder: (_, sec, __) {
                final disabled =
                    sec > 0 || widget.onResend == null || _submitting;
                return TextButton(
                  onPressed: disabled
                      ? null
                      : () async {
                          setState(() => _submitting = true);
                          await widget.onResend!.call();
                          if (mounted) setState(() => _submitting = false);
                        },
                  child:
                      Text(sec > 0 ? 'Gửi lại OTP (${sec}s)' : 'Gửi lại OTP'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
