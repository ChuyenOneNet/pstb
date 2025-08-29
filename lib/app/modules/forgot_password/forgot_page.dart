import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/app_store.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateful/stateful_widget.dart';
import 'package:pstb/widgets/stateless/build_rules_secure.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';

import '../../../widgets/stateless/build_hotline.dart';
import 'forgot_store.dart';

class ForgotPage extends StatefulWidget {
  const ForgotPage({Key? key}) : super(key: key);

  @override
  _ForgotPageState createState() => _ForgotPageState();
}

// class _ForgotPageState extends State<ForgotPage> {
//   final ForgotStore _controller = Modular.get<ForgotStore>();
//   final _appController = Modular.get<AppStore>();
//
//   final _formKey = GlobalKey<FormState>();
//   @override
//   void initState() {
//     _controller.changeBuildContext(context);
//     super.initState();
//   }
//
//   void onSubmit() {
//     _controller.postResetPassword();
//   }
//
//   void onRule() {
//     Modular.to.pushNamed(AppRoutes.webView, arguments: 'https://onenet.vn/chinh-sach-bao-mat-thong-tin');
//   }
//
//   void onSecure() {
//     Modular.to.pushNamed(AppRoutes.webView, arguments: 'https://onenet.vn/chinh-sach-bao-mat-thong-tin');
//   }
//
//   @override
//   void dispose(){
//     Modular.dispose<ForgotStore>();
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         FocusScope.of(context).unfocus();
//       },
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         backgroundColor: AppColors.background,
//         appBar: CustomAppBar(
//           icon: Icon(
//             Icons.arrow_back_ios,
//             color: AppColors.grayLight,
//             size: Constants.iconBackSize,
//           ),
//           onBack: () => Modular.to.popUntil(
//             ModalRoute.withName("${AppRoutes.includePhoneNumber}/"),
//           ),
//         ),
//         body: Container(
//           padding: EdgeInsets.symmetric(horizontal: widthConvert(context, 16)),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Column(
//                 children: [
//                   Form(
//                     key: _formKey,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: <Widget>[
//                         Text(
//                           l10n(context)!.forgot_title,
//                           style: Styles.heading2
//                               .copyWith(color: AppColors.primary),
//                         ),
//                         Padding(
//                           padding:
//                               EdgeInsets.only(top: heightConvert(context, 8)),
//                           child: Text(
//                             l10n(context)!.forgot_sub_title,
//                             style: Styles.subtitleLarge
//                                 .copyWith(color: AppColors.neutral700),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(
//                             top: heightConvert(context, 24),
//                           ),
//                           child: Observer(
//                             builder: (context) => AppInput(
//                               iconLeft: IconEnums.lock,
//                               iconRight: IconEnums.eyeOff,
//                               hintText: l10n(context)!.forgot_hint_pass,
//                               validationError: _controller.validatePassword,
//                               onChangeValue: _controller.changeNewPass,
//                               obscureText: true,
//                             ),
//                           ),
//                         ),
//                         Observer(
//                           builder: (context) => AppInput(
//                             iconLeft: IconEnums.lock,
//                             iconRight: IconEnums.eyeOff,
//                             hintText: l10n(context)!.forgot_hint_confirm_pass,
//                             validationError: _controller.validateConfirmPass,
//                             onChangeValue: _controller.changeConfirmPass,
//                             obscureText: true,
//                           ),
//                         ),
//                         AppButton(
//                           title:
//                               l10n(context)!.confirm.toString().toUpperCase(),
//                           onPressed: () {
//                             if (_formKey.currentState!.validate()) {
//                               onSubmit();
//                             }
//                           },
//                           iconRight: IconEnums.check,
//                         ),
//                       ],
//                     ),
//                   ),
//                   // BuildRulesSecure(onRule: onRule, onSecure: onSecure),
//                 ],
//               ),
//               BuildHotline(
//                 hotLine: _appController.supportLinePhoneNumber,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class _ForgotPageState extends State<ForgotPage> {
  final ForgotStore _controller = Modular.get<ForgotStore>();
  final _appController = Modular.get<AppStore>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller.changeBuildContext(context);
  }

  void onSubmit() {
    _controller.postResetPassword();
  }

  @override
  void dispose() {
    Modular.dispose<ForgotStore>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: CustomAppBar(
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.grayLight,
            size: Constants.iconBackSize,
          ),
          onBack: () => Modular.to.pop(),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: widthConvert(context, 16)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      l10n(context)!.forgot_title,
                      style: Styles.heading2.copyWith(color: AppColors.primary),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: heightConvert(context, 8)),
                      child: Text(
                        l10n(context)!.forgot_sub_title,
                        style: Styles.subtitleLarge
                            .copyWith(color: AppColors.neutral700),
                      ),
                    ),
                    SizedBox(height: heightConvert(context, 24)),
                    Observer(
                      builder: (_) => AppInput(
                        hintText: l10n(context)!.login_phone,
                        keyboardType: TextInputType.phone,
                        iconLeft: IconEnums.phone,
                        validationError: _controller.validatePhoneNumber,
                        onChangeValue: _controller.changePhoneNumber,
                      ),
                    ),
                    SizedBox(height: heightConvert(context, 12)),
                    Observer(
                      builder: (_) => AppInput(
                        hintText: "Nhập mật khẩu mới",
                        iconLeft: IconEnums.lock,
                        iconRight: IconEnums.eyeOff,
                        obscureText: true,
                        validationError: _controller.validatePassword,
                        onChangeValue: _controller.changeNewPass,
                      ),
                    ),
                    SizedBox(height: heightConvert(context, 12)),
                    Observer(
                      builder: (_) => AppInput(
                        hintText: l10n(context)!.forgot_hint_confirm_pass,
                        iconLeft: IconEnums.lock,
                        iconRight: IconEnums.eyeOff,
                        obscureText: true,
                        validationError: _controller.validateConfirmPass,
                        onChangeValue: _controller.changeConfirmPass,
                      ),
                    ),
                    SizedBox(height: heightConvert(context, 24)),
                    AppButton(
                      title: l10n(context)!.confirm.toString().toUpperCase(),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          onSubmit();
                        }
                      },
                      iconRight: IconEnums.check,
                    ),
                  ],
                ),
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
