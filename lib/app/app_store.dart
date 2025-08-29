import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pstb/app/modules/bottom_nav/bottom_nav_store.dart';
import 'package:pstb/app_initlization.dart';
import 'package:pstb/infrastructure/fire_base_message.dart';
import 'package:pstb/services/api_base_helper.dart';
import 'package:pstb/utils/helpers/config_helper.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/utils/sessions/local_setting_pref.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_exception.dart';
import '../utils/device_util.dart';
import '../utils/sessions/session_prefs.dart';
import 'models/lading_unit_model.dart';

part 'app_store.g.dart';

const defaultLanguage = Locale("vi", "");

class AppStore = AppStoreBase with _$AppStore;

enum Language { vie, eng }

abstract class AppStoreBase with Store {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final _bottomNavStore = Modular.get<BottomNavStore>();
  final _apiBaseHelper = Modular.get<ApiBaseHelper>();
  final _box = GetStorage();

  /// flag for widget reload.
  @observable
  bool reload = false;

  @observable
  bool rateApp = false;

  @observable
  String fireBaseToken = "";
  @observable
  String uriAboutPage = "";
  @observable
  String fanPage = "";
  @observable
  String enablePromotion = '';
  @observable
  bool enableSignUpOTP = false;
  @observable
  bool enableForgotOTP = false;

  //Booking time
  @observable
  String timeStart = "";
  @observable
  String timeEnd = "";

  @observable
  LandingUnitModel landingUnitModel = LandingUnitModel();

  @action
  void setReload(bool newReload) {
    reload = newReload;
  }

  @observable
  String supportLinePhoneNumber = '';
  @observable
  String supportMess = '';
  @observable
  double progress = 0.0;

  Future<void> init() async {
    await initApp();
    await _loadConfigsFromServer();
    await loadBiometricSetting();
    await _initApiHelper();
    final box = GetStorage();
    final isNotification = box.read(Constants.isNotification);
    if (isNotification != null && isNotification) {
      await enableFireBaseMessage();
    } else {
      await disableFireBaseMessage();
    }
  }

  @computed
  String get fcmToken => fireBaseToken;

  @observable
  bool loadingQR = true;

  @observable
  String qrcodeData = "";

  @observable
  Locale language = const Locale("vi", "");

  @action
  Future<void> onSelectLanguage(Locale value) async {
    language = value;
    final SharedPreferences prefs = await _prefs;
    prefs.setString(Constants.language, value.toString());
  }

  @action
  Future<void> getLanguage() async {
    try {
      SharedPreferences prefs = await _prefs;
      String? currentLanguage = prefs.getString(Constants.language);
      if (isNotEmptyNullString(currentLanguage.toString())) {
        language = Locale(currentLanguage!, "");
      } else {
        language = const Locale("vi", "");
      }
    } catch (e) {
      language = defaultLanguage;
    }
  }

  @observable
  bool turnOnTouchID = false;

  @action
  Future<void> loadBiometricSetting() async {
    turnOnTouchID = await LocalSettingsPref.isEnableBiometric();
  }

  Future<dynamic> setFCMToken(String? token) async {
    print("_setFCMToken FCM:${token}");
    var json = jsonEncode({
      'fireBaseToken': token,
      'deviceId': await DeviceUtil.getId(),
    });
    try {
      return await _apiBaseHelper.put(
        ApiUrl.updateTokenFirebase,
        json,
      );
    } on AppException catch (e) {
      print(e);
    }
  }

  @observable
  RemoteMessage? remoteMessage;

  @action
  void setRemoteMessage(RemoteMessage data) {
    remoteMessage = data;
  }

  @observable
  bool nextNotificationDetails = false;

  @observable
  bool gotoEHR = false;

  @action
  void setNextNotificationDetails(bool val) => nextNotificationDetails = val;

  @action
  void setGotoEHR(bool val) => gotoEHR = val;

  @computed
  bool get getGotoEHR => gotoEHR;

  Future<void> _initApiHelper() async {
    final String? userData = await SessionPrefs.getProfileData();
    ApiBaseHelper.setHeader(userData);
  }

  Future<void> disableFireBaseMessage() async {
    //TODO check lại FCM token
    // await setFCMToken(null);
    var fireBaseSrv = FireBaseMessageSrv();
    fireBaseSrv.disable();
    await _box.write(Constants.enableNotification, true);
  }

