// To parse this JSON data, do
//
//     final loginSocialModel = loginSocialModelFromJson(jsonString);

import 'dart:convert';

class LoginSocialModel {
  LoginSocialModel({
    required this.uid,
    this.displayName,
    this.email,
    this.emailVerified,
    this.isAnonymous,
    this.creationTime,
    this.lastSignInTime,
    this.phoneNumber,
    this.photoUrl,
    required this.providerId,
    this.refreshToken,
    this.tenantId,
  });

  String uid;
  String? displayName;
  String? email;
  bool? emailVerified;
  bool? isAnonymous;
  DateTime? creationTime;
  DateTime? lastSignInTime;
  String? phoneNumber;
  String? photoUrl;
  String providerId;
  String? refreshToken;
  String? tenantId;

  factory LoginSocialModel.fromRawJson(String str) =>
      LoginSocialModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginSocialModel.fromJson(Map<String, dynamic> json) =>
      LoginSocialModel(
        displayName: json["displayName"],
        email: json["email"],
        emailVerified: json["emailVerified"],
        isAnonymous: json["isAnonymous"],
        creationTime: DateTime.parse(json["creationTime"]),
        lastSignInTime: DateTime.parse(json["lastSignInTime"]),
        phoneNumber: json["phoneNumber"],
        photoUrl: json["photoURL"],
        providerId: json["providerId"],
        refreshToken: json["refreshToken"],
        tenantId: json["tenantId"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "displayName": displayName,
        "email": email,
        "emailVerified": emailVerified,
        "isAnonymous": isAnonymous,
        "creationTime": creationTime!.toIso8601String(),
        "lastSignInTime": lastSignInTime!.toIso8601String(),
        "phoneNumber": phoneNumber,
        "photoURL": photoUrl,
        "providerId": providerId,
        "refreshToken": refreshToken,
        "tenantId": tenantId,
        "uid": uid,
      };
}
