import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pstb/app/app_store.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateful/stateful_widget.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';
import '../../../widgets/stateless/build_hotline.dart';
import 'change_password_store.dart';

class ChangePasswordForm extends StatefulWidget {
  const ChangePasswordForm({Key? key}) : super(key: key);

  @override
  _ChangePasswordFormState createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  final ChangePasswordStore _controller = Modular.get<ChangePasswordStore>();
  final _formKey = GlobalKey<FormState>();
  final _appController = Modular.get<AppStore>();
  @override
  void initState() {
    _controller.changeBuildContext(context);
    super.initState();
  }

  @override
  void dispose() {
    Modular.dispose<ChangePasswordStore>();
    super.dispose();
  }

  void onSubmit() {
    FocusScope.of(context).unfocus();
    _controller.putChangePassword();
    //Modular.to.pushNamed(AppRoutes.changePasswordOtp);
  }

  void onRule() {
    Modular.to.pushNamed(AppRoutes.webView,
        arguments: 'https://onenet.vn/chinh-sach-bao-mat-thong-tin');
  }

  void onSecure() {
    Modular.to.pushNamed(AppRoutes.webView,
        arguments: 'https://onenet.vn/chinh-sach-bao-mat-thong-tin');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.background,
        appBar: CustomAppBar(
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.grayLight,
            size: Constants.iconBackSize,
          ),
          onBack: () => Modular.to.pop(),
          title: l10n(context)!.forgot_title,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: widthConvert(context, 16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            top: heightConvert(context, 16),
                          ),
                          child: Observer(
                            builder: (context) => Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: SvgPicture.asset(IconEnums.lock),
                                ),
                                Expanded(
                                  child: AppInput(
                                    iconRight: IconEnums.eyeOff,
                                    hintText: l10n(context)!
                                        .change_pass_hin_old_password,
                                    validationError:
                                        _controller.validateOldPassword,
                                    errorText: _controller.oldPassMsgResponse,
                                    onChangeValue: _controller.changeOldPass,
                                    obscureText: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Observer(
                          builder: (context) => Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: SvgPicture.asset(IconEnums.lock),
                              ),
                              Expanded(
                                child: AppInput(
                                  iconRight: IconEnums.eyeOff,
                                  hintText: l10n(context)!
                                      .change_pass_hin_new_password,
                                  validationError:
                                      _controller.validateNewPassword,
                                  onChangeValue: _controller.changeNewPass,
                                  obscureText: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Observer(
                          builder: (context) => Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: SvgPicture.asset(IconEnums.lock),
                              ),
                              Expanded(
                                child: AppInput(
                                  iconRight: IconEnums.eyeOff,
                                  hintText: l10n(context)!
                                      .change_pass_hin_confirm_password,
                                  validationError:
                                      _controller.validateConfirmPass,
                                  onChangeValue: _controller.changeConfirmPass,
                                  obscureText: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                        AppButton(
                          title: l10n(context)!.confirm.toString(),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              onSubmit();
                            }
                          },
                          // iconRight: IconEnums.check,
                        ),
                      ],
                    ),
                  ),
                  // BuildRulesSecure(onRule: onRule, onSecure: onSecure),
                ],
              ),
              BuildHotline(
                hotLine: _appController.supportLinePhoneNumber,
              )
            ],
          ),
        ),
      ),
    );
  }
}
