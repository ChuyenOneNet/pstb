import 'package:package_info_plus/package_info_plus.dart';

class Version {
  late String version;
  late String code;

  Version(this.version, this.code);
  @override
  String toString() {
    // TODO: implement toString
    return "${version}_$code".replaceAll('.', '_');
  }
}

getCurrentVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String version = packageInfo.version;
  String code = packageInfo.buildNumber;
  return Version(version, code);
}