import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pstb/app/app_store.dart';
import 'package:pstb/app/modules/bottom_nav/bottom_nav_store.dart';
import 'package:pstb/app/modules/home/home_store.dart';
import 'package:pstb/app/modules/profile/pages/setting/setting_store.dart';
import 'package:pstb/app/modules/profile/pages/setting/widget/field_icon_widget.dart';
import 'package:pstb/app/modules/profile/pages/setting/widget/field_notification_widget.dart';
import 'package:pstb/app/modules/profile/pages/setting/widget/finger_print_widget.dart';
import 'package:pstb/app/user_app_store.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';
import 'package:pstb/utils/sessions/local_setting_pref.dart';
import 'package:pstb/app/modules/community/community_page_store.dart';

class LifecycleEventHandler extends WidgetsBindingObserver {
  final AsyncCallback? resumeCallBack;
  final AsyncCallback? suspendingCallBack;

  LifecycleEventHandler({
    required this.resumeCallBack,
    this.suspendingCallBack,
  });

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        if (resumeCallBack != null) {
          await resumeCallBack!();
        }
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        if (suspendingCallBack != null) {
          await suspendingCallBack!();
        }
        break;
      case AppLifecycleState.hidden: // Add this case
        // Handle hidden state if needed
        break;
    }
  }
}

class ProfileSetting extends StatefulWidget {
  const ProfileSetting({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProfileSettingState();
  }
}

class _ProfileSettingState extends State<ProfileSetting> {
  final AppStore _store = Modular.get<AppStore>();
  final BottomNavStore _bottomNavStore = Modular.get<BottomNavStore>();
  final UserAppStore _userAppStore = Modular.get<UserAppStore>();
  final _homeStore = Modular.get<HomeStore>();
  final _settingStore = Modular.get<SettingStore>();
  bool isSuccess = true;
  bool turnOnTouchID = false;
  bool isAlertNotification = false;
  Locale language = const Locale("vi", "");

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addObserver(LifecycleEventHandler(resumeCallBack: () async {
      await _settingStore.changeStateSetting();
    }));
    _userAppStore.changeBuildContext(context);
    setState(() {
      turnOnTouchID = _store.turnOnTouchID;
      language = _store.language;
    });
  }

  void onSave() {
    try {
      _store.onSelectLanguage(language);
      LocalSettingsPref.setBiometric(turnOnTouchID);
      AppSnackBar.show(
          context, AppSnackBarType.Success, l10n(context)!.update_success!);
      Modular.to.pop();
    } catch (e) {
      AppSnackBar.show(
          context, AppSnackBarType.Error, l10n(context)!.sign_up_wrong!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: l10n(context)!.profile_home_setting,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FieldIconWidget(
              svgIcon: IconEnums.unlock,
              onTap: () {
                Modular.to.pushNamed(AppRoutes.changePassword);
              },
              title: l10n(context).profile_setting_change_pass,
            ),
            const Divider(
              thickness: 1,
            ),
            // FieldIconWidget(
            //   svgIcon: IconEnums.changeMedicalUnit,
            //   onTap: () {
            //     Modular.to.pushNamedAndRemoveUntil(AppRoutes.selectionHospitalModule, (_) => false);
            //   },
            //   title: 'Đổi cơ sở y tế',
            // ),
            // const Divider(
            //   thickness: 1,
            // ),
            FingerPrintWidget(),
            const Divider(
              thickness: 1,
            ),
            FieldNotificationWidget(),
            const Divider(
              thickness: 1,
            ),
            FieldIconWidget(
              svgIcon: IconEnums.logOut,
              onTap: () async {
                await _userAppStore.logOut();
                Modular.get<CommunityPageStore>().isLogin = false;
                _homeStore.isLogin = false;
                _bottomNavStore.updateCurrentIndex(1);
                Modular.to.popUntil((_) => false);
                Modular.to.popAndPushNamed(AppRoutes.login);
              },
              title: l10n(context).profile_setting_log_out,
            ),
            // Spacer(
            //   flex: 1,
            // ),
            // Row(
            //   children: [
            //     Spacer(),
            //     Flexible(child: _buildDeleteAccountBtn()),
            //     Spacer(),
            //   ],
            // ),
            // Spacer(
            //   flex: 2,
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeleteAccountBtn() {
    return AppButton(
        title: 'Xoá tài khoản ',
        primaryColor: Colors.red,
        onPressed: () async {
          showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return DialogConfirm(
                  title: 'Xác nhận xoá tài khoản',
                  subTitle: 'Bạn có chắc chắn muốn xoá tài khoản?',
                  buttonRight: 'Hủy bỏ',
                  buttonLeft: 'Đồng ý',
                  onButtonLeft: () async {
                    await _userAppStore.deleteAccount();

                    Modular.to.pop();
                    // Fluttertoast.showToast(
                    //     msg: 'Xoá tài khoản thành công',
                    //     gravity: ToastGravity.BOTTOM,
                    //     backgroundColor: AppColors.success);
                    _homeStore.isLogin = false;
                    Modular.get<CommunityPageStore>().isLogin = false;
                    _bottomNavStore.updateCurrentIndex(1);
                    Modular.to.popUntil((_) => false);
                    Modular.to.popAndPushNamed(AppRoutes.login);
                  },
                  onButtonRight: () {
                    Modular.to.pop();
                  },
                );
              });
        });
  }
}
