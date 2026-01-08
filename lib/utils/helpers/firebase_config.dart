import 'dart:convert';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:pstb/utils/constants.dart';
import 'package:pstb/utils/sessions/session_prefs.dart';
import 'package:pstb/version_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FireBaseConfigModel {
  String? baseUrl;
  String? nameUnit;
  String? codeUnit;
  int? idUnit;
  String? vduhUrl;

  FireBaseConfigModel(
      {this.baseUrl, this.nameUnit, this.codeUnit, this.idUnit});

  FireBaseConfigModel.fromJson(Map<String, dynamic> json) {
    baseUrl = json['baseUrl'];
    nameUnit = json['nameUnit'];
    codeUnit = json['codeUnit'];
    idUnit = json['idUnit'];
    vduhUrl = json['vduhUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['baseUrl'] = baseUrl;
    data['nameUnit'] = nameUnit;
    data['codeUnit'] = codeUnit;
    data['idUnit'] = idUnit;
    data['vduhUrl'] = vduhUrl;
    return data;
  }
}

class CommunityUrlConfig {
  final String facebookPage;
  final String facebookChat;
  final String zaloChat;

  CommunityUrlConfig({
    required this.facebookPage,
    required this.facebookChat,
    required this.zaloChat,
  });

  factory CommunityUrlConfig.fromJson(Map<String, dynamic> json) {
    return CommunityUrlConfig(
      facebookPage: json['facebookPage'] ?? '',
      facebookChat: json['facebookChat'] ?? '',
      zaloChat: json['zaloChat'] ?? '',
    );
  }
}

class FireBaseRemoteConfigService {
  static Future<FireBaseConfigModel> getConfig() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
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
      final urlJson = remoteConfig.getString('url');

      if (urlJson.isNotEmpty) {
        final communityUrlConfig =
            CommunityUrlConfig.fromJson(jsonDecode(urlJson));

        Constants.facebookPageUrl = communityUrlConfig.facebookPage;
        Constants.facebookChatUrl = communityUrlConfig.facebookChat;
        Constants.zaloChatUrl = communityUrlConfig.zaloChat;
      }

      final cfgModel = FireBaseConfigModel.fromJson(jsonDecode(jsonConfig));
      print('baseUrl: ${cfgModel.baseUrl}');
      final idUnit =
          //6;
          cfgModel.idUnit ?? 9;
      await SessionPrefs.setMedicalUnitId(idUnit);
      await prefs.setString(
          "vduhUrl", cfgModel.vduhUrl ?? "https://116.97.240.210:6443/");
      print('vduhUrl: ${cfgModel.vduhUrl}');
      return cfgModel;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
