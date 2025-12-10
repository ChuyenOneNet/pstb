// import 'package:flutter/material.dart';
// import 'package:flutter_modular/flutter_modular.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import 'package:pstb/app/modules/business/business_store.dart';
// import 'package:pstb/app/user_app_store.dart';
// import 'package:pstb/di/locator.dart';
//
// import '../../../../utils/colors.dart';
// import '../../../../utils/images.dart';
// import '../../../../utils/routes.dart';
// import '../../../../widgets/stateless/app_bar.dart';
//
// // TODO: chỉnh lại path cho đúng với project của bạn
// import 'package:pstb/feature/relatives/data/models/relative_model.dart';
// import 'package:pstb/feature/relatives/presentation/cubit/relative_list_cubit.dart';
//
// class BusinessLoginPage extends StatefulWidget {
//   const BusinessLoginPage({Key? key});
//
//   @override
//   State<BusinessLoginPage> createState() => _BusinessLoginPageState();
// }
//
// class _BusinessLoginPageState extends State<BusinessLoginPage> {
//   final BusinessStore store = Modular.get<BusinessStore>();
//   final UserAppStore _userAppStore = Modular.get<UserAppStore>();
//
//   late final RelativeListCubit _relativeCubit;
//
//   bool _isBusy = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _relativeCubit = serviceLocator<RelativeListCubit>();
//     _loadRelatives();
//   }
//
//   Future<void> _loadRelatives() async {
//     final mainCccd = "037200009029";
//     //_userAppStore.user.personalId ?? '';
//     if (mainCccd.isEmpty) {
//       Fluttertoast.showToast(
//         msg: 'Không tìm thấy CCCD của tài khoản chính',
//       );
//       return;
//     }
//     await _relativeCubit.load(mainCccd);
//   }
//
//   Future<void> _loginWithPatientCode(String patientCode) async {
//     if (_isBusy) return;
//     if (patientCode.isEmpty) {
//       Fluttertoast.showToast(msg: 'Người này chưa có mã bệnh nhân');
//       return;
//     }
//
//     setState(() => _isBusy = true);
//     try {
//       final ok = await store.getUserBusiness(
//         maYte: patientCode,
//         password: patientCode,
//       );
//       if (!ok) {
//         Fluttertoast.showToast(msg: 'Đăng nhập thất bại');
//         return;
//       }
//       if (!mounted) return;
//       Fluttertoast.showToast(msg: 'Đăng nhập thành công');
//       Modular.to.pushReplacementNamed(AppRoutes.businessPage);
//     } catch (_) {
//       Fluttertoast.showToast(msg: 'Đăng nhập thất bại');
//     } finally {
//       if (mounted) setState(() => _isBusy = false);
//     }
//   }
//
//   @override
//   void dispose() {
//     _relativeCubit.close();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider.value(
//       value: _relativeCubit,
//       child: Scaffold(
//         appBar: CustomAppBar(
//           title: 'Hồ sơ sức khỏe',
//           isBack: true,
//         ),
//         backgroundColor: Colors.white,
//         body: Column(
//           children: [
//             if (_isBusy)
//               const LinearProgressIndicator(
//                 minHeight: 2,
//               ),
//             Expanded(
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.symmetric(horizontal: 24),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     const SizedBox(height: 10),
//                     SizedBox(
//                       height: 110,
//                       width: 110,
//                       child: Image.asset(ImageEnum.logopstbColor),
//                     ),
//                     const SizedBox(height: 12),
//                     const Text(
//                       'CỔNG TRA CỨU Y BẠ ĐIỆN TỬ\nBỆNH VIỆN Phụ Sản Thái Bình',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 15,
//                         color: AppColors.primary,
//                       ),
//                     ),
//                     const SizedBox(height: 24),
//                     _buildPatientSelector(),
//                     const SizedBox(height: 24),
//                     const Text(
//                       'Phát triển bởi Công ty cổ phần Onenet\n'
//                       'Địa chỉ: Số 2 Nguyễn Hoàng, Nam Từ Liêm, Hà Nội\n',
//                       //'Hotline: 0363.832.057 ',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(fontSize: 12, color: Colors.black87),
//                     ),
//                     const SizedBox(height: 24),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ================== DANH SÁCH BẢN THÂN + NGƯỜI THÂN ==================
//
//   Widget _buildPatientSelector() {
//     return BlocBuilder<RelativeListCubit, RelativeListState>(
//       builder: (context, state) {
//         if (state.loading && state.items.isEmpty) {
//           return _buildLoadingList();
//         }
//
//         if (state.items.isEmpty) {
//           return Column(
//             children: const [
//               Icon(Icons.group_off_outlined, size: 64, color: Colors.grey),
//               SizedBox(height: 8),
//               Text(
//                 'Chưa có thông tin bản thân / người thân\nđể tra cứu hồ sơ bệnh án.',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 13),
//               ),
//             ],
//           );
//         }
//
//         final items = state.items;
//
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Chọn người để xem hồ sơ bệnh án',
//               style: TextStyle(
//                 fontWeight: FontWeight.w600,
//                 fontSize: 14,
//               ),
//             ),
//             const SizedBox(height: 8),
//             ListView.separated(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: items.length,
//               separatorBuilder: (_, __) => const SizedBox(height: 8),
//               itemBuilder: (context, index) {
//                 final r = items[index];
//                 final isSelf = index == 0; // phần tử đầu tiên là bản thân
//                 return _buildPatientCard(r, isSelf);
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   Widget _buildLoadingList() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Chọn người để xem hồ sơ bệnh án',
//           style: TextStyle(
//             fontWeight: FontWeight.w600,
//             fontSize: 14,
//           ),
//         ),
//         const SizedBox(height: 8),
//         Column(
//           children: List.generate(
//             3,
//             (index) => Container(
//               margin: const EdgeInsets.only(bottom: 8),
//               height: 72,
//               decoration: BoxDecoration(
//                 color: Colors.grey[200],
//                 borderRadius: BorderRadius.circular(16),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildPatientCard(RelativeModel r, bool isSelf) {
//     final pc = r.patientCode;
//     final title = isSelf ? 'Bản thân' : r.fullName;
//     final subtitle =
//         isSelf ? 'Mã BN: ${r.patientCode}' : 'Mã BN: ${r.patientCode}';
//
//     return GestureDetector(
//       onTap: _isBusy ? null : () => _loginWithPatientCode("25042411"),
//       //_loginWithPatientCode(pc),
//       child: Container(
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(
//             color: isSelf ? AppColors.primary : Colors.grey[300]!,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.04),
//               blurRadius: 8,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             CircleAvatar(
//               radius: 22,
//               backgroundColor: AppColors.primary.withOpacity(0.08),
//               child: Icon(
//                 isSelf ? Icons.person : Icons.family_restroom,
//                 size: 22,
//                 color: AppColors.primary,
//               ),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Text(
//                           title,
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(
//                             fontWeight:
//                                 isSelf ? FontWeight.w700 : FontWeight.w600,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ),
//                       if (isSelf)
//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 8,
//                             vertical: 2,
//                           ),
//                           decoration: BoxDecoration(
//                             color: AppColors.primary.withOpacity(0.08),
//                             borderRadius: BorderRadius.circular(999),
//                           ),
//                           child: Text(
//                             'Tài khoản chính',
//                             style: TextStyle(
//                               fontSize: 11,
//                               color: AppColors.primary,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                     ],
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     subtitle,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: const TextStyle(fontSize: 12, color: Colors.black54),
//                   ),
//                   const SizedBox(height: 2),
//                   const Text(
//                     'Nhấn để đăng nhập và xem hồ sơ bệnh án',
//                     style: TextStyle(fontSize: 11, color: Colors.black45),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(width: 8),
//             const Icon(Icons.chevron_right, color: Colors.black38),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pstb/app/modules/business/business_store.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // ✅ secure password

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
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();
  final BusinessStore store = Modular.get<BusinessStore>();

  // ✅ secure storage cho password
  final FlutterSecureStorage _secure = const FlutterSecureStorage();

  // Tránh bấm nhiều lần, giúp hiển thị loading
  bool _isBusy = false;

  // Khóa lưu trữ
  static const _kIdKey = 'maYte';
  static const _kPwKey = 'passwordBusiness';

  @override
  void initState() {
    super.initState();
    _loadAndAutoLogin(); // ✅ đọc & tự đăng nhập nếu có
  }

  Future<void> _loadAndAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final savedId = prefs.getString(_kIdKey);
    final savedPw = await _secure.read(key: _kPwKey);

    if ((savedId ?? '').isNotEmpty && (savedPw ?? '').isNotEmpty) {
      _idController.text = savedId!;
      _passwordController.text = savedPw!;
      await _login(maYte: savedId, password: savedPw!, auto: true);
    }
  }

  Future<void> _saveCredentials(String maYte, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kIdKey, maYte);
    await _secure.write(key: _kPwKey, value: password);
  }

  Future<void> _clearSaved() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kIdKey);
    await _secure.delete(key: _kPwKey);
    Fluttertoast.showToast(msg: 'Đã xoá tài khoản đã lưu');
  }

  Future<void> _login({
    required String maYte,
    required String password,
    bool auto = false,
  }) async {
    if (_isBusy) return;
    setState(() => _isBusy = true);

    try {
      final success =
          await store.getUserBusiness(maYte: maYte, password: password);

      if (!success) throw Exception('Sai tài khoản hoặc mật khẩu');

      await _saveCredentials(maYte, password);

      if (!mounted) return;
      if (!auto) Fluttertoast.showToast(msg: 'Đăng nhập thành công');
      Modular.to.pushReplacementNamed(AppRoutes.businessPage);
    } catch (e) {
      if (!auto) Fluttertoast.showToast(msg: 'Đăng nhập thất bại');
    } finally {
      if (mounted) setState(() => _isBusy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Hồ sơ sức khỏe',
        isBack: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 140,
              width: 140,
              child: Image.asset(ImageEnum.logopstbColor),
            ),
            const SizedBox(height: 12),
            const Text(
              'CỔNG TRA CỨU Y BẠ ĐIỆN TỬ\nBệnh Viện Phụ sản Thái Bình',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 24),

            TextField(
              controller: _idController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person),
                labelText: 'Mã',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.lock),
                labelText: 'Mật khẩu',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _isBusy
                    ? null
                    : () async {
                        final maYte = _idController.text.trim();
                        final password = _passwordController.text.trim();

                        if (maYte.isEmpty || password.isEmpty) {
                          Fluttertoast.showToast(
                              msg: 'Vui lòng nhập đầy đủ thông tin');
                          return;
                        }
                        await _login(maYte: maYte, password: password);
                      },
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary),
                child: _isBusy
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white))
                    : const Text('Đăng Nhập',
                        style: TextStyle(color: Colors.white)),
              ),
            ),

            const SizedBox(height: 12),

            GestureDetector(
              onTap: () =>
                  Modular.to.pushNamed(AppRoutes.resetPasswordBusiness),
              child: const Text(
                'Đặt lại mật khẩu',
                style: TextStyle(
                    decoration: TextDecoration.underline, color: Colors.blue),
              ),
            ),

            const SizedBox(height: 8),

            // (tuỳ chọn) Nút xoá thông tin đã lưu
            TextButton(
              onPressed: _clearSaved,
              child: const Text(
                'Xoá tài khoản đã lưu',
                style: TextStyle(color: Colors.red),
              ),
            ),

            const SizedBox(height: 24),
            const Text(
              'Phát triển bởi Công ty cổ phần Onenet\n'
              'Địa chỉ: Số 2 Nguyễn Hoàng, Nam Từ Liêm, Hà Nội\n',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
