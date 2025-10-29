import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pstb/app/modules/forgot_password_v2/presentation/reset_password_screen_v2.dart';
import 'package:pstb/utils/app_extensions.dart';

// TODO: import helper/API items phù hợp với project của bạn
// import 'package:pstb/data/api_base_helper.dart';
// import 'package:pstb/constant/api_url.dart';

import '../../../../constant/color.dart';
import '../../../../services/api_base_helper.dart';
import '../../../../utils/api_url.dart';
import '../../../../widgets/stateless/app_bar.dart';
import '../../../../widgets/stateless/app_snack_bar.dart';

class ForgotPasswordScreenV2 extends StatefulWidget {
  const ForgotPasswordScreenV2({super.key});

  @override
  State<ForgotPasswordScreenV2> createState() => _ForgotPasswordScreenV2State();
}

class _ForgotPasswordScreenV2State extends State<ForgotPasswordScreenV2> {
  final _formKey = GlobalKey<FormState>();
  final _userOrCccdCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();

  final _userFocus = FocusNode();
  final _phoneFocus = FocusNode();

  bool _submitting = false;

  // Style cục bộ
  static const _kRadius = 14.0;

  // TODO: replace/initialize theo implement của bạn
  // If you have a singleton: ApiBaseHelper.instance or similar, use that.
  // final _apiBaseHelper = ApiBaseHelper();
  final ApiBaseHelper _apiBaseHelper = ApiBaseHelper(enableLogging: true);

  @override
  void initState() {
    super.initState();
    _userOrCccdCtrl.addListener(_onFieldsChanged);
    _phoneCtrl.addListener(_onFieldsChanged);
  }

  @override
  void dispose() {
    _userOrCccdCtrl
      ..removeListener(_onFieldsChanged)
      ..dispose();
    _phoneCtrl
      ..removeListener(_onFieldsChanged)
      ..dispose();
    _userFocus.dispose();
    _phoneFocus.dispose();
    super.dispose();
  }

  void _onFieldsChanged() {
    if (mounted) setState(() {});
  }

  bool get _isFormValid =>
      (_formKey.currentState?.validate() ?? false) &&
      _userOrCccdCtrl.text.trim().isNotEmpty &&
      _phoneCtrl.text.trim().isNotEmpty;

