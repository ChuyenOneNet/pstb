import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pstb/app/modules/bottom_nav/bottom_nav_store.dart';
import 'package:pstb/app/user_app_store.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';

class SignupSuccess extends StatefulWidget {
  const SignupSuccess({Key? key}) : super(key: key);

  @override
  _SignupSuccessState createState() => _SignupSuccessState();
}

class _SignupSuccessState extends State<SignupSuccess> {
  final UserAppStore _userAppStore = Modular.get<UserAppStore>();

  @override
  void initState() {
    super.initState();
  }

  void onClickHome() {
    Modular.get<BottomNavStore>().updateCurrentIndex(4);
    _userAppStore.setReload(!_userAppStore.reload);
    Modular.to.popUntil(ModalRoute.withName("${AppRoutes.main}/"));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg_success.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: heightConvert(context, 72),
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: widthConvert(context, 16)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Image.asset(
                      //   ImageEnum.nSignup_success,
                      //   width: widthConvert(context, 200),
                      //   height: heightConvert(context, 200),
                      //   fit: BoxFit.contain,
                      // ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: heightConvert(context, 60)),
                        child: Text(
                          l10n(context)!.signup_success_title,
                          style: Styles.heading2
                              .copyWith(color: AppColors.primary),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: heightConvert(context, 8)),
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            Text(
                              l10n(context)!.signup_success_sub_title,
                              style: Styles.bodyRegular
                                  .copyWith(color: AppColors.neutral700),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: onClickHome,
                        child: Stack(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(194, 198, 201, 0.3),
                                      offset: Offset(2, 3),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(4),
                                      bottomRight: Radius.circular(4))),
                              padding: const EdgeInsets.only(
                                  left: 16, top: 4, bottom: 2),
                              margin: const EdgeInsets.only(top: 10, left: 44),
                              child: Text(
                                'QUAY LẠI TRANG CHỦ ',
                                style: Styles.bodyBold
                                    .copyWith(color: AppColors.primary),
                              ),
                            ),
                            Container(
                              height: 50,
                              width: 50,
                              decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(194, 198, 201, 0.3),
                                      offset: Offset(0, 5),
                                    ),
                                  ],
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25))),
                              child: Container(
                                height: 40,
                                width: 40,
                                margin: const EdgeInsets.all(6),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: AppColors.primary),
                                child: SvgPicture.asset(
                                  IconEnums.yellowArrow,
                                  color: AppColors.background,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              // BuildBtn(onClickHome: onClickHome),
            ],
          ),
        ),
      ),
    );
  }
}

class BuildBtn extends StatelessWidget {
  final Function() onClickHome;

  const BuildBtn({
    Key? key,
    required this.onClickHome,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightConvert(context, 812),
      width: widthConvert(context, 375),
      padding: EdgeInsets.symmetric(horizontal: widthConvert(context, 16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // SizedBox(),
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: heightConvert(context, 16)),
                child: AppButtonOutline(
                  text: l10n(context)!.forgotSuccess_btn_back_home,
                  onClick: onClickHome,
                  color: AppColors.primary500,
                  labelStyle:
                      Styles.bodyBold.copyWith(color: AppColors.primary500),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: heightConvert(context, 44)),
                child: AppButtonOutline(
                  text: l10n(context)!.hotline.toString().toUpperCase(),
                  phoneNumber: Constants.contactPhone,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
