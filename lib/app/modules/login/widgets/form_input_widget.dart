import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pstb/app/app_store.dart';
import 'package:pstb/app/modules/emergency/emergency_store.dart';
import 'package:pstb/app/modules/login/login_store.dart';
import 'package:pstb/app/modules/login/widgets/button_login_widget.dart';
import 'package:pstb/app/modules/login/widgets/remove_phone_widget.dart';
import 'package:pstb/app/modules/profile/pages/setting/setting_store.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/utils/sessions/session_prefs.dart';
import 'package:pstb/widgets/stateful/app_input.dart';
import 'package:pstb/widgets/stateful/touchable_opacity.dart';
import 'package:pstb/widgets/stateless/app_dialog_confirm.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';
import 'package:url_launcher/url_launcher_string.dart';

class FormInputWidget extends StatefulWidget {
  const FormInputWidget(
      {Key? key,
      required this.phoneController,
      required this.passwordController})
      : super(key: key);
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  @override
  State<FormInputWidget> createState() => _FormInputWidgetState();
}

class _FormInputWidgetState extends State<FormInputWidget> {
  final _formKey = GlobalKey<FormState>();
  final _loginStore = Modular.get<LoginStore>();
  final _settingStore = Modular.get<SettingStore>();
  final _store = Modular.get<AppStore>();
  final _emergencyStore = Modular.get<EmergencyStore>();

  void _showDialogForgot(BuildContext context) async {
    await showDialog<bool>(
      context: context,
      builder: (c) => DialogConfirm(
        title: 'Thông báo',
        subTitle:
            'Vui lòng liên hệ tổng đài hỗ trợ để được hướng dẫn lấy lại mật khẩu',
        buttonRight: 'Hủy bỏ',
        buttonLeft: 'Gọi ngay',
        onButtonLeft: () async {
          await launchUrlString('tel://${_emergencyStore.supportPhoneNumber}')
              .then(
                  (value) => Navigator.of(context, rootNavigator: true).pop());
        },
        onButtonRight: () {
          Navigator.of(context, rootNavigator: true).pop();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Observer(
          builder: (_) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  InkWell(
                    focusColor: AppColors.transparent,
                    onTap: () async {
                      if (_loginStore.phoneNumberCache.isNotEmpty) {
                        final isClear = await showDialog(
                            context: context,
                            builder: (_) {
                              return RemovePhoneWidget();
                            });
                        if (isClear) {
                          widget.phoneController.clear();
                          _loginStore.phoneNumber = '';
                        }
                      }
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(right: 16.0, left: 8.0),
                          child: SvgPicture.asset(
                            IconEnums.phone,
                            height: 24,
                          ),
                        ),
                        Expanded(
                          child: IgnorePointer(
                            ignoring: _loginStore.phoneNumberCache.isNotEmpty,
                            child: AppInput(
                              controller: widget.phoneController,
                              validator: (phoneNumber) {
                                if (phoneNumber == null ||
                                    phoneNumber.trim().isEmpty) {
                                  return l10n(context).validate_empty;
                                }
                                if (!Reges.regIsPhone
                                    .hasMatch(phoneNumber.trim())) {
                                  return l10n(context)!.validate_phone;
                                }
                                return null;
                              },
                              enabled: true,
                              hintText: l10n(context).login_phone,
                              onTapIconRight: () async {
                                widget.phoneController.clear();
                              },
                              iconRight: IconEnums.close,
                              onChangeValue: _loginStore.onChangePhoneNumber,
                              keyboardType: TextInputType.phone,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0, left: 8.0),
                        child: SvgPicture.asset(
                          IconEnums.lock,
                          height: 24,
                        ),
                      ),
                      Expanded(
                        child: AppInput(
                          controller: widget.passwordController,
                          maxLine: 1,
                          validator: (password) {
                            if (password == null || password.isEmpty) {
                              return l10n(context)!.validate_empty;
                            }
                            if (password.length < 8) {
                              return "Tối thiểu 8 ký tự";
                            }
                            if (!Reges.regIsPassword.hasMatch(password)) {
                              return "Cần chứa ký tự đặc biệt";
                            }
                            return null;
                          },
                          hintText: l10n(context)!.login_password,
                          obscureText: true,
                          onChangeValue: _loginStore.onChangePassword,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                          child: Text(
                            l10n(context).login_forgot_password,
                            style: Styles.content
                                .copyWith(color: AppColors.primary),
                          ),
                          onTap: () {
                            Modular.to.pushNamed(AppRoutes.forgotPage);
                          }

                          // _store.enableForgotOTP
                          //     ? () {
                          //         Modular.to.pushNamed(
                          //             AppRoutes.includePhoneNumber,
                          //             arguments: {"routeName": AppRoutes.forgot});
                          //       }
                          //     : _showDialogForgot(context),
                          ),
                    ],
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                ],
              ),
            );
          },
        ),
        ButtonLoginWidget(
          onLogin: () async {
            if (_formKey.currentState!.validate()) {
              await _loginStore.onLogin();
            }
          },
          onBiometric: () async {
            _settingStore.isActiveFinger = await SessionPrefs.getActiveFinger();
            print('${_settingStore.isActiveFinger}');
            if (_settingStore.isActiveFinger) {
              await _loginStore.biometricAuth(context);
              return;
            }
            showDialog(
                context: context,
                builder: (_) {
                  return CupertinoAlertDialog(
                    title: const Text("Lỗi đăng nhập"),
                    content: const Text(
                        "Bạn chưa cài đặt Touch ID/Face ID để sử dụng chức năng này. Vui lòng sử dụng mật khẩu để đăng nhập."),
                    actions: <Widget>[
                      CupertinoDialogAction(
                        child: const Text("Ok"),
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                      ),
                    ],
                  );
                });
          },
        ),
        // if (Platform.isIOS)
        //   Padding(
        //     padding: const EdgeInsets.only(top: 4.0),
        //     child: SignInWithAppleButton(
        //         borderRadius: BorderRadius.circular(22),
        //         style: SignInWithAppleButtonStyle.white,
        //         onPressed: () {
        //           _loginStore.loginApple();
        //         }),
        //   ),
        // const Spacer(),
        const SizedBox(
          height: 16.0,
        ),
        // const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bạn chưa có tài khoản? ',
              style: Styles.content,
            ),
            TouchableOpacity(
              child: Text(
                'Đăng ký',
                style: Styles.content.copyWith(
                    color: AppColors.primary, fontWeight: FontWeight.bold),
              ),
              onTap: () => Modular.to.pushNamed(AppRoutes.signup),
            ),
          ],
        ),
        // AppButton(
        //   title: 'Facebook',
        //   onPressed: () async{
        //     await _loginStore.loginFacebook();
        //   },
        //   iconLeft: IconEnums.facebookLogo,
        //   iconRightColor: AppColors.background,
        // )
      ],
    );
  }
}
