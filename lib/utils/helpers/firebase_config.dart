import 'dart:convert';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:pstb/utils/constants.dart';
import 'package:pstb/utils/sessions/session_prefs.dart';
import 'package:pstb/version_util.dart';

class FireBaseConfigModel {
  String? baseUrl;
  String? nameUnit;
  String? codeUnit;
  int? idUnit;

  FireBaseConfigModel(
      {this.baseUrl, this.nameUnit, this.codeUnit, this.idUnit});

  FireBaseConfigModel.fromJson(Map<String, dynamic> json) {
    baseUrl = json['baseUrl'];
    nameUnit = json['nameUnit'];
    codeUnit = json['codeUnit'];
    idUnit = json['idUnit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['baseUrl'] = baseUrl;
    data['nameUnit'] = nameUnit;
    data['codeUnit'] = codeUnit;
    data['idUnit'] = idUnit;
    return data;
  }
}

class FireBaseRemoteConfigService {
  static Future<FireBaseConfigModel> getConfig() async {
    try {
      var version = await getCurrentVersion();
      print("version:" + version.toString());
      final remoteConfig = FirebaseRemoteConfig.instance;
      await remoteConfig.activate();
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 1),
        minimumFetchInterval: const Duration(seconds: 10),
      ));
      await remoteConfig.fetchAndActivate();
      final jsonConfig = remoteConfig.getString("config");
      print("config:" + jsonConfig);
      Constants.versionApp = remoteConfig.getString('version_app');
      print('version: ${Constants.versionApp.toString()}');
      final cfgModel = FireBaseConfigModel.fromJson(jsonDecode(jsonConfig));
      final idUnit = cfgModel.idUnit ?? 0;
      await SessionPrefs.setMedicalUnitId(idUnit);
      return cfgModel;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
