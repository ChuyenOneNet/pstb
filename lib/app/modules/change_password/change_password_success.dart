import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/app_store.dart';
import 'package:pstb/app/modules/bottom_nav/bottom_nav_store.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';

import 'change_password_store.dart';

class ChangePasswordPageSuccess extends StatefulWidget {
  const ChangePasswordPageSuccess({Key? key}) : super(key: key);

  @override
  _ChangePasswordPageSuccessState createState() =>
      _ChangePasswordPageSuccessState();
}

class _ChangePasswordPageSuccessState
    extends ModularState<ChangePasswordPageSuccess, ChangePasswordStore> {
  final AppStore _appStore = Modular.get<AppStore>();
  final BottomNavStore _bottomNavStore = Modular.get<BottomNavStore>();
  @override
  void initState() {
    super.initState();
  }

  void onClickHome() {
    _appStore.setReload(!_appStore.reload);
    _bottomNavStore.updateCurrentIndex(0);
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
                      l10n(context).forgotSuccess_title,
                      style: Styles.heading2.copyWith(color: AppColors.primary),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        l10n(context).change_pass_success_sub_title,
                        style: Styles.bodyRegular
                            .copyWith(color: AppColors.neutral700),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ]),
                  Column(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: AppButtonOutline(
                        text: l10n(context)!.forgotSuccess_btn_back_home,
                        onClick: onClickHome,
                        color: AppColors.primary500,
                        labelStyle: Styles.paragraph.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary500),
                      ),
                    ),
                    AppButtonOutline(
                      text: l10n(context).hotline.toString().toUpperCase(),
                      phoneNumber: Constants.contactPhone,
                    )
                  ]),
                ],
              ))),
    );
  }
}
