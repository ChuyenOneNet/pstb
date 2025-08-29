import 'package:shared_preferences/shared_preferences.dart';

class LocalSettingsPref {
  static const String AUTH_BIOMETRIC = "PRINT_FINGER_KEY";

  static Future<bool> isEnableBiometric() async {
    final prefs = await SharedPreferences.getInstance();

    final isEnable = prefs.getBool(AUTH_BIOMETRIC) ?? false;

    return isEnable;
  }

  static Future<bool> setBiometric(bool isEnable) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(AUTH_BIOMETRIC, isEnable);
  }

  static Future clearSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AUTH_BIOMETRIC);
  }
}
