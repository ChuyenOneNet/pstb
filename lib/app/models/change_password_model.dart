import 'dart:convert';

class ChangePasswordModel {
  ChangePasswordModel({
    this.phone,
    this.oldPassword,
    this.newPassword,
  });

  String? phone;
  String? oldPassword;
  String? newPassword;

  factory ChangePasswordModel.fromRawJson(String str) =>
      ChangePasswordModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChangePasswordModel.fromJson(Map<String, dynamic> json) =>
      ChangePasswordModel(
        phone: json["phone"],
        oldPassword: json["password"],
        newPassword: json["new_password"],
      );

  Map<String, dynamic> toJson() => {
        "oldPassword": oldPassword,
        "newPassword": newPassword,
      };
}
