import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FlutterSecure {
  final _storage = const FlutterSecureStorage();

  Future<String?> readKeyStorage({String key = ''}) async {
    return await _storage.read(key: key);
  }

  Future<void> deleteKeyStorage({String key = ''}) async {
    await _storage.delete(key: key);
  }

  Future<void> writeKeyStorage({String key = '', dynamic value}) async {
    await _storage.write(key: key, value: value);
  }
}