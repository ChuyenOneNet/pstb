import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceUtil {
  static Future<String?> getId() async {
    var deviceInfo = DeviceInfoPlugin();
    try {
      if (Platform.isIOS) {
        // iOS specific code
        var iosDeviceInfo = await deviceInfo.iosInfo;
        return iosDeviceInfo.identifierForVendor; // unique ID on iOS
      } else if (Platform.isAndroid) {
        // Android specific code
        var androidDeviceInfo = await deviceInfo.androidInfo;
        return androidDeviceInfo.id; // unique ID on Android (use 'id' instead of 'androidId')
      }
    } catch (e) {
      print("Error fetching device ID: $e");
    }
    return null;
  }
}