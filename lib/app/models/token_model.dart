import 'dart:convert';
import 'package:pstb/extensions/data_extension.dart';
import 'package:pstb/utils/main.dart';

class AuthenticationResult {
  String? token;
  String? tokenType;
  User? user;

  AuthenticationResult(this.token, this.tokenType, this.user);

  factory AuthenticationResult.fromRawJson(String str) =>
      AuthenticationResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AuthenticationResult.fromJson(Map<String, dynamic> json) =>
      AuthenticationResult(
          json["token"], json["tokenType"], User.fromJson(json["user"]));

  Map<String, dynamic> toJson() => {
        "token": token,
        "tokenType": tokenType,
        "user": user == null ? null : user?.toJson()
      };
}

class User {
  User({
    this.id,
    this.phone,
    this.fullName,
    this.email,
    this.roles,
  });

  String? id;
  String? phone;
  String? fullName;
  String? email;
  List<String>? roles;

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        phone: json["phone"] == null ? null : replacePhoneCode(json["phone"]),
        fullName: json["fullName"],
        email: json["email"],
        roles: json.tryGetList("roles", (item) => item),
      );

  Map<String, dynamic> toJson() =>
      {"id": id, "phone": phone, "fullName": fullName};
}
