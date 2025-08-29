import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_it/get_it.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pstb/app/app_store.dart';
import 'package:pstb/app/models/login_model.dart';
import 'package:pstb/app/modules/bottom_nav/bottom_nav_store.dart';
import 'package:pstb/app/modules/community/community_page_store.dart';
import 'package:pstb/app/modules/home/home_store.dart';
import 'package:pstb/app/modules/login/models/login_social.dart';
import 'package:pstb/app/modules/profile/pages/setting/setting_store.dart';
import 'package:pstb/app/user_app_store.dart';
import 'package:pstb/app/models/token_model.dart';
import 'package:pstb/services/api_base_helper.dart';
import 'package:pstb/services/api_exception.dart';
import 'package:pstb/utils/helpers/local_auth_helper.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/utils/sessions/local_secure.dart';
import 'package:pstb/utils/sessions/session_prefs.dart';
import 'package:pstb/utils/shared_preferences_manager.dart';
import 'package:pstb/widgets/stateless/app_snack_bar.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';
import 'package:mobx/mobx.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../../constant/config.dart';
import '../../../utils/utils.dart';
import '../../models/login_model.dart';
import '../../models/token_model_v2.dart';

part 'login_store.g.dart';

class LoginStore = LoginStoreBase with _$LoginStore;

abstract class LoginStoreBase with Store {
  final ApiBaseHelper _apiBaseHelper = ApiBaseHelper(enableLogging: true);
  //final FirebaseAuth _auth = FirebaseAuth.instance;
  final _secure = FlutterSecure();
  late BuildContext mContext;
  final LocalAuthHelper _localAuthHelper =
      LocalAuthHelper(auth: LocalAuthentication());
  final LocalAuthentication localAuth = LocalAuthentication();
  final AppStore _appStore = Modular.get<AppStore>();
  final UserAppStore _userAppStore = Modular.get<UserAppStore>();
  final _homeStore = Modular.get<HomeStore>();
  final BottomNavStore _bottomNav = Modular.get<BottomNavStore>();
  @observable
  bool loadingLogin = true;
  @observable
  String phoneNumberCache = '';
  @observable
  String phoneNumber = '';
  @observable
  String password = '';

  @action
  Future getInformationNumber() async {
    loadingLogin = true;
    phoneNumberCache = await SessionPrefs.getPhoneNumber() ?? '';
    loadingLogin = false;
  }

  @action
  void onPhoneNumberCache(String text) {
    phoneNumberCache = text.trim();
    phoneNumber = phoneNumberCache;
  }

  @action
  void onChangePhoneNumber(String text) {
    phoneNumber = text.trim();
  }

  @action
  void onChangePassword(String text) {
    password = text;
  }

  @action
  void changeBuildContext(BuildContext newContext) {
    mContext = newContext;
    password = "";
  }

  @action
  Future<void> biometricAuth(BuildContext context) async {
    final checkBiometric = await _checkBiometricAuthSetting();
    try {
      if (!checkBiometric) return;
      bool isAuthenticated = await _localAuthHelper.authenWithBiometrics();
      if (!isAuthenticated) {
        AppSnackBar.show(
            context, AppSnackBarType.Warning, l10n(context).login_check_device);
        return;
      }
      password = await _secure.readKeyStorage(key: phoneNumberCache) ?? '';
      await onLogin();
    } catch (e) {
      return AppSnackBar.show(
          mContext, AppSnackBarType.Error, "Bạn chưa cài đặt tính năng");
    }
  }

  Future<bool> _checkBiometricAuthSetting() async {
    final value = await _secure.readKeyStorage(key: phoneNumberCache);
    if (value == null || value.isEmpty) return false;
    return true;
  }

  Future<void> _logInSuccess(AuthenticationResult tokenData) async {
    await SessionPrefs.signedIn(tokenData);
    String user = json.encode(tokenData);
    ApiBaseHelper.setHeader(user);
    await _appStore.loadBiometricSetting();
    await checkLogin();
    final fcmToken = Platform.isIOS
        ? await FirebaseMessaging.instance.getAPNSToken()
        : await FirebaseMessaging.instance.getToken();
    print("fcm $fcmToken");
    _appStore.setFCMToken(fcmToken ?? "");

    var checkStaff = tokenData.user!.roles!.contains('STAFF');
    print('checkStaff $checkStaff');
    await SessionPrefs.isStaff(checkStaff);
  }
  // Future<void> _logInSuccess(AuthenticationResultV2 tokenData) async {
  //   await SessionPrefs.signedIn(tokenData);
  //   final secure = FlutterSecure();
  //   await secure.writeKeyStorage(
  //     key: "secretKey",
  //     value: tokenData.secretKey,
  //   );
  //   String user = json.encode(tokenData);
  //   ApiBaseHelper.setHeader(user);
  //   await _appStore.loadBiometricSetting();
  //   await checkLogin();
  //   final fcmToken = Platform.isIOS
  //       ? await FirebaseMessaging.instance.getAPNSToken()
  //       : await FirebaseMessaging.instance.getToken();
  //   _appStore.setFCMToken(fcmToken ?? "");
  //   // var checkStaff = tokenData.user!.roles!.contains('STAFF');
  //   // print('checkStaff $checkStaff');
  //   // await SessionPrefs.isStaff(checkStaff);
  // }

