import 'dart:convert';
import 'package:pstb/app/models/medical_unit/hospital_unit_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pstb/app/models/token_model.dart';
import 'package:pstb/utils/constants.dart';
import 'package:pstb/utils/sessions/local_setting_pref.dart';

import '../../app/models/lading_unit_model.dart';
import '../../app/models/token_model_v2.dart';

class SessionPrefs {
  /// call when have signed in and fetch user data was successfully
  /// This function set new profile
  /// if [newUser] and [cacheUser] are difference -> clear settings
  /// or they are same -> no clear settings
  static Future<void> signedIn(AuthenticationResult newUser) async {
    final cacheUserData = await getProfileData();

    if (cacheUserData == null) {
      await LocalSettingsPref.clearSettings();
    } else {
      final cacheUser =
          AuthenticationResult.fromJson(json.decode(cacheUserData));
      if (cacheUser.user?.phone != newUser.user?.phone) {
        await LocalSettingsPref.clearSettings();
      }
    }
    await saveProfileData(newUser.toRawJson());
    await _setSignedIn(true);
  }

  // static Future<void> signedIn(AuthenticationResultV2 newUser) async {
  //   final cacheUserData = await getProfileData();
  //
  //   if (cacheUserData == null) {
  //     await LocalSettingsPref.clearSettings();
  //   } else {
  //     final cacheUser =
  //         AuthenticationResult.fromJson(json.decode(cacheUserData));
  //     if (cacheUser.user?.phone != newUser.user?.phone) {
  //       await LocalSettingsPref.clearSettings();
  //     }
  //   }
  //   await saveProfileData(newUser.toRawJson());
  //   await _setSignedIn(true);
  // }

  //get enable notification
  static Future<bool?> getEnableNotification() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(Constants.enableNotification);
  }

  //change
  static Future<bool> setEnableNotification(bool enable) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(Constants.enableNotification, enable);
  }

  ///set medical unit
  static Future<void> saveUnit(HospitalModel hospitalModel) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(Constants.idUnit, hospitalModel.id ?? 0);
    await prefs.setString(Constants.avatarUnit, hospitalModel.image ?? '');
    await prefs.setString(Constants.nameUnit, hospitalModel.name ?? '');
    await prefs.setString(Constants.addressUnit, hospitalModel.address ?? '');
  }

  ///set id unit
  static Future<void> setMedicalUnitId(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(Constants.idUnit, id);
  }

  ///get id unit
  static Future<int?> getMedicalUnitId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(Constants.idUnit);
  }

  ///get avatar unit
  static Future<String?> getAvatarUnit() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constants.avatarUnit);
  }

  ///get name unit
  static Future<String?> getNameUnit() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constants.nameUnit);
  }

  ///get address unit
  static Future<String?> getAddressUnit() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constants.addressUnit);
  }

  /// get profile raw data
  static Future<String?> getProfileData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constants.user);
  }

  /// save user profile data
  static Future<bool> saveProfileData(String user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(Constants.user, user);
  }

  /// call when user pressed logout button
  /// this function set flag = false
  static Future<void> signedOut() => _setSignedIn(false);

  static Future<void> signedOutAndClearData() async {
    await signedOut();
    await clearUserProfileSession();
  }

  /// clear data all user data
  static Future<void> clearUserProfileSession() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(Constants.user);
    await LocalSettingsPref.clearSettings();
  }

  /// get signed in flag
  /// return true/false
  static Future<bool> isSignedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(Constants.signedIn) ?? false;
  }

  /// set flag
  static Future<bool> _setSignedIn(bool isSignedIn) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(Constants.signedIn, isSignedIn);
  }

  static Future<void> setPhoneNumber({String value = ''}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(Constants.keyPhoneNumber, value);
  }

  static Future<String?> getPhoneNumber() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constants.keyPhoneNumber);
  }

  static Future<void> deletePhoneNumber() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(Constants.keyPhoneNumber);
  }

  static Future<void> setKeywordPackage(List<String> value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(Constants.keywordPackage, value);
  }

  static Future<List<String>?> getKeywordPackage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(Constants.keywordPackage);
  }

  static Future<bool> isStaff(bool isStaff) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(Constants.isStaff, isStaff);
  }

  static Future<bool> checkStaff() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(Constants.isStaff) ?? false;
  }

  /// set ActiveFinger
  static Future<bool> setActiveFinger(bool isActiveFinger) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(Constants.isActiveFinger, isActiveFinger);
  }

  static Future<bool> getActiveFinger() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(Constants.isActiveFinger) ?? false;
  }
}
