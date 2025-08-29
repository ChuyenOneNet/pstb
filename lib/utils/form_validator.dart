import '../models/address_model.dart';
import '../models/job_model.dart';
import 'package:flutter/material.dart';

class FormValidator {
  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) return 'Bắt buộc';
    if (!RegExp(r'^\d{10}$').hasMatch(value.trim())) {
      return 'Chưa đúng định dạng số điện thoại';
    }
    return null;
  }

  static String? validateCCCD(String? value) {
    if (value == null || value.trim().isEmpty) return 'Bắt buộc';
    if (!RegExp(r'^\d{12}$').hasMatch(value.trim())) {
      return 'Chưa đúng định dạng CCCD';
    }
    return null;
  }

  static String? validateDate(String? value) {
    if (value == null || value.isEmpty) return 'Bắt buộc';
    final parts = value.split('/');
    if (parts.length != 3) return 'Ngày phải dạng dd/MM/yyyy';

    try {
      final d = int.parse(parts[0]);
      final m = int.parse(parts[1]);
      final y = int.parse(parts[2]);
      final date = DateTime(y, m, d);

      if (date.year != y || date.month != m || date.day != d) {
        return 'Ngày không hợp lệ';
      }
      if (date.isAfter(DateTime.now())) {
        return 'Ngày không được lớn hơn hôm nay';
      }
      return null;
    } catch (_) {
      return 'Ngày không hợp lệ';
    }
  }

  static String? validateAge(String? value) {
    if (value == null || value.trim().isEmpty) return 'Bắt buộc';
    final n = int.tryParse(value);
    if (n == null) return 'Tuổi phải là số';
    if (n < 0) return 'Tuổi không hợp lệ';
    return null;
  }

  static bool validateForm({
    required GlobalKey<FormState> formKey,
    required String cccd,
    required Address? selectedAddress,
    required String idIssueDate,
    required Job? selectedJob,
    required String age,
    required String fatherName,
    required String motherName,
    required Function(String) onWarning,
  }) {
    if (!formKey.currentState!.validate()) {
      onWarning('Còn thiếu trường thông tin bắt buộc');
      return false;
    }

    if (cccd.trim().isEmpty) {
      onWarning('CCCD là bắt buộc');
      return false;
    }

    if (selectedAddress == null) {
      onWarning('Vui lòng chọn quận/huyện/thành phố');
      return false;
    }

    if (idIssueDate.trim().isEmpty) {
      onWarning('Ngày cấp CCCD là bắt buộc');
      return false;
    }

    if (selectedJob == null) {
      onWarning('Vui lòng chọn nghề nghiệp');
      return false;
    }

    final ageNum = int.tryParse(age.trim());
    if (ageNum == null) {
      onWarning('Tuổi phải là số hợp lệ');
      return false;
    }

    if (ageNum < 0) {
      onWarning('Tuổi không hợp lệ');
      return false;
    }

    if (ageNum < 16) {
      if (fatherName.trim().isEmpty && motherName.trim().isEmpty) {
        onWarning('Trẻ em dưới 16 tuổi phải khai tên bố hoặc mẹ');
        return false;
      }
    }

    return true;
  }
}
