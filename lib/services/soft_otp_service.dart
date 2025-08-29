import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:otp/otp.dart';
import 'package:ntp/ntp.dart';
import 'dart:typed_data';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:base32/base32.dart';

class SoftOtpService {
  static const _storageKey = 'otp_secret';
  static final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  DateTime? _cachedNetworkTime;
  Duration _offsetFromLocal = Duration.zero;

  /// Lưu secret key vào secure storage
  Future<void> saveSecretKey(String secret) async {
    await _secureStorage.write(key: _storageKey, value: secret);
  }

  /// Xóa secret key khỏi local (ví dụ khi logout)
  Future<void> clearSecretKey() async {
    await _secureStorage.delete(key: _storageKey);
  }

  /// Lấy secret key từ secure storage
  Future<String?> getSecretKey() async {
    return await _secureStorage.read(key: _storageKey);
  }

  /// Lấy thời gian chính xác từ NTP (cache để dùng lại)
  Future<DateTime> _getAccurateTime() async {
    if (_cachedNetworkTime != null) {
      return DateTime.now().add(_offsetFromLocal);
    }

    try {
      final ntpTime = await NTP.now();
      final localTime = DateTime.now();
      _cachedNetworkTime = ntpTime;
      _offsetFromLocal = ntpTime.difference(localTime);
      return ntpTime;
    } catch (_) {
      return DateTime.now();
    }
  }

  String generateOtp(String secretKey, int timeStepSeconds, int digits) {
    final keyBytes = base32.decode(secretKey.toUpperCase());

    final seconds = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final counter = seconds ~/ timeStepSeconds;

    final counterBytes = ByteData(8)..setInt64(0, counter, Endian.big);

    final hmac = Hmac(sha1, keyBytes);
    final hash = hmac.convert(counterBytes.buffer.asUint8List()).bytes;

    final offset = hash.last & 0xf;
    final binary = ((hash[offset] & 0x7f) << 24) |
        ((hash[offset + 1] & 0xff) << 16) |
        ((hash[offset + 2] & 0xff) << 8) |
        (hash[offset + 3] & 0xff);

    final otp = binary % pow(10, digits).toInt();
    return otp.toString().padLeft(digits, '0');
  }

  /// Thời gian còn lại trước khi mã OTP hết hạn (0–30)
  int getTimeLeft() {
    final seconds = DateTime.now().second;
    return 30 - (seconds % 30);
  }
}
