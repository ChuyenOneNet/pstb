import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/bottom_nav/bottom_nav_store.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/button_back.dart';

import '../shared/widgets/btns.dart';

class AuthGuardPage extends StatefulWidget {
  final Map<String, dynamic>? data;
  final bool canPop;
  final String? title;

  AuthGuardPage({Key? key, this.data, this.canPop = false, this.title})
      : super(key: key) {}

  @override
  _AuthGuardPageState createState() => _AuthGuardPageState();
}

class _AuthGuardPageState extends State<AuthGuardPage> {
  final BottomNavStore _bottomNav = Modular.get<BottomNavStore>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.canPop) {
          return Future.value(true);
        } else {
          if (Platform.isAndroid) {
            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          }
          return Future.value(false);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        // appBar: widget.canPop
        //     ? CustomAppBar(
        //         title: widget.title,
        //       )
        //     : null,
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    bottom: widthConvert(context, 33),
                    left: widthConvert(context, 40),
                    right: widthConvert(context, 40),
                  ),
                  child: Image.asset(
                    ImageEnum.loginToUse,
                    height: widthConvert(context, 180),
                    fit: BoxFit.contain,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    bottom: widthConvert(context, 12),
                    left: widthConvert(context, 20),
                    right: widthConvert(context, 20),
                  ),
                  // alignment: Alignment.centerLeft,
                  child: Text(
                    'Bạn hãy đăng nhập để sử dụng chức năng này',
                    textAlign: TextAlign.center,
                    style: Styles.titleItem,
                  ),
                ),
                // Container(
                //   // alignment: Alignment.centerLeft,
                //   padding: EdgeInsets.only(
                //     bottom: widthConvert(context, 16),
                //     left: widthConvert(context, 40),
                //     right: widthConvert(context, 40),
                //   ),
                //   child: Text(
                //     l10n(context)!.auth_page_signin_to_use_des!,
                //     textAlign: TextAlign.center,
                //     style: Styles.content,
                //   ),
                // ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(
                    bottom: widthConvert(context, 16),
                    left: widthConvert(context, 34),
                    right: widthConvert(context, 34),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(
                            right: widthConvert(context, 8),
                          ),
                          // child: AppButton(
                          //   isLeftGradient: true,
                          //   height: 45,
                          //   onPressed: () {
                          //     if (widget.data != null &&
                          //         widget.data!['isNotFromBottomNav'] == true) {
                          //       Modular.to.popAndPushNamed(AppRoutes.login);
                          //     } else {
                          //       Modular.to
                          //           .pushNamed(AppRoutes.login)
                          //           .then((value) => {
                          //                 // _bottomNavStore.updateCurrentIndex(4),
                          //                 Modular.to.popAndPushNamed(AppRoutes.main)
                          //               });
                          //     }
                          //   },
                          //   title: l10n(context)!.auth_page_signin!,
                          //   labelStyle: Styles.titleButton,
                          // ),
                          child: LogInBtn(logInBtnOnPressed: () {
                            if (widget.data != null &&
                                widget.data!['isNotFromBottomNav'] == true) {
                              Modular.to.popAndPushNamed(AppRoutes.login);
                            } else {
                              Modular.to.popAndPushNamed(AppRoutes.login).then(
                                    (value) => {
                                      _bottomNav.updateCurrentIndex(4),
                                      Modular.to
                                          .popAndPushNamed(AppRoutes.main),
                                    },
                                  );
                            }
                          }),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(
                            right: widthConvert(context, 8),
                          ),
                          child: SignInBtn(signInBtnOnPressed: () {
                            if (widget.data != null &&
                                widget.data!['isNotFromBottomNav'] == true) {
                              Modular.to.popAndPushNamed(AppRoutes.signup);
                            } else {
                              Modular.to.pushNamed(AppRoutes.signup);
                            }
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            widget.canPop
                ? const Padding(
                    padding: EdgeInsets.only(top: 48.0),
                    child: ButtonBackWidget(),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
