import 'dart:convert';

import '../signup_store.dart';

class UserInfoModel {
  UserInfoModel({
    this.name,
    this.email,
    this.dob,
    this.gender,
  });

  String? name;
  String? email;
  String? dob;
  String? gender;

  factory UserInfoModel.fromRawJson(String str) =>
      UserInfoModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
        name: json["name"],
        email: json["email"],
        dob: json["dob"],
        gender: json["gender"],
      );

  Map<String, dynamic> toJson() => {
        "fullname": name ?? "",
        "email": email ?? "",
        "dob": dob ?? "",
        "gender": gender ?? Gender.u,
      };
}
