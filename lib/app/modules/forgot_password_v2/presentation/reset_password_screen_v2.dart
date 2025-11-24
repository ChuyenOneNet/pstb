// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:pstb/utils/app_extensions.dart';
// //
// // import '../../../../constant/color.dart';
// // import '../../../../widgets/stateless/app_bar.dart';
// //
// // class ResetPasswordScreenV2 extends StatefulWidget {
// //   final String accountOrCccd;
// //   final String phone; // đã normalize
// //
// //   const ResetPasswordScreenV2({
// //     super.key,
// //     required this.accountOrCccd,
// //     required this.phone,
// //   });
// //
// //   @override
// //   State<ResetPasswordScreenV2> createState() => _ResetPasswordScreenV2State();
// // }
// //
// // class _ResetPasswordScreenV2State extends State<ResetPasswordScreenV2> {
// //   final _formKey = GlobalKey<FormState>();
// //   final _pw1 = TextEditingController();
// //   final _pw2 = TextEditingController();
// //   final _pw1Focus = FocusNode();
// //   final _pw2Focus = FocusNode();
// //
// //   bool _ob1 = true, _ob2 = true;
// //   bool _loading = false;
// //
// //   // Chỉ còn 2 điều kiện theo yêu cầu
// //   bool _rMin = false, _rSpecial = false;
// //
// //   @override
// //   void dispose() {
// //     _pw1.dispose();
// //     _pw2.dispose();
// //     _pw1Focus.dispose();
// //     _pw2Focus.dispose();
// //     super.dispose();
// //   }
// //
// //   int get _metCount => [_rMin, _rSpecial].where((e) => e).length;
// //   double get _strength => (_metCount / 2).clamp(0, 1);
// //   bool get _isValid => _metCount == 2;
// //
// //   // RegExp “ký tự đặc biệt” an toàn & gọn:
// //   // - [^\w\s] = bất kỳ ký tự KHÔNG phải chữ/số/_ và KHÔNG phải khoảng trắng
// //   final RegExp _regSpecial = RegExp(r'[^\w\s]');
// //
// //   // Nếu bạn muốn danh sách ký tự cụ thể, dùng bản này (không lỗi escape):
// //   // final RegExp _regSpecialStrict = RegExp(
// //   //   r'''[~`!@#\$%\^&*()\-_=+{}\[\]|\\:;'"<>,.?/]'''
// //   // );
// //
// //   void _onPw1Changed(String v) {
// //     setState(() {
// //       _rMin = v.length >= 8;
// //       _rSpecial = _regSpecial.hasMatch(v);
// //     });
// //   }
// //
// //   Future<void> _sendOtpAndOpenSheet() async {
// //     if (!_formKey.currentState!.validate()) {
// //       setState(() {}); // hiện lỗi ngay
// //       return;
// //     }
// //     final newPw = _pw1.text;
// //
// //     setState(() => _loading = true);
// //     try {
// //       // --- Gửi OTP (giữ nguyên flow của bạn, đang comment) ---
// //       // final res = await Api.postPublic(context, Api.forgot_password, {
// //       //   "cccd": widget.accountOrCccd,
// //       //   "phone": widget.phone,
// //       //   "lang": Api.language,
// //       // });
// //       // final requestId = (res?['requestId'] ?? '').toString();
// //       // final masked = (res?['maskedPhone'] ?? '').toString();
// //       // final expiresIn = int.tryParse('${res?['expiresIn'] ?? 300}') ?? 300;
// //       // final resendAfter = int.tryParse('${res?['resendAfter'] ?? 60}') ?? 60;
// //       // if (requestId.isEmpty) { /* showSnack... */ return; }
// //       // if (!mounted) return;
// //       // final ok = await showModalBottomSheet<bool>(
// //       //   context: context,
// //       //   isScrollControlled: true,
// //       //   useSafeArea: true,
// //       //   builder: (_) => OtpSheet(
// //       //     requestId: requestId,
// //       //     maskedPhone: masked.isEmpty ? widget.phone : masked,
// //       //     newPassword: newPw,
// //       //     expiresIn: expiresIn,
// //       //     resendAfter: resendAfter,
// //       //     onResend: () async { /* resend... */ },
// //       //     onConfirm: (otp) async { /* confirm... */ },
// //       //   ),
// //       // );
// //       // if (ok == true && mounted) {
// //       //   Navigator.of(context).popUntil((r) => r.isFirst);
// //       // }
// //     } finally {
// //       if (mounted) setState(() => _loading = false);
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final theme = Theme.of(context);
// //
// //     return GestureDetector(
// //       onTap: () => FocusScope.of(context).unfocus(),
// //       child: Scaffold(
// //         appBar: CustomAppBar(
// //           title: 'Đặt lại mật khẩu',
// //         ),
// //         body: SafeArea(
// //           child: Center(
// //             child: ConstrainedBox(
// //               constraints: const BoxConstraints(maxWidth: 520),
// //               child: Form(
// //                 key: _formKey,
// //                 autovalidateMode: AutovalidateMode.onUserInteraction,
// //                 child: ListView(
// //                   padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
// //                   children: [
// //                     // Header
// //                     Row(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         CircleAvatar(
// //                           radius: 20,
// //                           backgroundColor:
// //                               AppColors.primaryColor.withOpacity(.12),
// //                           foregroundColor: AppColors.primaryColor,
// //                           child: const Icon(Icons.lock_reset_outlined),
// //                         ),
// //                         const SizedBox(width: 12),
// //                         Expanded(
// //                           child: Column(
// //                             crossAxisAlignment: CrossAxisAlignment.start,
// //                             children: [
// //                               Text('Quên mật khẩu',
// //                                   style: theme.textTheme.titleLarge?.copyWith(
// //                                     fontWeight: FontWeight.w700,
// //                                   )),
// //                               const SizedBox(height: 4),
// //                               Text(
// //                                 'Thông tin đã xác thực. Vui lòng tạo mật khẩu mới để tiếp tục.',
// //                                 style: theme.textTheme.bodyMedium?.copyWith(
// //                                   color: Colors.black.withOpacity(.7),
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                     const SizedBox(height: 16),
// //
// //                     // Card thông tin
// //                     Card(
// //                       color: Colors.white,
// //                       elevation: 0,
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(16),
// //                         side: BorderSide(color: Colors.grey.shade300),
// //                       ),
// //                       child: const Padding(
// //                         padding: EdgeInsets.all(12),
// //                         child: Column(
// //                           children: [
// //                             _InfoRow(
// //                               icon: Icons.badge_outlined,
// //                               label: 'Số CCCD',
// //                               // value truyền ở dưới bằng widget.accountOrCccd
// //                             ),
// //                             SizedBox(height: 8),
// //                             _InfoRow(
// //                               icon: Icons.phone_outlined,
// //                               label: 'Số điện thoại',
// //                               // value truyền ở dưới bằng widget.phone
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     ),
// //
// //                     // Gán giá trị runtime cho _InfoRow bằng InheritedWidget đơn giản
// //                     // hoặc sửa _InfoRow để nhận value ở đây (sửa cho nhanh ở dưới):
// //                     const SizedBox(height: 0),
// //
// //                     const SizedBox(height: 16),
// //
// //                     // Mật khẩu mới
// //                     TextFormField(
// //                       controller: _pw1,
// //                       focusNode: _pw1Focus,
// //                       onChanged: (v) {
// //                         _onPw1Changed(v);
// //                         if (_pw2.text.isNotEmpty) setState(() {});
// //                       },
// //                       decoration: InputDecoration(
// //                         labelText: 'Mật khẩu mới',
// //                         hintText: 'Nhập mật khẩu mới',
// //                         prefixIcon: const Icon(Icons.lock_outline),
// //                         border: OutlineInputBorder(
// //                           borderRadius: BorderRadius.circular(12),
// //                         ),
// //                         suffixIcon: Row(
// //                           mainAxisSize: MainAxisSize.min,
// //                           children: [
// //                             if (_pw1.text.isNotEmpty)
// //                               IconButton(
// //                                 tooltip: 'Xoá',
// //                                 icon: const Icon(Icons.clear),
// //                                 onPressed: () {
// //                                   _pw1.clear();
// //                                   _onPw1Changed('');
// //                                   setState(() {});
// //                                 },
// //                               ),
// //                             IconButton(
// //                               tooltip: _ob1 ? 'Hiện mật khẩu' : 'Ẩn mật khẩu',
// //                               icon: Icon(_ob1
// //                                   ? Icons.visibility
// //                                   : Icons.visibility_off),
// //                               onPressed: () => setState(() => _ob1 = !_ob1),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                       obscureText: _ob1,
// //                       textInputAction: TextInputAction.next,
// //                       onFieldSubmitted: (_) =>
// //                           FocusScope.of(context).requestFocus(_pw2Focus),
// //                       validator: (v) {
// //                         if (v == null || v.isEmpty) {
// //                           return 'Vui lòng nhập mật khẩu';
// //                         }
// //                         if (v.length < 8) {
// //                           return 'Tối thiểu 8 ký tự';
// //                         }
// //                         if (!_regSpecial.hasMatch(v)) {
// //                           return 'Phải có ít nhất 1 ký tự đặc biệt';
// //                         }
// //                         return null;
// //                       },
// //                     ),
// //
// //                     const SizedBox(height: 12),
// //
// //                     // Strength + checklist (chỉ 2 rule)
// //                     _PasswordStrengthBar(
// //                       value: _strength,
// //                       ok: _isValid,
// //                     ),
// //                     const SizedBox(height: 8),
// //                     _ChecklistCard(
// //                       items: [
// //                         _Rule(text: 'Tối thiểu 8 ký tự', ok: _rMin),
// //                         _Rule(text: 'Có ký tự đặc biệt', ok: _rSpecial),
// //                       ],
// //                     ),
// //
// //                     const SizedBox(height: 16),
// //
// //                     // Nhập lại mật khẩu
// //                     TextFormField(
// //                       controller: _pw2,
// //                       focusNode: _pw2Focus,
// //                       decoration: InputDecoration(
// //                         labelText: 'Nhập lại mật khẩu',
// //                         hintText: 'Nhập lại mật khẩu mới',
// //                         prefixIcon: const Icon(Icons.lock_outline),
// //                         border: OutlineInputBorder(
// //                           borderRadius: BorderRadius.circular(12),
// //                         ),
// //                         suffixIcon: IconButton(
// //                           tooltip: _ob2 ? 'Hiện mật khẩu' : 'Ẩn mật khẩu',
// //                           icon: Icon(
// //                               _ob2 ? Icons.visibility : Icons.visibility_off),
// //                           onPressed: () => setState(() => _ob2 = !_ob2),
// //                         ),
// //                       ),
// //                       obscureText: _ob2,
// //                       textInputAction: TextInputAction.done,
// //                       validator: (v) {
// //                         if (v == null || v.isEmpty) {
// //                           return 'Vui lòng nhập lại mật khẩu';
// //                         }
// //                         if (v != _pw1.text) {
// //                           return 'Mật khẩu nhập lại không khớp';
// //                         }
// //                         return null;
// //                       },
// //                     ),
// //
// //                     const SizedBox(height: 24),
// //
// //                     // CTA
// //                     SizedBox(
// //                       height: 48,
// //                       child: ElevatedButton.icon(
// //                         icon: _loading
// //                             ? const SizedBox(
// //                                 width: 18,
// //                                 height: 18,
// //                                 child: CircularProgressIndicator.adaptive(
// //                                   strokeWidth: 2,
// //                                   valueColor: AlwaysStoppedAnimation<Color>(
// //                                       Colors.white),
// //                                 ),
// //                               )
// //                             : const Icon(Icons.sms_outlined),
// //                         label: Text(_loading ? 'Đang gửi...' : 'Gửi mã OTP'),
// //                         onPressed: _loading ? null : _sendOtpAndOpenSheet,
// //                         style: ElevatedButton.styleFrom(
// //                           backgroundColor: AppColors.primaryColor,
// //                           foregroundColor: Colors.white,
// //                           disabledBackgroundColor: Colors.grey.shade400,
// //                           disabledForegroundColor: Colors.white70,
// //                           shape: RoundedRectangleBorder(
// //                             borderRadius: BorderRadius.circular(12),
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //
// //                     const SizedBox(height: 12),
// //                     Center(
// //                       child: TextButton.icon(
// //                         onPressed: () {
// //                           showModalBottomSheet<void>(
// //                             context: context,
// //                             showDragHandle: true,
// //                             builder: (c) => const _TipsSheet(),
// //                           );
// //                         },
// //                         icon: Icon(Icons.tips_and_updates_outlined,
// //                             color: AppColors.primaryColor),
// //                         label: Text(
// //                           'Gợi ý tạo mật khẩu an toàn',
// //                           style: TextStyle(color: AppColors.primaryColor),
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // // ---------- Các widget con ----------
// //
// // class _InfoRow extends StatelessWidget {
// //   final IconData icon;
// //   final String label;
// //   final String? value; // cho phép null để tái sử dụng
// //   const _InfoRow({
// //     required this.icon,
// //     required this.label,
// //     this.value,
// //   });
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     // Lấy value thực từ ancestor nếu null (đơn giản hoá: truyền trực tiếp luôn)
// //     final v = value ??
// //         (label == 'Tài khoản'
// //             ? (context
// //                     .findAncestorStateOfType<_ResetPasswordScreenV2State>()
// //                     ?.widget
// //                     .accountOrCccd ??
// //                 '')
// //             : (context
// //                     .findAncestorStateOfType<_ResetPasswordScreenV2State>()
// //                     ?.widget
// //                     .phone ??
// //                 ''));
// //
// //     return Row(
// //       crossAxisAlignment: CrossAxisAlignment.center,
// //       children: [
// //         Icon(icon),
// //         const SizedBox(width: 10),
// //         Text(
// //           '$label: ',
// //           style: const TextStyle(
// //             color: Colors.black87,
// //             fontWeight: FontWeight.w600,
// //           ),
// //         ),
// //         Expanded(
// //           child: Text(
// //             v,
// //             textAlign: TextAlign.right,
// //             overflow: TextOverflow.ellipsis,
// //             style: const TextStyle(color: Colors.black87),
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }
// //
// // class _PasswordStrengthBar extends StatelessWidget {
// //   final double value; // 0..1
// //   final bool ok;
// //
// //   const _PasswordStrengthBar({
// //     required this.value,
// //     required this.ok,
// //   });
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         ClipRRect(
// //           borderRadius: BorderRadius.circular(8),
// //           child: LinearProgressIndicator(
// //             minHeight: 8,
// //             value: value == 0 ? 0.02 : value,
// //             backgroundColor: Colors.black12,
// //             valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
// //           ),
// //         ),
// //         const SizedBox(height: 6),
// //         Text(
// //           ok ? 'Hợp lệ' : 'Chưa hợp lệ',
// //           style: TextStyle(
// //             color: ok ? AppColors.primaryColor : Colors.redAccent,
// //             fontWeight: FontWeight.w600,
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }
// //
// // class _ChecklistCard extends StatelessWidget {
// //   final List<_Rule> items;
// //   const _ChecklistCard({required this.items});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(12),
// //         border: Border.all(color: Colors.grey.shade300),
// //       ),
// //       child: Column(
// //         children: items
// //             .map((r) => Padding(
// //                   padding: const EdgeInsets.symmetric(vertical: 4),
// //                   child: Row(
// //                     children: [
// //                       Icon(
// //                         r.ok ? Icons.check_circle : Icons.circle_outlined,
// //                         size: 18,
// //                         color: r.ok ? AppColors.primaryColor : Colors.grey,
// //                       ),
// //                       const SizedBox(width: 8),
// //                       Expanded(
// //                         child: Text(
// //                           r.text,
// //                           style: TextStyle(
// //                             color: Colors.black.withOpacity(r.ok ? 1 : .75),
// //                             fontWeight: r.ok ? FontWeight.w600 : null,
// //                           ),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ))
// //             .toList(),
// //       ),
// //     );
// //   }
// // }
// //
// // class _Rule {
// //   final String text;
// //   final bool ok;
// //   _Rule({required this.text, required this.ok});
// // }
// //
// // class _TipsSheet extends StatelessWidget {
// //   const _TipsSheet();
// //   @override
// //   Widget build(BuildContext context) {
// //     return SafeArea(
// //       child: Padding(
// //         padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
// //         child: Column(
// //           mainAxisSize: MainAxisSize.min,
// //           children: [
// //             const Row(
// //               children: [
// //                 Icon(Icons.tips_and_updates_outlined),
// //                 SizedBox(width: 8),
// //                 Text(
// //                   'Gợi ý tạo mật khẩu',
// //                   style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
// //                 ),
// //               ],
// //             ),
// //             const SizedBox(height: 12),
// //             const _TipRow(text: 'Dùng cụm từ dài, dễ nhớ nhưng khó đoán'),
// //             const _TipRow(text: 'Tránh thông tin cá nhân (tên, ngày sinh…)'),
// //             const _TipRow(text: 'Không tái sử dụng mật khẩu cũ ở dịch vụ khác'),
// //             const _TipRow(text: 'Bật 2FA nếu có thể'),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // class _TipRow extends StatelessWidget {
// //   final String text;
// //   const _TipRow({required this.text});
// //   @override
// //   Widget build(BuildContext context) {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(vertical: 6),
// //       child: Row(
// //         children: [
// //           Icon(Icons.check, size: 18, color: AppColors.primaryColor),
// //           const SizedBox(width: 8),
// //           Expanded(child: Text(text)),
// //         ],
// //       ),
// //     );
// //   }
// // }
// import 'dart:async';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart'; // 👈
// import 'package:pstb/utils/app_extensions.dart';
//
// import '../../../../constant/color.dart';
// import '../../../../services/api_base_helper.dart';
// import '../../../../utils/api_url.dart';
// import '../../../../widgets/stateless/app_bar.dart';
// import '../../../models/reset_password_model.dart';
// // 👈 đảm bảo import đúng chỗ bạn đặt Api.resetPasswordWithIdToken
//
// class ResetPasswordScreenV2 extends StatefulWidget {
//   final String accountOrCccd;
//   final String phone; // E.164
//
//   const ResetPasswordScreenV2({
//     super.key,
//     required this.accountOrCccd,
//     required this.phone,
//   });
//
//   @override
//   State<ResetPasswordScreenV2> createState() => _ResetPasswordScreenV2State();
// }
//
// class _ResetPasswordScreenV2State extends State<ResetPasswordScreenV2> {
//   final _formKey = GlobalKey<FormState>();
//   final _pw1 = TextEditingController();
//   final _pw2 = TextEditingController();
//   final _pw1Focus = FocusNode();
//   final _pw2Focus = FocusNode();
//
//   bool _ob1 = true, _ob2 = true;
//   bool _loading = false;
//
//   // Rule: tối thiểu 8 + có ký tự đặc biệt
//   bool _rMin = false, _rSpecial = false;
//   int get _metCount => [_rMin, _rSpecial].where((e) => e).length;
//   double get _strength => (_metCount / 2).clamp(0, 1);
//   bool get _isValid => _metCount == 2;
//
//   final RegExp _regSpecial = RegExp(r'[^\w\s]');
//
//   String? _verificationId;
//   int? _forceResendToken;
//
//   @override
//   void dispose() {
//     _pw1.dispose();
//     _pw2.dispose();
//     _pw1Focus.dispose();
//     _pw2Focus.dispose();
//     super.dispose();
//   }
//
//   void _onPw1Changed(String v) {
//     setState(() {
//       _rMin = v.length >= 8;
//       _rSpecial = _regSpecial.hasMatch(v);
//     });
//   }
//
//   void _snack(String msg) {
//     if (!mounted) return;
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
//   }
//
//   Future<String?> _signInAndGetIdToken({
//     required String verificationId,
//     required String smsCode,
//   }) async {
//     final cred = PhoneAuthProvider.credential(
//       verificationId: verificationId,
//       smsCode: smsCode,
//     );
//     final userCred = await FirebaseAuth.instance.signInWithCredential(cred);
//     final token = await userCred.user?.getIdToken(true);
//     return token;
//   }
//
//   Future<void> _resetWithApi({
//     required String newPassword,
//     required String idToken,
//   }) async {
//     try {
//       print("reset ok");
//       final body = ForgotPasswordModel(
//         username: widget.phone,
//         newPassword: newPassword,
//         confirmPassword: newPassword,
//         key: ApiConstance.changePasswordKey,
//       ).toRawJson();
//       await ApiBaseHelper().put(ApiUrl.forgotPassword, body);
//       _snack('Đổi mật khẩu thành công');
//     } catch (e) {
//       _snack('Đổi mật khẩu thất bại. Vui lòng thử lại.');
//     }
//
//     // final ok = await Api.resetPasswordWithIdToken(
//     //   context: context,
//     //   idToken: idToken,
//     //   accountOrCccd: widget.accountOrCccd,
//     //   phone: widget.phone,
//     //   newPassword: newPassword,
//     // );
//     //
//     // if (!mounted) return;
//     // if (ok) {
//     //   _snack('Đổi mật khẩu thành công');
//     //   // tùy flow của bạn
//     //   Navigator.of(context).popUntil((r) => r.isFirst);
//     // } else {
//     //   _snack('Đổi mật khẩu thất bại. Vui lòng thử lại.');
//     // }
//     //
//     // // Không bắt buộc, nhưng thường signOut để tránh treo session Firebase
//     // try { await FirebaseAuth.instance.signOut(); } catch (_) {}
//   }
//
//   Future<void> _sendOtpAndOpenSheet() async {
//     if (!_formKey.currentState!.validate()) {
//       setState(() {}); // show error
//       return;
//     }
//     final newPw = _pw1.text;
//
//     setState(() => _loading = true);
//     try {
//       await FirebaseAuth.instance.verifyPhoneNumber(
//         phoneNumber: widget.phone,
//         timeout: const Duration(seconds: 60),
//         forceResendingToken: _forceResendToken,
//         verificationCompleted: (cred) async {
//           // Android có thể auto-verify
//           try {
//             final userCred =
//                 await FirebaseAuth.instance.signInWithCredential(cred);
//             final idToken = await userCred.user?.getIdToken(true);
//             if (idToken != null) {
//               await _resetWithApi(newPassword: newPw, idToken: idToken);
//             } else {
//               _snack('Không lấy được idToken');
//             }
//           } catch (e) {
//             _snack('Xác thực tự động thất bại: $e');
//           }
//         },
//         verificationFailed: (e) {
//           _snack('Gửi OTP thất bại: ${e.message ?? e.code}');
//         },
//         codeSent: (verificationId, resendToken) async {
//           _verificationId = verificationId;
//           _forceResendToken = resendToken;
//
//           final smsCode = await showModalBottomSheet<String>(
//             context: context,
//             isScrollControlled: true,
//             useSafeArea: true,
//             builder: (_) => _OtpSheetFirebase(
//               phone: widget.phone,
//               onResend: () async {
//                 try {
//                   await FirebaseAuth.instance.verifyPhoneNumber(
//                     phoneNumber: widget.phone,
//                     forceResendingToken: _forceResendToken,
//                     timeout: const Duration(seconds: 60),
//                     codeSent: (vid, rt) {
//                       _verificationId = vid;
//                       _forceResendToken = rt;
//                     },
//                     verificationCompleted: (_) {},
//                     verificationFailed: (_) {},
//                     codeAutoRetrievalTimeout: (vid) {
//                       _verificationId = vid;
//                     },
//                   );
//                 } catch (e) {
//                   _snack('Không gửi lại được OTP: $e');
//                 }
//               },
//             ),
//           );
//
//           if (!mounted) return;
//
//           if (smsCode != null &&
//               smsCode.isNotEmpty &&
//               _verificationId != null) {
//             try {
//               final idToken = await _signInAndGetIdToken(
//                 verificationId: _verificationId!,
//                 smsCode: smsCode,
//               );
//               if (idToken == null) {
//                 _snack('Không lấy được idToken');
//                 return;
//               }
//               await _resetWithApi(newPassword: newPw, idToken: idToken);
//             } catch (e) {
//               _snack('Xác thực OTP thất bại: $e');
//             }
//           }
//         },
//         codeAutoRetrievalTimeout: (verificationId) {
//           _verificationId = verificationId;
//         },
//       );
//     } finally {
//       if (mounted) setState(() => _loading = false);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: Scaffold(
//         appBar: CustomAppBar(title: 'Đặt lại mật khẩu'),
//         body: SafeArea(
//           child: Center(
//             child: ConstrainedBox(
//               constraints: const BoxConstraints(maxWidth: 520),
//               child: Form(
//                 key: _formKey,
//                 autovalidateMode: AutovalidateMode.onUserInteraction,
//                 child: ListView(
//                   padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
//                   children: [
//                     // Header
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         CircleAvatar(
//                           radius: 20,
//                           backgroundColor:
//                               AppColors.primaryColor.withOpacity(.12),
//                           foregroundColor: AppColors.primaryColor,
//                           child: const Icon(Icons.lock_reset_outlined),
//                         ),
//                         const SizedBox(width: 12),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text('Quên mật khẩu',
//                                   style: theme.textTheme.titleLarge?.copyWith(
//                                     fontWeight: FontWeight.w700,
//                                   )),
//                               const SizedBox(height: 4),
//                               Text(
//                                 'Thông tin đã xác thực. Vui lòng tạo mật khẩu mới để tiếp tục.',
//                                 style: theme.textTheme.bodyMedium?.copyWith(
//                                   color: Colors.black.withOpacity(.7),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 16),
//
//                     // Card thông tin (FIX: truyền value trực tiếp, tránh logic dựa vào label)
//                     Card(
//                       color: Colors.white,
//                       elevation: 0,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(16),
//                         side: BorderSide(color: Colors.grey.shade300),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(12),
//                         child: Column(
//                           children: [
//                             _InfoRow(
//                               icon: Icons.badge_outlined,
//                               label: 'Số CCCD',
//                               value: widget.accountOrCccd,
//                             ),
//                             const SizedBox(height: 8),
//                             _InfoRow(
//                               icon: Icons.phone_outlined,
//                               label: 'Số điện thoại',
//                               value: widget.phone,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//
//                     const SizedBox(height: 16),
//
//                     // Mật khẩu mới
//                     TextFormField(
//                       controller: _pw1,
//                       focusNode: _pw1Focus,
//                       onChanged: (v) {
//                         _onPw1Changed(v);
//                         if (_pw2.text.isNotEmpty) setState(() {});
//                       },
//                       decoration: InputDecoration(
//                         labelText: 'Mật khẩu mới',
//                         hintText: 'Nhập mật khẩu mới',
//                         prefixIcon: const Icon(Icons.lock_outline),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         suffixIcon: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             if (_pw1.text.isNotEmpty)
//                               IconButton(
//                                 tooltip: 'Xoá',
//                                 icon: const Icon(Icons.clear),
//                                 onPressed: () {
//                                   _pw1.clear();
//                                   _onPw1Changed('');
//                                   setState(() {});
//                                 },
//                               ),
//                             IconButton(
//                               tooltip: _ob1 ? 'Hiện mật khẩu' : 'Ẩn mật khẩu',
//                               icon: Icon(_ob1
//                                   ? Icons.visibility
//                                   : Icons.visibility_off),
//                               onPressed: () => setState(() => _ob1 = !_ob1),
//                             ),
//                           ],
//                         ),
//                       ),
//                       obscureText: _ob1,
//                       textInputAction: TextInputAction.next,
//                       onFieldSubmitted: (_) =>
//                           FocusScope.of(context).requestFocus(_pw2Focus),
//                       validator: (v) {
//                         if (v == null || v.isEmpty) {
//                           return 'Vui lòng nhập mật khẩu';
//                         }
//                         if (v.length < 8) {
//                           return 'Tối thiểu 8 ký tự';
//                         }
//                         if (!_regSpecial.hasMatch(v)) {
//                           return 'Phải có ít nhất 1 ký tự đặc biệt';
//                         }
//                         return null;
//                       },
//                     ),
//
//                     const SizedBox(height: 12),
//
//                     _PasswordStrengthBar(value: _strength, ok: _isValid),
//                     const SizedBox(height: 8),
//                     _ChecklistCard(
//                       items: [
//                         _Rule(text: 'Tối thiểu 8 ký tự', ok: _rMin),
//                         _Rule(text: 'Có ký tự đặc biệt', ok: _rSpecial),
//                       ],
//                     ),
//
//                     const SizedBox(height: 16),
//
//                     // Nhập lại mật khẩu
//                     TextFormField(
//                       controller: _pw2,
//                       focusNode: _pw2Focus,
//                       decoration: InputDecoration(
//                         labelText: 'Nhập lại mật khẩu',
//                         hintText: 'Nhập lại mật khẩu mới',
//                         prefixIcon: const Icon(Icons.lock_outline),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         suffixIcon: IconButton(
//                           tooltip: _ob2 ? 'Hiện mật khẩu' : 'Ẩn mật khẩu',
//                           icon: Icon(
//                               _ob2 ? Icons.visibility : Icons.visibility_off),
//                           onPressed: () => setState(() => _ob2 = !_ob2),
//                         ),
//                       ),
//                       obscureText: _ob2,
//                       textInputAction: TextInputAction.done,
//                       validator: (v) {
//                         if (v == null || v.isEmpty) {
//                           return 'Vui lòng nhập lại mật khẩu';
//                         }
//                         if (v != _pw1.text) {
//                           return 'Mật khẩu nhập lại không khớp';
//                         }
//                         return null;
//                       },
//                     ),
//
//                     const SizedBox(height: 24),
//
//                     // CTA
//                     SizedBox(
//                       height: 48,
//                       child: ElevatedButton.icon(
//                         icon: _loading
//                             ? const SizedBox(
//                                 width: 18,
//                                 height: 18,
//                                 child: CircularProgressIndicator.adaptive(
//                                   strokeWidth: 2,
//                                   valueColor: AlwaysStoppedAnimation<Color>(
//                                       Colors.white),
//                                 ),
//                               )
//                             : const Icon(Icons.sms_outlined),
//                         label: Text(_loading ? 'Đang gửi...' : 'Gửi mã OTP'),
//                         onPressed: _loading ? null : _sendOtpAndOpenSheet,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: AppColors.primaryColor,
//                           foregroundColor: Colors.white,
//                           disabledBackgroundColor: Colors.grey.shade400,
//                           disabledForegroundColor: Colors.white70,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                       ),
//                     ),
//
//                     const SizedBox(height: 12),
//                     Center(
//                       child: TextButton.icon(
//                         onPressed: () {
//                           showModalBottomSheet<void>(
//                             context: context,
//                             showDragHandle: true,
//                             builder: (c) => const _TipsSheet(),
//                           );
//                         },
//                         icon: Icon(Icons.tips_and_updates_outlined,
//                             color: AppColors.primaryColor),
//                         label: Text(
//                           'Gợi ý tạo mật khẩu an toàn',
//                           style: TextStyle(color: AppColors.primaryColor),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // ---------- Các widget con giữ nguyên (chỉ sửa _InfoRow như ở build) ----------
//
// class _InfoRow extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final String? value;
//   const _InfoRow({required this.icon, required this.label, this.value});
//
//   @override
//   Widget build(BuildContext context) {
//     final v = value ?? '';
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Icon(icon),
//         const SizedBox(width: 10),
//         Text(
//           '$label: ',
//           style: const TextStyle(
//             color: Colors.black87,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         Expanded(
//           child: Text(
//             v,
//             textAlign: TextAlign.right,
//             overflow: TextOverflow.ellipsis,
//             style: const TextStyle(color: Colors.black87),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class _PasswordStrengthBar extends StatelessWidget {
//   final double value; // 0..1
//   final bool ok;
//
//   const _PasswordStrengthBar({required this.value, required this.ok});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         ClipRRect(
//           borderRadius: BorderRadius.circular(8),
//           child: LinearProgressIndicator(
//             minHeight: 8,
//             value: value == 0 ? 0.02 : value,
//             backgroundColor: Colors.black12,
//             valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
//           ),
//         ),
//         const SizedBox(height: 6),
//         Text(
//           ok ? 'Hợp lệ' : 'Chưa hợp lệ',
//           style: TextStyle(
//             color: ok ? AppColors.primaryColor : Colors.redAccent,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class _ChecklistCard extends StatelessWidget {
//   final List<_Rule> items;
//   const _ChecklistCard({required this.items});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey.shade300),
//       ),
//       child: Column(
//         children: items
//             .map((r) => Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 4),
//                   child: Row(
//                     children: [
//                       Icon(
//                         r.ok ? Icons.check_circle : Icons.circle_outlined,
//                         size: 18,
//                         color: r.ok ? AppColors.primaryColor : Colors.grey,
//                       ),
//                       const SizedBox(width: 8),
//                       Expanded(
//                         child: Text(
//                           r.text,
//                           style: TextStyle(
//                             color: Colors.black.withOpacity(r.ok ? 1 : .75),
//                             fontWeight: r.ok ? FontWeight.w600 : null,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ))
//             .toList(),
//       ),
//     );
//   }
// }
//
// class _Rule {
//   final String text;
//   final bool ok;
//   _Rule({required this.text, required this.ok});
// }
//
// class _TipsSheet extends StatelessWidget {
//   const _TipsSheet();
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: const [
//             Row(
//               children: [
//                 Icon(Icons.tips_and_updates_outlined),
//                 SizedBox(width: 8),
//                 Text(
//                   'Gợi ý tạo mật khẩu',
//                   style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
//                 ),
//               ],
//             ),
//             SizedBox(height: 12),
//             _TipRow(text: 'Dùng cụm từ dài, dễ nhớ nhưng khó đoán'),
//             _TipRow(text: 'Tránh thông tin cá nhân (tên, ngày sinh…)'),
//             _TipRow(text: 'Không tái sử dụng mật khẩu cũ ở dịch vụ khác'),
//             _TipRow(text: 'Bật 2FA nếu có thể'),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _TipRow extends StatelessWidget {
//   final String text;
//   const _TipRow({required this.text});
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: Row(
//         children: [
//           Icon(Icons.check, size: 18, color: AppColors.primaryColor),
//           const SizedBox(width: 8),
//           Expanded(child: Text(text)),
//         ],
//       ),
//     );
//   }
// }
//
// /// BottomSheet nhập OTP Firebase, return `String` smsCode qua `Navigator.pop(context, code)`
// class _OtpSheetFirebase extends StatefulWidget {
//   final String phone;
//   final Future<void> Function()? onResend;
//   const _OtpSheetFirebase({required this.phone, this.onResend});
//
//   @override
//   State<_OtpSheetFirebase> createState() => _OtpSheetFirebaseState();
// }
//
// class _OtpSheetFirebaseState extends State<_OtpSheetFirebase> {
//   final _code = TextEditingController();
//   bool _submitting = false;
//   int _count = 60;
//   Timer? _t;
//
//   @override
//   void initState() {
//     super.initState();
//     _t = Timer.periodic(const Duration(seconds: 1), (t) {
//       if (!mounted) return;
//       setState(() {
//         if (_count > 0) _count--;
//         if (_count == 0) t.cancel();
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     _t?.cancel();
//     _code.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Padding(
//         padding:
//             EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom) +
//                 const EdgeInsets.fromLTRB(16, 12, 16, 16),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Icon(Icons.sms_outlined, size: 28),
//             const SizedBox(height: 8),
//             Text('Nhập OTP gửi tới ${widget.phone}',
//                 style: const TextStyle(fontWeight: FontWeight.w700)),
//             const SizedBox(height: 12),
//             TextField(
//               controller: _code,
//               keyboardType: TextInputType.number,
//               textInputAction: TextInputAction.done,
//               maxLength: 6,
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: '6 chữ số',
//                 counterText: '',
//               ),
//               onSubmitted: (_) async {
//                 if (_code.text.length == 6) {
//                   Navigator.pop(context, _code.text.trim());
//                 }
//               },
//             ),
//             const SizedBox(height: 8),
//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: _submitting
//                         ? null
//                         : () => Navigator.pop(context, _code.text.trim()),
//                     child: _submitting
//                         ? const SizedBox(
//                             width: 18,
//                             height: 18,
//                             child: CircularProgressIndicator(strokeWidth: 2),
//                           )
//                         : const Text('Xác nhận'),
//                   ),
//                 ),
//               ],
//             ),
//             TextButton(
//               onPressed: (_count > 0 || widget.onResend == null)
//                   ? null
//                   : () async {
//                       setState(() => _count = 60);
//                       _t?.cancel();
//                       _t = Timer.periodic(const Duration(seconds: 1), (t) {
//                         if (!mounted) return;
//                         setState(() {
//                           if (_count > 0) _count--;
//                           if (_count == 0) t.cancel();
//                         });
//                       });
//                       await widget.onResend!.call();
//                     },
//               child: Text(
//                 _count > 0 ? 'Gửi lại OTP ($_count)' : 'Gửi lại OTP',
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pstb/widgets/stateless/app_snack_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../constant/color.dart';
import '../../../../services/api_base_helper.dart';
import '../../../../utils/api_url.dart';
import '../../../../widgets/stateless/app_bar.dart';
import '../../../models/reset_password_model.dart';

class ResetPasswordScreenV2 extends StatefulWidget {
  final String accountOrCccd;
  final String phone; // E.164 format

  const ResetPasswordScreenV2({
    super.key,
    required this.accountOrCccd,
    required this.phone,
  });

  @override
  State<ResetPasswordScreenV2> createState() => _ResetPasswordScreenV2State();
}

class _ResetPasswordScreenV2State extends State<ResetPasswordScreenV2> {
  final _formKey = GlobalKey<FormState>();
  final _pw1 = TextEditingController();
  final _pw2 = TextEditingController();
  final _pw1Focus = FocusNode();
  final _pw2Focus = FocusNode();

  bool _ob1 = true, _ob2 = true;
  bool _loading = false;

  // Password validation rules
  bool _rMin = false, _rSpecial = false;
  int get _metCount => [_rMin, _rSpecial].where((e) => e).length;
  double get _strength => (_metCount / 2).clamp(0, 1);
  bool get _isValid => _metCount == 2;

  final RegExp _regSpecial = RegExp(r'[^\w\s]');

  String? _lastOtpCode;
  int _otpAttempts = 0;
  DateTime? _lastOtpTime;
  ValueNotifier<int> _countdownNotifier =
      ValueNotifier<int>(0); // Thêm ValueNotifier
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _loadOtpData();
  }

  @override
  void dispose() {
    _pw1.dispose();
    _pw2.dispose();
    _pw1Focus.dispose();
    _pw2Focus.dispose();
    _countdownNotifier.dispose(); // Hủy ValueNotifier
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _loadOtpData() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now().toIso8601String().substring(0, 10);
    final storedDate = prefs.getString('otp_date') ?? '';
    final attempts = prefs.getInt('otp_attempts') ?? 0;
    print(today);
    if (storedDate == today) {
      setState(() => _otpAttempts = attempts);
    } else {
      await prefs.setString('otp_date', today);
      await prefs.setInt('otp_attempts', 0);
      setState(() => _otpAttempts = 0);
    }
  }

  void _onPw1Changed(String v) {
    setState(() {
      _rMin = v.length >= 8;
      _rSpecial = _regSpecial.hasMatch(v);
    });
  }

  void _snack(AppSnackBarType type, String msg) {
    if (!mounted) return;
    AppSnackBar.show(context, type, msg);
  }

  Future<String?> _sendOtp() async {
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();

    print("=== SEND OTP START ===");
    print("Phone: ${widget.phone}");
    print("Attempts today: $_otpAttempts");
    print("Last OTP time: $_lastOtpTime");

    if (_otpAttempts >= 3) {
      print("STOP: Too many attempts");
      _snack(AppSnackBarType.Error, 'Đã vượt quá 3 lần gửi OTP trong ngày');
      return null;
    }

    if (_lastOtpTime != null && now.difference(_lastOtpTime!).inSeconds < 90) {
      final remain = 90 - now.difference(_lastOtpTime!).inSeconds;
      print("STOP: Cooldown remaining $remain sec");
      _snack(AppSnackBarType.Error, 'Vui lòng đợi ${remain}s để gửi lại OTP');
      return null;
    }

    try {
      final formattedPhone = widget.phone.startsWith('+')
          ? widget.phone.substring(1)
          : widget.phone;

      print("Request → POST /send-sms");
      print({"Phone": formattedPhone});

      final response = await http.post(
        Uri.parse('https://113.160.200.31:6443/api/User/send-sms'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'Phone': formattedPhone}),
      );

      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final bodyJson = jsonDecode(response.body);

        final otpCode = bodyJson['data']?.toString().trim() ?? '';

        print("OTP RECEIVED: $otpCode"); // LOG: OTP thật (DEBUG)

        setState(() {
          _otpAttempts++;
          _lastOtpTime = now;
          _countdownNotifier.value = 90;
          _lastOtpCode = otpCode;
        });

        await prefs.setInt('otp_attempts', _otpAttempts);

        print("Updated attempts: $_otpAttempts");
        print("=== SEND OTP END ===");

        _startCountdown();
        return otpCode;
      } else {
        print("OTP Error: ${response.statusCode}");
        _snack(
            AppSnackBarType.Error, 'Gửi OTP thất bại: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print("SEND OTP EXCEPTION: $e");
      _snack(AppSnackBarType.Error, 'Gửi OTP thất bại: $e');
      return null;
    }
  }

  void _startCountdown() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_countdownNotifier.value > 0) {
        _countdownNotifier.value--; // Cập nhật ValueNotifier
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> _resetWithApi({
    required String newPassword,
    required String otpCode,
  }) async {
    print("=== VERIFY OTP START ===");
    print("User entered OTP: $otpCode");
    print("Server OTP: $_lastOtpCode");

    if (otpCode != _lastOtpCode) {
      print("OTP MISMATCH → FAIL");
      _snack(AppSnackBarType.Error, 'Mã OTP không đúng');
      return;
    }

    print("OTP VERIFIED → Calling API...");

    try {
      final formattedUsername = widget.phone.startsWith('+84')
          ? '0${widget.phone.substring(3)}'
          : widget.phone;

      final body = ForgotPasswordModel(
        username: formattedUsername,
        newPassword: newPassword,
        confirmPassword: newPassword,
        key: ApiConstance.changePasswordKey,
      ).toRawJson();

      print("Reset Password → PUT ${ApiUrl.forgotPassword}");
      print("Body: $body");

      await ApiBaseHelper().put(ApiUrl.forgotPassword, body);

      print("RESET PASSWORD SUCCESS");

      _snack(AppSnackBarType.Success, 'Đổi mật khẩu thành công');

      if (mounted) Navigator.of(context).popUntil((r) => r.isFirst);
    } catch (e) {
      print("RESET PASSWORD ERROR: $e");
      _snack(AppSnackBarType.Error, 'Đổi mật khẩu thất bại: $e');
    }

    print("=== VERIFY END ===");
  }

  Future<void> _sendOtpAndOpenSheet() async {
    if (!_formKey.currentState!.validate()) {
      setState(() {});
      return;
    }
    final newPw = _pw1.text;

    setState(() => _loading = true);
    try {
      final otpCode = await _sendOtp();
      if (otpCode == null) return;

      final enteredCode = await showModalBottomSheet<String>(
        backgroundColor: Colors.white,
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        builder: (_) => _OtpSheet(
          phone: widget.phone,
          onResend: _sendOtp,
          countdownNotifier: _countdownNotifier, // Truyền ValueNotifier
        ),
      );
      print("User entered OTP from sheet: $enteredCode");

      if (!mounted) return;

      if (enteredCode != null && enteredCode.isNotEmpty) {
        await _resetWithApi(newPassword: newPw, otpCode: enteredCode);
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: CustomAppBar(title: 'Đặt lại mật khẩu'),
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                  children: [
                    // Header
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor:
                              AppColors.primaryColor.withOpacity(.12),
                          foregroundColor: AppColors.primaryColor,
                          child: const Icon(Icons.lock_reset_outlined),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Quên mật khẩu',
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  )),
                              const SizedBox(height: 4),
                              Text(
                                'Thông tin đã xác thực. Vui lòng tạo mật khẩu mới để tiếp tục.',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.black.withOpacity(.7),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Card thông tin
                    Card(
                      color: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(color: Colors.grey.shade300),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            _InfoRow(
                              icon: Icons.badge_outlined,
                              label: 'Số CCCD',
                              value: widget.accountOrCccd,
                            ),
                            const SizedBox(height: 8),
                            _InfoRow(
                              icon: Icons.phone_outlined,
                              label: 'Số điện thoại',
                              value: widget.phone,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Mật khẩu mới
                    TextFormField(
                      controller: _pw1,
                      focusNode: _pw1Focus,
                      onChanged: (v) {
                        _onPw1Changed(v);
                        if (_pw2.text.isNotEmpty) setState(() {});
                      },
                      decoration: InputDecoration(
                        labelText: 'Mật khẩu mới',
                        hintText: 'Nhập mật khẩu mới',
                        prefixIcon: const Icon(Icons.lock_outline),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (_pw1.text.isNotEmpty)
                              IconButton(
                                tooltip: 'Xoá',
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  _pw1.clear();
                                  _onPw1Changed('');
                                  setState(() {});
                                },
                              ),
                            IconButton(
                              tooltip: _ob1 ? 'Hiện mật khẩu' : 'Ẩn mật khẩu',
                              icon: Icon(_ob1
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () => setState(() => _ob1 = !_ob1),
                            ),
                          ],
                        ),
                      ),
                      obscureText: _ob1,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).requestFocus(_pw2Focus),
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return 'Vui lòng nhập mật khẩu';
                        }
                        if (v.length < 8) {
                          return 'Tối thiểu 8 ký tự';
                        }
                        if (!_regSpecial.hasMatch(v)) {
                          return 'Phải có ít nhất 1 ký tự đặc biệt';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 12),

                    _PasswordStrengthBar(value: _strength, ok: _isValid),
                    const SizedBox(height: 8),
                    _ChecklistCard(
                      items: [
                        _Rule(text: 'Tối thiểu 8 ký tự', ok: _rMin),
                        _Rule(text: 'Có ký tự đặc biệt', ok: _rSpecial),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Nhập lại mật khẩu
                    TextFormField(
                      controller: _pw2,
                      focusNode: _pw2Focus,
                      decoration: InputDecoration(
                        labelText: 'Nhập lại mật khẩu',
                        hintText: 'Nhập lại mật khẩu mới',
                        prefixIcon: const Icon(Icons.lock_outline),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        suffixIcon: IconButton(
                          tooltip: _ob2 ? 'Hiện mật khẩu' : 'Ẩn mật khẩu',
                          icon: Icon(
                              _ob2 ? Icons.visibility : Icons.visibility_off),
                          onPressed: () => setState(() => _ob2 = !_ob2),
                        ),
                      ),
                      obscureText: _ob2,
                      textInputAction: TextInputAction.done,
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return 'Vui lòng nhập lại mật khẩu';
                        }
                        if (v != _pw1.text) {
                          return 'Mật khẩu nhập lại không khớp';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 24),

                    // CTA
                    SizedBox(
                      height: 48,
                      child: ElevatedButton.icon(
                        icon: _loading
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator.adaptive(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              )
                            : const Icon(Icons.sms_outlined),
                        label: Text(_loading ? 'Đang gửi...' : 'Gửi mã OTP'),
                        onPressed: _loading ? null : _sendOtpAndOpenSheet,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          foregroundColor: Colors.white,
                          disabledBackgroundColor: Colors.grey.shade400,
                          disabledForegroundColor: Colors.white70,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),
                    Center(
                      child: TextButton.icon(
                        onPressed: () {
                          showModalBottomSheet<void>(
                            context: context,
                            showDragHandle: true,
                            builder: (c) => const _TipsSheet(),
                          );
                        },
                        icon: Icon(Icons.tips_and_updates_outlined,
                            color: AppColors.primaryColor),
                        label: Text(
                          'Gợi ý tạo mật khẩu an toàn',
                          style: TextStyle(color: AppColors.primaryColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Existing child widgets (_InfoRow, _PasswordStrengthBar, _ChecklistCard, _Rule, _TipsSheet, _TipRow) remain unchanged
class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? value;
  const _InfoRow({required this.icon, required this.label, this.value});

  @override
  Widget build(BuildContext context) {
    final v = value ?? '';
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon),
        const SizedBox(width: 10),
        Text(
          '$label: ',
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
        Expanded(
          child: Text(
            v,
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.black87),
          ),
        ),
      ],
    );
  }
}

class _PasswordStrengthBar extends StatelessWidget {
  final double value;
  final bool ok;

  const _PasswordStrengthBar({required this.value, required this.ok});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            minHeight: 8,
            value: value == 0 ? 0.02 : value,
            backgroundColor: Colors.black12,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          ok ? 'Hợp lệ' : 'Chưa hợp lệ',
          style: TextStyle(
            color: ok ? AppColors.primaryColor : Colors.redAccent,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _ChecklistCard extends StatelessWidget {
  final List<_Rule> items;
  const _ChecklistCard({required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: items
            .map((r) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Icon(
                        r.ok ? Icons.check_circle : Icons.circle_outlined,
                        size: 18,
                        color: r.ok ? AppColors.primaryColor : Colors.grey,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          r.text,
                          style: TextStyle(
                            color: Colors.black.withOpacity(r.ok ? 1 : .75),
                            fontWeight: r.ok ? FontWeight.w600 : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class _Rule {
  final String text;
  final bool ok;
  _Rule({required this.text, required this.ok});
}

class _TipsSheet extends StatelessWidget {
  const _TipsSheet();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Row(
              children: [
                Icon(Icons.tips_and_updates_outlined),
                SizedBox(width: 8),
                Text(
                  'Gợi ý tạo mật khẩu',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                ),
              ],
            ),
            SizedBox(height: 12),
            _TipRow(text: 'Dùng cụm từ dài, dễ nhớ nhưng khó đoán'),
            _TipRow(text: 'Tránh thông tin cá nhân (tên, ngày sinh…)'),
            _TipRow(text: 'Không tái sử dụng mật khẩu cũ ở dịch vụ khác'),
            _TipRow(text: 'Bật 2FA nếu có thể'),
          ],
        ),
      ),
    );
  }
}

class _TipRow extends StatelessWidget {
  final String text;
  const _TipRow({required this.text});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(Icons.check, size: 18, color: AppColors.primaryColor),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

class _OtpSheet extends StatefulWidget {
  final String phone;
  final Future<String?> Function()? onResend;
  final ValueNotifier<int>
      countdownNotifier; // Thay countdown bằng ValueNotifier

  const _OtpSheet({
    required this.phone,
    this.onResend,
    required this.countdownNotifier,
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
    for (var c in _controllers) {
      c.dispose();
    }
    for (var f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onCodeChanged(int index, String value) {
    print("OTP Input [$index]: $value");

    if (value.isNotEmpty && index < 5) {
      _focusNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
    if (index == 5 && value.isNotEmpty) {
      _submitCode();
    }
  }

  void _submitCode() {
    final code = _controllers.map((c) => c.text).join();
    print("Submitting OTP code: $code");

    if (code.length == 6) {
      Navigator.pop(context, code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 16) +
            const EdgeInsets.fromLTRB(16, 12, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.sms_outlined, size: 32, color: AppColors.primaryColor),
            const SizedBox(height: 12),
            Text(
              'Nhập mã OTP',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Mã OTP đã được gửi tới ${widget.phone}',
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(6, (index) {
                return Container(
                  width: 48,
                  height: 56,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  child: TextField(
                    controller: _controllers[index],
                    focusNode: _focusNodes[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    decoration: InputDecoration(
                      counterText: '',
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: AppColors.primaryColor),
                      ),
                    ),
                    onChanged: (value) => _onCodeChanged(index, value),
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _submitting
                    ? null
                    : () {
                        setState(() => _submitting = true);
                        _submitCode();
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _submitting
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text('Xác nhận', style: TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(height: 12),
            ValueListenableBuilder<int>(
              valueListenable: widget.countdownNotifier,
              builder: (context, countdown, child) {
                return TextButton(
                  onPressed: (countdown > 0 ||
                          widget.onResend == null ||
                          _submitting)
                      ? null
                      : () async {
                          setState(() => _submitting = true);
                          final newOtp = await widget.onResend!();
                          if (newOtp != null && mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Đã gửi lại OTP')),
                            );
                          }
                          if (mounted) {
                            setState(() => _submitting = false);
                          }
                        },
                  child: Text(
                    countdown > 0
                        ? 'Gửi lại OTP (${countdown}s)'
                        : 'Gửi lại OTP',
                    style: TextStyle(
                      color:
                          countdown > 0 ? Colors.grey : AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