  @action
  Future<void> checkLogin() async {
    final isSignedIn = await SessionPrefs.isSignedIn();
    final sharedPrefer = GetIt.instance<SharedPreferencesManager>();
    if (isSignedIn) {
      _homeStore.isLogin = isSignedIn;
      await _userAppStore.getAccountDetail();
      await _homeStore.getBookings();
    }
  }

  @action
  Future<void> clearCache() async {
    await FlutterSecure().deleteKeyStorage(key: phoneNumberCache);
    await SessionPrefs.setActiveFinger(false);
    await SessionPrefs.deletePhoneNumber();
    phoneNumberCache = '';
    final settingStore = Modular.get<SettingStore>();
    settingStore.isActiveFinger = false;
  }

  @action
  Future<void> loginFacebook() async {
    final result = await FacebookAuth.instance.login();
    final token = result.accessToken?.token;
    if (token != null) {
      // final facebookAuthCredential = FacebookAuthProvider.credential(token);
      // await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
      //final user = await FacebookAuth.instance.getUserData();
    }
    // Once signed in, return the UserCredential
  }

  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  @action
  Future<void> loginApple() async {
    // final rawNonce = generateNonce();
    // final nonce = sha256ofString(rawNonce);
    // try {
    //   final appleCredential = await SignInWithApple.getAppleIDCredential(
    //     scopes: [
    //       AppleIDAuthorizationScopes.email,
    //       AppleIDAuthorizationScopes.fullName,
    //     ],
    //     nonce: nonce,
    //   );
    //   final oauthCredential = OAuthProvider("apple.com").credential(
    //     idToken: appleCredential.identityToken,
    //     rawNonce: rawNonce,
    //   );
    //   final authResult = await _auth.signInWithCredential(oauthCredential);
    //   final user = authResult.user;
    //
    //   if (user == null) {
    //     AppSnackBar.show(
    //         mContext, AppSnackBarType.Error, l10n(mContext)!.login_failed!);
    //     return;
    //   }
    //   EasyLoading.show();
    //   LoginSocialModel loginSocialModel = LoginSocialModel(
    //       displayName: appleCredential.familyName.toString() +
    //           " " +
    //           appleCredential.givenName.toString(),
    //       providerId: authResult.credential!.providerId,
    //       email: appleCredential.email ?? user.email,
    //       emailVerified: user.emailVerified,
    //       isAnonymous: user.isAnonymous,
    //       creationTime: DateTime.now(),
    //       lastSignInTime: DateTime.now(),
    //       photoUrl: user.photoURL,
    //       phoneNumber: user.phoneNumber,
    //       refreshToken: user.refreshToken,
    //       tenantId: user.tenantId,
    //       uid: user.uid);
    //   Utils.printObject(loginSocialModel);
    //   try {
    //     final response = await _apiBaseHelper.post(
    //         ApiUrl.loginBySocial, loginSocialModel.toRawJson());
    //     final authenticationResult = AuthenticationResult.fromJson(response);
    //     await _logInSuccess(authenticationResult);
    //   } on AppException catch (e) {
    //     EasyLoading.dismiss();
    //     AppSnackBar.show(mContext, AppSnackBarType.Error, e.toString());
    //   }
    // } catch (exception) {
    //   EasyLoading.dismiss();
    //   AppSnackBar.show(
    //       mContext, AppSnackBarType.Error, l10n(mContext)!.login_failed!);
    // }
  }

  @action
  Future<void> onLogin() async {
    EasyLoading.show();
    try {
      final response = await _apiBaseHelper.post(
        ApiUrl.token,
        LoginModel(
                username:
                    phoneNumberCache.isEmpty ? phoneNumber : phoneNumberCache,
                password: password,
                fireBaseToken: _appStore.fireBaseToken)
            .toRawJson(),
      );
      final authenticationResult = AuthenticationResult.fromJson(response);
      await _logInSuccess(authenticationResult);
      EasyLoading.dismiss();
      Modular.get<CommunityPageStore>().isLogin = true;
      _homeStore.isLogin = true;
      GetIt.instance<SharedPreferencesManager>()
          .putString(AppConfig.SL_USERNAME, phoneNumber);
      SessionPrefs.setPhoneNumber(
          value: phoneNumberCache.isEmpty ? phoneNumber : phoneNumberCache);
      FlutterSecure().writeKeyStorage(
          key: phoneNumberCache.isEmpty ? phoneNumber : phoneNumberCache,
          value: password);
      _bottomNav.currentIndex = 4;
      Modular.to.popAndPushNamed(AppRoutes.main);
    } on AppException catch (e) {
      EasyLoading.dismiss().then((value) =>
          AppSnackBar.show(mContext, AppSnackBarType.Error, e.getMessage()));
    } catch (e) {
      EasyLoading.dismiss().then((value) =>
          AppSnackBar.show(mContext, AppSnackBarType.Error, e.toString()));
    }
  }
}
