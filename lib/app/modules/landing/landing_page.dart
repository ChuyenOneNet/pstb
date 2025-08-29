import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pstb/app/modules/landing/landing_module.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pstb/app/app_store.dart';
import 'package:pstb/utils/sessions/session_prefs.dart';
import 'package:pstb/services/api_base_helper.dart';
import 'package:pstb/utils/main.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends ModularState<LandingPage, Object> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final AppStore _appStore = Modular.get<AppStore>();
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> showOnBoardIfFirstTime() async {
    final String? userData = await SessionPrefs.getProfileData();
    ApiBaseHelper.setHeader(userData);
    final SharedPreferences prefs = await _prefs;
    int firstTimeLoadApp = prefs.getInt(Constants.firstTimeLoadApp) ?? 2;
    int medicalUnitId = await SessionPrefs.getMedicalUnitId() ?? 2;
    String nextPage = AppRoutes.main;
    // if (medicalUnitId == 0) {
    //   if (firstTimeLoadApp == 0) {
    //     nextPage = AppRoutes.onBoard;
    //   } else {
    //     nextPage = AppRoutes.selectionHospitalModule;
    //   }
    // } else {
    await _appStore.getLandingUnit(9);
    nextPage = AppRoutes.landingUnit;
    // }
    // nextPage = AppRoutes.onBoard;
    Timer(const Duration(milliseconds: 1000),
        () => Modular.to.navigate(nextPage));

    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    // await messaging.subscribeToTopic("all");
    //TODO update firebase token
    // final fcmToken = await FirebaseMessaging.instance.getToken();
    //TODO Unauthor token fix sau
    // await _appStore.setFCMToken(fcmToken ?? "");
    // print("fcmToken =======> $fcmToken");
    //
    // messaging.onTokenRefresh.listen((fcmToken) {
    //   // TODO: If necessary send token to application server.
    //   _appStore.setFCMToken(fcmToken);
    // }).onError((err) {
    //   // Error getting token.
    //   debugPrint(err.toString());
    // });
    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: false,
      sound: true,
    );
  }

  @override
  void initState() {
    super.initState();
    _appStore.init().then((value) async => {await showOnBoardIfFirstTime()});
  }

  @override
  void dispose() {
    Modular.dispose<LandingModule>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: SvgPicture.asset(
              CanvasEnum.canvasBottom,
              width: MediaQuery.of(context).size.width,
              color: AppColors.primary,
              fit: BoxFit.fitWidth,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                const Spacer(),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          backgroundImage: AssetImage(ImageEnum.logopstbColor),
                          maxRadius: 64,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          '',
                          style: Styles.titleApp,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Ứng dụng kết nối cộng đồng y tế',
                          style: Styles.titleItem
                              .copyWith(color: AppColors.primary),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: heightConvert(context, 46),
                      ),
                      child: Text(
                        l10n(context).landing_company,
                        style: Styles.content.copyWith(
                          color: AppColors.background,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
