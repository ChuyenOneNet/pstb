import 'package:flutter/services.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthHelper {
  final LocalAuthentication auth;
  LocalAuthHelper({required this.auth});

  Future<bool> checkDeviceSupportLocalAuth() async {
    try {
      return await auth.canCheckBiometrics || await auth.isDeviceSupported();
    } catch (e) {
      return false;
    }
  }

  Future<bool> authenticateWithBiometrics(String message,
      {AndroidAuthMessages androidAuthMessages =
          const AndroidAuthMessages()}) async {
    if (!await checkDeviceSupportLocalAuth()) {
      return false;
    }
    try {
      return await auth.authenticate(
          localizedReason: message,
          options: const AuthenticationOptions(useErrorDialogs: false),
          authMessages: [
            androidAuthMessages,
          ]);
    } on PlatformException catch (e) {
      return false;
    }
  }

  Future<bool> authenWithBiometrics() async {
    final LocalAuthentication localAuthentication = LocalAuthentication();
    bool isBiometricSupported = await localAuthentication.isDeviceSupported();
    bool canCheckBiometrics = await localAuthentication.canCheckBiometrics;

    bool isAuthenticated = false;

    if (isBiometricSupported && canCheckBiometrics) {
      isAuthenticated = await localAuthentication.authenticate(
        localizedReason: 'Please complete the biometrics to proceed.',
      );
    }

    return isAuthenticated;
  }
}
