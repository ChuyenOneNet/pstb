import 'dart:convert';

class LoginModel {
  LoginModel({
    required this.username,
    required this.password,
    this.fireBaseToken,
  });

  String username;
  String password;
  String? fireBaseToken;

  factory LoginModel.fromRawJson(String str) =>
      LoginModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        username: json["username"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "fireBaseToken": fireBaseToken
      };
}

class FCMToken {
  FCMToken({
    required this.registrationId,
    required this.user,
  });

  String registrationId;
  int user;

  factory FCMToken.fromRawJson(String str) =>
      FCMToken.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FCMToken.fromJson(Map<String, dynamic> json) => FCMToken(
        registrationId: json["phone"],
        user: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "registration_id": registrationId,
        "user": user,
      };
}

class RefreshTokenModel {
  RefreshTokenModel({
    required this.username,
    this.fireBaseToken,
  });

  String username;
  String? fireBaseToken;

  factory RefreshTokenModel.fromRawJson(String str) =>
      RefreshTokenModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RefreshTokenModel.fromJson(Map<String, dynamic> json) => RefreshTokenModel(
    username: json["username"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "fireBaseToken": fireBaseToken
  };
}

