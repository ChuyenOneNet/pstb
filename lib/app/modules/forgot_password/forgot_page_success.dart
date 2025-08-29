import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/app_store.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';

import 'forgot_store.dart';

class ForgotPageSuccess extends StatefulWidget {
  const ForgotPageSuccess({Key? key}) : super(key: key);

  @override
  _ForgotPageSuccessState createState() => _ForgotPageSuccessState();
}

class _ForgotPageSuccessState
    extends ModularState<ForgotPageSuccess, ForgotStore> {
  final AppStore _appStore = Modular.get<AppStore>();
  @override
  void initState() {
    super.initState();
  }

  void onClickHome() {
    _appStore.setReload(!_appStore.reload);
    Modular.to.popUntil(
      ModalRoute.withName("${AppRoutes.main}/"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
          backgroundColor: AppColors.background,
          appBar: CustomAppBar(),
          body: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: widthConvert(context, 16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(children: <Widget>[
                    Text(
                      l10n(context)!.forgotSuccess_title,
                      style:
                          Styles.heading2.copyWith(color: AppColors.primary),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: heightConvert(context, 8)),
                      child: Text(
                        l10n(context)!.forgotSuccess_sub_title,
                        style: Styles.bodyRegular
                            .copyWith(color: AppColors.neutral700),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ]),
                  Column(children: <Widget>[
                    Padding(
                      padding:
                          EdgeInsets.only(bottom: heightConvert(context, 16)),
                      child: AppButtonOutline(
                        text: l10n(context)!.forgotSuccess_btn_back_home,
                        onClick: onClickHome,
                        color: AppColors.primary500,
                        labelStyle: Styles.paragraph.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary500),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(bottom: heightConvert(context, 44)),
                      child: AppButtonOutline(
                        text: l10n(context)!.hotline.toString().toUpperCase(),
                        phoneNumber: Constants.contactPhone,
                      ),
                    )
                  ]),
                ],
              ))),
    );
  }
}