  InputDecoration _inputDec({
    required String label,
    required String hint,
    required IconData icon,
    Widget? suffix,
  }) {
    final brand = AppColors.primaryColor;
    final lightBlue = brand.withOpacity(.20); // viền nhạt giống ảnh
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon, color: Colors.black),
      suffixIcon: suffix,
      filled: true,
      fillColor: Colors.white,
      labelStyle: const TextStyle(color: Colors.black87),
      hintStyle: const TextStyle(color: Colors.grey),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_kRadius),
        borderSide: BorderSide(color: lightBlue),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_kRadius),
        borderSide: BorderSide(color: brand, width: 1.6),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_kRadius),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_kRadius),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1.6),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    );
  }

  /// Gọi API để kiểm tra xem số điện thoại đã tồn tại hay chưa.
  /// Trả về `true` nếu tồn tại (được đăng ký), `false` nếu không tồn tại.
  Future<bool> _checkPhoneDuplicated(String phoneNumber) async {
    // Nếu bạn có _apiBaseHelper, gọi tương ứng:
    try {
      final isExist = await _apiBaseHelper.get(
        ApiUrl.isExistAccount,
        {"username": phoneNumber},
      );
      return isExist == true;
    } catch (e) {
      throw UnimplementedError(
          '_checkPhoneDuplicated: please provide ApiBaseHelper and ApiUrl implementation');
    }

    // Nếu chưa có helper ở đây, ném lỗi để dev biết phải cấu hình
  }

  Future<void> _goNext() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    setState(() => _submitting = true);

    final acc = _userOrCccdCtrl.text.trim();
    final phone = _phoneCtrl.text.toE164VN();

    // Gọi API để kiểm tra số điện thoại đã được đăng ký hay chưa.
    try {
      final exists = await _checkPhoneDuplicated(_phoneCtrl.text.trim());

      if (!mounted) return;

      if (!exists) {
        // Nếu số điện thoại chưa tồn tại: thông báo cho user
        AppSnackBar.show(
          context,
          AppSnackBarType.Error,
          'Số điện thoại chưa được đăng ký hoặc không khớp CCCD. Vui lòng kiểm tra lại.',
        );
        setState(() => _submitting = false);
        return;
      }

      // Nếu tồn tại -> chuyển sang màn reset password
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ResetPasswordScreenV2(
            accountOrCccd: acc,
            phone: phone,
          ),
        ),
      );
    } on UnimplementedError catch (e) {
      // Dev reminder: chưa cấu hình API helper
      if (mounted) {
        AppSnackBar.show(
          context,
          AppSnackBarType.Error,
          'API helper chưa được cấu hình. Vui lòng kiểm tra implement.',
        );
      }
    } catch (e) {
      // Lỗi mạng / API
      if (mounted) {
        AppSnackBar.show(
          context,
          AppSnackBarType.Error,
          'Không thể kiểm tra số điện thoại. Vui lòng thử lại.',
        );
      }
    } finally {
      if (!mounted) return;
      setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final brand = AppColors.primaryColor;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: 'Quên mật khẩu',
        ),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final maxWidth = constraints.maxWidth;
              final cardWidth = maxWidth > 620 ? 540.0 : double.infinity;

              return Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints.tightFor(width: cardWidth),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        16, 8, 16, 12 + (bottomInset > 0 ? 8 : 0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header block giống ảnh: nền xanh rất nhạt + tiêu đề xanh đậm
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                          decoration: BoxDecoration(
                            color: brand.withOpacity(.07),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Quên mật khẩu',
                                style: TextStyle(
                                  color: brand,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'Nhập thông tin tài khoản để nhận mã OTP đặt lại mật khẩu',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Card form trắng nổi khối nhẹ
                        Card(
                          color: Colors.white,
                          elevation: 6,
                          shadowColor: brand.withOpacity(.15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                            child: Form(
                              key: _formKey,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: _userOrCccdCtrl,
                                    focusNode: _userFocus,
                                    decoration: _inputDec(
                                      label: 'CCCD',
                                      hint: 'Nhập CCCD',
                                      icon: Icons.person_outline_rounded,
                                      suffix: _userOrCccdCtrl.text.isEmpty
                                          ? null
                                          : IconButton(
                                              tooltip: 'Xoá',
                                              icon: const Icon(
                                                  Icons.clear_rounded,
                                                  color: Colors.black),
                                              onPressed: () =>
                                                  _userOrCccdCtrl.clear(),
                                            ),
                                    ),
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (_) =>
                                        _phoneFocus.requestFocus(),
                                    validator: (v) => (v ?? '').isUserOrCccd
                                        ? null
                                        : 'Vui lòng nhập hợp lệ',
                                  ),
                                  const SizedBox(height: 20),
                                  TextFormField(
                                    controller: _phoneCtrl,
                                    focusNode: _phoneFocus,
                                    decoration: _inputDec(
                                      label: 'Số điện thoại',
                                      hint: 'Nhập số điện thoại của bạn',
                                      icon: Icons.phone_outlined,
                                      suffix: _phoneCtrl.text.isEmpty
                                          ? null
                                          : IconButton(
                                              tooltip: 'Xoá',
                                              icon: const Icon(
                                                  Icons.clear_rounded,
                                                  color: Colors.black),
                                              onPressed: () =>
                                                  _phoneCtrl.clear(),
                                            ),
                                    ).copyWith(
                                      helperText:
                                          'Chúng tôi sẽ gửi mã OTP qua số này',
                                      helperStyle:
                                          const TextStyle(color: Colors.black),
                                    ),
                                    keyboardType: TextInputType.phone,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9+ ]')),
                                    ],
                                    validator: (v) => (v ?? '').isVNPhone
                                        ? null
                                        : 'Số điện thoại chưa đúng',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const Spacer(),

                        // CTA
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: FilledButton(
                            style: FilledButton.styleFrom(
                              backgroundColor: brand,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(_kRadius),
                              ),
                            ),
                            onPressed:
                                _submitting || !_isFormValid ? null : _goNext,
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 220),
                              transitionBuilder: (child, anim) =>
                                  FadeTransition(opacity: anim, child: child),
                              child: _submitting
                                  ? const SizedBox(
                                      key: ValueKey('loading'),
                                      width: 22,
                                      height: 22,
                                      child: CircularProgressIndicator(
                                          strokeWidth: 2, color: Colors.white),
                                    )
                                  : const Row(
                                      key: ValueKey('text'),
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.arrow_forward, size: 20),
                                        SizedBox(width: 6),
                                        Text('Tiếp theo',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600)),
                                      ],
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
