import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/models/config_model.dart';
import 'package:pstb/services/api_base_helper.dart';
import 'package:pstb/utils/main.dart';

class ConfigHelper {
  static const String covid = "CovidDeclarationTemplate";
  static const String sosLine = "SOS_LINE";
  static const String supportLine = "SUPPORT_LINE";
  static const String fanPage = "FAN_PAGE";
  static const String about = "ABOUT_PAGE";
  static const String otpSignUp = "OTP_SIGN_UP"; // system_cfg.
  static const String otpForgot = "OTP_FORGOT_PASSWORD";
  static const String supportMess = "SUPPORT_MESS";
  static const String timeStartBooking = "TIME_START";
  static const String timeEndBooking = "TIME_END"; // medical_unit_cfg.
  static const String enablePromotion = "ENABLE_PROMOTION";

  ConfigHelper._singleton();

  static final ConfigHelper _instance = ConfigHelper._singleton();

  static ConfigHelper get instance => _instance;
  final List<DataConfig> _listConfig = [];

  Future<void> loadData(int medicalUnitId) async {
    final data = await Modular.get<ApiBaseHelper>()
        .get(ApiUrl.config, {"MedicalUnitId": medicalUnitId});
    for (final dataConfig in data) {
      _listConfig.add(DataConfig.fromJson(dataConfig));
    }
  }

  Future<DataConfig?> getConfigById(int id) async {
    for (var config in _listConfig) {
      if (config.id == id) {
        return config;
      }
    }
    return null;
  }

  Future<DataConfig?> getConfigByCode(String code) async {
    for (var config in _listConfig) {
      if (config.code?.toLowerCase() == code.toLowerCase()) {
        return config;
      }
    }
    return null;
  }

  Future<DataConfig?> tryGetConfigByCode(
      String code, String defaultValue) async {
    for (var config in _listConfig) {
      if (config.code?.toLowerCase() == code.toLowerCase()) {
        return config;
      }
    }
    return DataConfig(code: code, value: defaultValue);
  }

  Future<String> tryGetConfigValueByCode(
      String code, String defaultValue) async {
    for (var config in _listConfig) {
      if (config.code?.toLowerCase() == code.toLowerCase()) {
        return config.value ?? defaultValue;
      }
    }
    return defaultValue;
  }

  DataConfig? getConfigByCodeSync(String code) {
    for (var config in _listConfig) {
      if (config.code?.toLowerCase() == code.toLowerCase()) {
        return config;
      }
    }
    return null;
  }
}