  final fireBaseSrv = FireBaseMessageSrv();

  Future<void> enableFireBaseMessage() async {
    print('enable firebase message');
    var fireBaseLsr = FireBaseMessageListener(onMessage: (message) {
      setNextNotificationDetails(message.data['Type'] == "TEST_RESULT");
      setGotoEHR(message.data['Type'] == "COMPLETE_EXAMINATION");
      setRemoteMessage(message);
    }, onMessageInit: (message) {
      setNextNotificationDetails(message.data['Type'] == "TEST_RESULT");
      setGotoEHR(message.data['Type'] == "COMPLETE_EXAMINATION");
      setRemoteMessage(message);
      _gotoNotificationPage(gotoEHRPage: message.data['Type'] == "TEST_RESULT");
    }, onMessageOpenedApp: (message) {
      setNextNotificationDetails(message.data['Type'] == "TEST_RESULT");
      setGotoEHR(message.data['Type'] == "COMPLETE_EXAMINATION");
      setRemoteMessage(message);
      _gotoNotificationPage(gotoEHRPage: message.data['Type'] == "TEST_RESULT");
    });

    await fireBaseSrv.enableFireBaseMessage((payload) async {
      _gotoNotificationPage(gotoEHRPage: getGotoEHR);
    }, (token) async => {await setFCMToken(token)}, fireBaseLsr);
    await _box.write(Constants.enableNotification, true);
  }

  void _gotoNotificationPage({required bool gotoEHRPage}) {
    if (gotoEHRPage) {
      setGotoEHR(false);
      Modular.to.pushNamed(AppRoutes.ehrModule);
    } else {
      if (_bottomNavStore.currentIndex == 3) {
        setReload(!reload);
      }
      _bottomNavStore.currentIndex = 3;
      Modular.to.pushNamed(AppRoutes.main);
    }
  }

  String convertPhone(String phone) {
    if (phone[0] == '+') {
      return '0' + phone.substring(3);
    } else {
      return phone;
    }
  }

  Future<void> _loadConfigsFromServer() async {
    var cfgHelper = ConfigHelper.instance;
    await cfgHelper.loadData(9);

    /// system-config
    supportLinePhoneNumber =
        await cfgHelper.tryGetConfigValueByCode(ConfigHelper.supportLine, '');
    supportMess =
        await cfgHelper.tryGetConfigValueByCode(ConfigHelper.supportMess, '');
    // uriAboutPage =
    //     await cfgHelper.tryGetConfigValueByCode(ConfigHelper.about, '');
    // fanPage = await cfgHelper.tryGetConfigValueByCode(ConfigHelper.fanPage, '');
    // timeStart = await ConfigHelper.instance
    //     .tryGetConfigValueByCode(ConfigHelper.timeStartBooking, "09:00");
    // timeEnd = await ConfigHelper.instance
    //     .tryGetConfigValueByCode(ConfigHelper.timeEndBooking, "17:30");
    // enablePromotion = await ConfigHelper.instance
    //     .tryGetConfigValueByCode(ConfigHelper.enablePromotion, "0");
    enableSignUpOTP = await enableOtpByCode(ConfigHelper.otpSignUp);
    enableForgotOTP = await enableOtpByCode(ConfigHelper.otpForgot);
  }

  Future<bool> enableOtpByCode(String code) async {
    final enable = await ConfigHelper.instance.getConfigByCode(code);
    if (enable != null) {
      return enable.value == '1';
    }
    return false;
  }

  @action
  Future<void> getLandingUnit(int id) async {
    try {
      var response = await _apiBaseHelper.get(
        '${ApiUrl.detailMedicalUnit}$id/landing',
      );
      print("hêhhehee");
      print(response);
      landingUnitModel = LandingUnitModel.fromJson(response);
      if (landingUnitModel.image != null &&
          landingUnitModel.image!.endsWith('vduh.jpg')) {
        landingUnitModel.image =
            landingUnitModel.image!.replaceAll('vduh.jpg', 'vduh.png');
      }
    } catch (e) {
      print(e);
    }
  }
}

AppStore _singleton = AppStore();

AppStore get singletonAppStore => _singleton;
