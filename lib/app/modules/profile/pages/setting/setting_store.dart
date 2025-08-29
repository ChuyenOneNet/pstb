import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_storage/get_storage.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pstb/app/app_store.dart';
import 'package:pstb/app/models/login_model.dart';
import 'package:pstb/app/modules/home/home_store.dart';
import 'package:pstb/services/api_base_helper.dart';
import 'package:pstb/utils/helpers/local_auth_helper.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/utils/sessions/local_secure.dart';
import 'package:pstb/utils/sessions/session_prefs.dart';
import 'package:mobx/mobx.dart';
import 'package:local_auth/error_codes.dart';
import 'package:notification_permissions/notification_permissions.dart';

part 'setting_store.g.dart';

class SettingStore = _SettingStoreBase with _$SettingStore;

abstract class _SettingStoreBase with Store {
  final _homeStore = Modular.get<HomeStore>();
  final _apiBaseHelper = Modular.get<ApiBaseHelper>();
  final _localAuthHelper = LocalAuthHelper(auth: LocalAuthentication());
  final _secure = FlutterSecure();
  final _box = GetStorage();
  final _appStore = Modular.get<AppStore>();

  String _getKey = '';
  @observable
  String password = '';
  @observable
  bool isActiveFinger = false;
  @observable
  bool isLoginSuccess = false;
  @observable
  bool notAvailableBiometric = false;
  @observable
  bool isNotification = false;
  @observable
  bool isShowAlertNotification = false;
  @observable
  PermissionStatus permissions = PermissionStatus.denied;

  @action
  Future<void> initState() async {
    print('init');
    isNotification = _box.read(Constants.isNotification) ?? false;
    isActiveFinger = await SessionPrefs.getActiveFinger();
    print('$isActiveFinger');
    await requestNotification();
  }

  @action
  void setPassword(String value) {
    password = value;
  }

  @action
  Future<void> actionSwitch(value) async {
    if (!value) {
      isActiveFinger = false;
      await SessionPrefs.setActiveFinger(isActiveFinger);
    }
  }

  @action
  Future<void> activeFingerPrint() async {
    await _homeStore.getPhoneNumberCache();
    _getKey = _homeStore.phoneNumberCache;
    final value = await _secure.readKeyStorage(
      key: _getKey,
    );
    if (value != null) {
      isActiveFinger = value.isNotEmpty;
    }
    try {
      final response = await _apiBaseHelper.post(
        ApiUrl.token,
        LoginModel(
          username: _getKey,
          password: password,
        ).toRawJson(),
      );
      isActiveFinger = response != null;
      await _secure.writeKeyStorage(
        key: _getKey,
        value: password,
      );
      final value = await _secure.readKeyStorage(
        key: _getKey,
      );
      isActiveFinger = value!.isNotEmpty;
    } catch (e) {
      isActiveFinger = false;
      await SessionPrefs.setActiveFinger(isActiveFinger);
    }
  }

  @action
  Future<void> activeNotification() async {
    print('active notification');
    isNotification = !isNotification;
    if (isNotification) {
      await _appStore.enableFireBaseMessage();
    } else {
      await _appStore.disableFireBaseMessage();
    }

    if (!isNotification ||
        permissions == PermissionStatus.granted ||
        permissions == PermissionStatus.unknown) {
      isShowAlertNotification = false;
      return;
    }
    if (permissions == PermissionStatus.denied) {
      isShowAlertNotification = true;
      return;
    }
  }

  @action
  Future<void> changeStateSetting() async {
    await requestNotification();
    isShowAlertNotification =
        isNotification && permissions == PermissionStatus.denied;
  }

  @action
  Future<void> requestNotification() async {
    permissions = await NotificationPermissions.requestNotificationPermissions(
        openSettings: false);
  }

  @action
  Future<void> authenticateWithBiometrics(String message,
      {AndroidAuthMessages androidAuthMessages =
          const AndroidAuthMessages()}) async {
    try {
      if (notAvailableBiometric) {
        return;
      }
      if (isActiveFinger) {
        final result = await _localAuthHelper.authenticateWithBiometrics(
            message,
            androidAuthMessages: androidAuthMessages);
        if (result) {
          _secure.deleteKeyStorage(
            key: _homeStore.phoneNumberCache,
          );
          isActiveFinger = false;
          await SessionPrefs.setActiveFinger(isActiveFinger);
        }
        return;
      }
    } on PlatformException catch (e) {
      if (e.code == notAvailable) {
        notAvailableBiometric = true;
        return;
      }
      notAvailableBiometric = false;
    }
  }
}
