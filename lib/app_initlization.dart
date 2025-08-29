import 'package:pstb/utils/helpers/firebase_config.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/utils/sessions/session_prefs.dart';

// static const String apiBaseUrl = "http://10.0.2.2:5243";
// static const String baseUrl = "http://192.168.1.123:5245"; // url on truong-lx
// const String defaultUrl = "http://192.168.1.123:5245"; // url on truong-lx
// static const String baseUrl = "http://192.168.1.3:5245";
// static const String baseUrl = "http://116.97.240.210:5244";
// static const String baseUrl = "http://115.146.126.203:5243"; // url on HYH - 1
// static const String baseUrl = "http://115.146.126.203:5244"; // url on HYH - 2
const String defaultUrl = "http://116.97.240.210:5105";
// const String defaultUrl = "http://192.168.1.141:5245";
// const String defaultUrl = "http://192.168.1.55:5245";
// const String defaultUrl = "http://192.168.1.123:5246";
// const String defaultUrl = "http://192.168.1.123:5245";
////const String defaultUrl = "http://116.97.240.210:55";
Future initApp() async {
  await initApi();
}

Future initApi() async {
  try {
    //await SessionPrefs.setMedicalUnitId(9);
    var cfg = await FireBaseRemoteConfigService.getConfig();
    ApiUrl.baseUrl = cfg.baseUrl ?? defaultUrl;
  } catch (e) {
    ApiUrl.baseUrl = defaultUrl;
  }
  ApiUrl.baseUrl = defaultUrl;
}
