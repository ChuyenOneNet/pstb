import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// String helpers (phone/cccd/username/password)
extension StringX on String {
  /// Giữ lại số và dấu +, bỏ khoảng trắng/ký tự thừa
  String _cleanPhone() => replaceAll(RegExp(r'[^0-9+]'), '');

  /// Chuẩn hoá số VN về E.164: +84xxxxxxxxx
  String toE164VN() {
    final raw = trim();
    if (raw.isEmpty) return raw;
    var s = _cleanPhone();

    // Trường hợp 84xxxxxxxxx -> +84xxxxxxxxx
    if (RegExp(r'^84\d{9,10}$').hasMatch(s)) return '+$s';

    // Đã là +84...
    if (s.startsWith('+84')) {
      // đảm bảo phần sau chỉ có số
      return '+84${s.substring(3).replaceAll(RegExp(r'[^0-9]'), '')}';
    }

    // 0xxxxxxxxx -> +84xxxxxxxxx
    if (RegExp(r'^0\d{9,10}$').hasMatch(s)) {
      return '+84${s.substring(1)}';
    }

    // Trường hợp khác: trả về chuỗi đã làm sạch
    return s;
  }

  /// Kiểm tra định dạng số điện thoại VN (chấp nhận 0... hoặc +84...)
  bool get isVNPhone {
    final s = trim();
    if (s.isEmpty) return false;
    final e164 = toE164VN();
    return RegExp(r'^\+84\d{9,10}$').hasMatch(e164) ||
        RegExp(r'^0\d{9,10}$').hasMatch(_cleanPhone());
  }

  /// CCCD 12 số hoặc CMND 9 số
  bool get isCccdOrCmnd => RegExp(r'^\d{9}(\d{3})?$').hasMatch(trim());

  /// Username (>=4 ký tự) hoặc CCCD/CMND
  bool get isUserOrCccd {
    final t = trim();
    if (t.isEmpty) return false;
    if (RegExp(r'^\d{9}(\d{3})?$').hasMatch(t)) return true;
    return t.length >= 4;
  }

  /// Mật khẩu mạnh: 8–32 ký tự, có hoa/thường/số/ký tự đặc biệt
  bool get isStrongPassword =>
      RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z0-9]).{8,32}$')
          .hasMatch(this);
}

String viLabelFromTime(DateTime t, {bool use12h = false}) {
  final hm = DateFormat(use12h ? 'hh:mm' : 'HH:mm').format(t);
  return '$hm ${t.hour < 12 ? 'Sáng' : 'Chiều'}';
}

/// (Tuỳ chọn) tiện hơn: gọi trực tiếp trên DateTime
extension DateTimeViX on DateTime {
  String toViTimeLabel({bool use12h = false}) =>
      viLabelFromTime(this, use12h: use12h);
}

extension IsoStringDateFormatX on String {
  /// Chuyển ISO time string -> "dd/MM/yyyy"
  /// - [toLocal]: true => đổi sang giờ local trước khi lấy ngày (mặc định).
  /// - [onError]: giá trị trả về khi parse lỗi.
  String toDdMmYyyy({bool toLocal = true, String onError = ''}) {
    try {
      var dt = DateTime.parse(this); // hỗ trợ "Z" / offset / hoặc local
      dt = toLocal ? dt.toLocal() : dt.toUtc();
      final dd = dt.day.toString().padLeft(2, '0');
      final mm = dt.month.toString().padLeft(2, '0');
      final yyyy = dt.year.toString().padLeft(4, '0');
      return '$dd/$mm/$yyyy';
    } catch (_) {
      return onError;
    }
  }

  String toDdMmYyyyHHmm({bool toLocal = false, String onError = ''}) {
    try {
      var dt = DateTime.parse(this);
      dt = toLocal ? dt.toLocal() : dt.toUtc();
      final dd = dt.day.toString().padLeft(2, '0');
      final mm = dt.month.toString().padLeft(2, '0');
      final yyyy = dt.year.toString().padLeft(4, '0');
      final hh = dt.hour.toString().padLeft(2, '0');
      final mi = dt.minute.toString().padLeft(2, '0');
      return '$dd/$mm/$yyyy $hh:$mi';
    } catch (_) {
      return onError;
    }
  }

  /// ISO -> "HH:mm" (24h)
  String toHHmm({bool toLocal = true, String onError = ''}) {
    try {
      var dt = DateTime.parse(this);
      dt = toLocal ? dt.toLocal() : dt.toUtc();
      final hh = dt.hour.toString().padLeft(2, '0');
      final mi = dt.minute.toString().padLeft(2, '0');
      return '$hh:$mi';
    } catch (_) {
      return onError;
    }
  }

  /// ISO -> "hh:mm Sáng|Chiều" (12h tiếng Việt)
  String toViHhMm({bool toLocal = true, String onError = ''}) {
    try {
      var dt = DateTime.parse(this);
      dt = toLocal ? dt.toLocal() : dt.toUtc();

      var hour = dt.hour;
      final minute = dt.minute.toString().padLeft(2, '0');

      String ampm = 'Sáng';
      if (hour >= 12) {
        ampm = 'Chiều';
        if (hour > 12) hour -= 12;
      }
      if (hour == 0) hour = 12; // 00:xx -> 12:xx Sáng

      final hh12 = hour.toString().padLeft(2, '0');
      return '$hh12:$minute $ampm';
    } catch (_) {
      return onError;
    }
  }
}
