// To parse this JSON data, do
//
//     final resetPasswordModel = resetPasswordModelFromJson(jsonString);

import 'dart:convert';

class ForgotPasswordModel {
  ForgotPasswordModel({
    this.username,
    this.newPassword,
    this.confirmPassword,
    this.otp,
    required this.key,
  });

  String key;
  String? username;
  String? newPassword;
  String? confirmPassword;
  String? otp;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "username": username == null ? null : username,
        "newPassword": newPassword == null ? null : newPassword,
        "confirm_password": confirmPassword == null ? null : confirmPassword,
        "otp": otp == null ? null : otp,
        "key": key
      };
}
