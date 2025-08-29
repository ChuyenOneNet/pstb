import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pstb/app/modules/auth_guard/auth_guard_page.dart';
import 'package:pstb/app/modules/home/home_store.dart';
import 'package:pstb/app/modules/profile/widget/profile_menu.dart';
import 'package:pstb/app/modules/profile/profile_store.dart';
import 'package:pstb/app/modules/profile/widget/header_personal.dart';
import 'package:pstb/app/modules/profile/widget/version_widget.dart';
import 'package:pstb/app/route_guard.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/utils/sessions/session_prefs.dart';
import 'package:pstb/utils/sign_util.dart';
import 'package:pstb/widgets/stateless/app_button.dart';
import 'package:pstb/widgets/stateless/app_dialog_confirm.dart';
import 'package:pstb/widgets/stateless/content_easy_loading_widget.dart';
import '../../../widgets/stateful/custom_dialog.dart';
import '../../user_app_store.dart';
import 'pages/profile_page/widgets/login_his_widget.dart';
import 'package:flutter/foundation.dart';

class ProfileHomePage extends StatefulWidget {
  const ProfileHomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProfileHomePageState();
  }
}

class _ProfileHomePageState
    extends ModularState<ProfileHomePage, ProfileStore> {
  final UserGuard _userGuard = UserGuard();
  final UserAppStore _userAppStore = Modular.get<UserAppStore>();
  final HomeStore homeStore = Modular.get<HomeStore>();

  Future<void> checkLogin() async {
    UserStatus isLogin = await _userGuard.canActivate();
    controller.setIsLogin(isLogin);
  }

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      await checkLogin();
      if (controller.isLogin == UserStatus.Signed) {
        _userAppStore.getAccountDetail();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        if (controller.isLogin == UserStatus.Checking) {
          return const SizedBox();
        }
        if (controller.isLogin == UserStatus.NoData) {
          return AuthGuardPage();
        }
        return WillPopScope(
          onWillPop: () {
            if (Platform.isAndroid) {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            }
            return Future.value(false);
          },
          child: Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const HeaderPersonalWidget(),
                      const ProfileMenu(),
                      Row(
                        children: [
                          const Spacer(),
                          Expanded(
                            flex: 3,
                            child: AppButton(
                                title: _userAppStore.isCodeNursing
                                    ? 'Đăng xuất tài khoản HIS'
                                    : 'Liên kết với tài khoản HIS',
                                onPressed: () async {
                                  if (!_userAppStore.isCodeNursing) {
                                    // showDialog(
                                    //     context: context,
                                    //     builder: (_) {
                                    //       return const LoginHisWidget();
                                    //     });
                                    showDialog<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(24),
                                          ),
                                          elevation: 0.0,
                                          backgroundColor: Colors.transparent,
                                          child: Container(
                                            padding: const EdgeInsets.all(16.0),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.rectangle,
                                              borderRadius:
                                                  BorderRadius.circular(24),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Colors.black26,
                                                  blurRadius: 10.0,
                                                  offset: Offset(0.0, 10.0),
                                                ),
                                              ],
                                            ),
                                            child: const LoginHisWidget(),
                                          ),
                                        );
                                      },
                                    );
                                  } else {
                                    showDialog<void>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return DialogConfirm(
                                            title: 'Đăng xuất tài khoản HIS',
                                            subTitle:
                                                'Bạn có chắc chắn muốn đăng xuất?',
                                            buttonRight: 'Hủy bỏ',
                                            buttonLeft: 'Đồng ý',
                                            onButtonLeft: () async {
                                              await _userAppStore
                                                  .disconnectHIS();
                                              homeStore.isStaff = false;
                                              await SessionPrefs.isStaff(false);
                                              Modular.to.pop();
                                              Fluttertoast.showToast(
                                                  msg: 'Đăng xuất thành công',
                                                  gravity: ToastGravity.BOTTOM,
                                                  backgroundColor:
                                                      AppColors.success);
                                            },
                                            onButtonRight: () {
                                              Modular.to.pop();
                                            },
                                          );
                                        });
                                  }
                                }),
                          ),
                          const Spacer(),
                        ],
                      ),
                      const VersionWidget(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
