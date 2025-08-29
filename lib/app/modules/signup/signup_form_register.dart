import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pstb/app/modules/signup/widgets/signup_process.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateful/stateful_widget.dart';
import 'package:pstb/widgets/stateless/build_hotline.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';
import '../../../widgets/stateless/build_rules_secure.dart';
import 'signup_store.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final SignupStore _controller = Modular.get<SignupStore>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _controller.changeBuildContext(context);
    _controller.changePhoneNumber("");
    _controller.changePassword("");
    _controller.changeConfirmPass("");
    super.initState();
  }

  void onSubmit() {
    _controller.onCheckUnique();
    //_controller.onRegisterV2();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: WillPopScope(
        onWillPop: () {
          if (EasyLoading.isShow) {
            return Future.value(false);
          } else {
            return Future.value(true);
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SignUpProcess(
                      currentProcess: SignUpProcessEnum.Step1,
                    ),
                    Observer(
                      builder: (context) {
                        return Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                l10n(context)!.signup_title,
                                style: Styles.heading2
                                    .copyWith(color: AppColors.primary),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: heightConvert(context, 25),
                                ),
                                child: AppInput(
                                  iconLeft: IconEnums.phone,
                                  hintText: l10n(context)!.phone_number,
                                  validationError:
                                      _controller.validatePhoneNumber,
                                  errorText: _controller.phoneValidResponse,
                                  onChangeValue: _controller.changePhoneNumber,
                                  keyboardType: TextInputType.phone,
                                ),
                              ),
                              AppInput(
                                maxLine: 1,
                                iconLeft: IconEnums.lock,
                                iconRight: IconEnums.eyeOff,
                                hintText: l10n(context)!.forgot_hint_pass,
                                validationError: _controller.validatePassword,
                                onChangeValue: _controller.changePassword,
                                obscureText: true,
                                listFormat: [
                                  FilteringTextInputFormatter.deny(
                                      RegExp(r'[ ]')),
                                ],
                              ),
                              AppInput(
                                maxLine: 1,
                                iconLeft: IconEnums.lock,
                                iconRight: IconEnums.eyeOff,
                                hintText:
                                    l10n(context)!.forgot_hint_confirm_pass,
                                validationError:
                                    _controller.validateConfirmPass,
                                onChangeValue: _controller.changeConfirmPass,
                                obscureText: true,
                                listFormat: [
                                  FilteringTextInputFormatter.deny(
                                      RegExp(r'[ ]')),
                                ],
                              ),
                              AppButton(
                                title: l10n(context)!
                                    .signup_btn_signup
                                    .toString()
                                    .toUpperCase(),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    onSubmit();
                                  }
                                  // Modular.to.pushNamed(AppRoutes.signupInfo);
                                },
                                iconRight: IconEnums.user_plus,
                                isLeftGradient: true,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    BuildRulesSecure(
                      onRule: () {
                        Modular.to.pushNamed(AppRoutes.webView,
                            arguments:
                                'https://onenet.vn/chinh-sach-bao-mat-thong-tin');
                      },
                      onSecure: () {
                        Modular.to.pushNamed(AppRoutes.webView,
                            arguments:
                                'https://onenet.vn/chinh-sach-bao-mat-thong-tin');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: BuildHotline2(
            widget: widget,
          ),
        ),
      ),
    );
  }
}

class BuildHotline2 extends StatelessWidget {
  const BuildHotline2({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final SignupForm widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              l10n(context)!.forgot_text_callOut,
              style: Styles.subtitleLarge.copyWith(color: AppColors.neutral600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: AppButtonOutline(
              text: l10n(context)!.hotline.toString().toUpperCase(),
              phoneNumber: Constants.contactPhone,
            ),
          )
        ],
      ),
    );
  }
}
