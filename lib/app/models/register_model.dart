import 'dart:convert';

class RegisterModel {
  RegisterModel({
    this.status,
    this.code,
    this.data,
    this.message,
  });

  String? status;
  int? code;
  Data? data;
  dynamic message;

  factory RegisterModel.fromRawJson(String str) =>
      RegisterModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegisterModel.fromJson(Map<String, dynamic> json) =>
      RegisterModel(
        status: json["status"],
        code: json["code"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "data": data == null ? null : data!.toJson(),
        "message": message,
      };
}

class Data {
  Data({
    required this.username,
    required this.password,
    required this.phone,
    required this.fullName,
  });

  String phone;
  String username;
  String password;
  String fullName;
  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        username: json["username"],
        password: json["password"],
        phone: json["phone"],
    fullName: json["fullName"],
      );

  Map<String, dynamic> toJson() => {
        // ignore: unnecessary_null_comparison
        "username": username,
        // ignore: unnecessary_null_comparison
        "password": password,
        "phone": phone,
    "fullName":fullName
      };
}
