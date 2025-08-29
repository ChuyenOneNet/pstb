import 'dart:convert';
import 'package:pstb/extensions/data_extension.dart';
import 'package:pstb/utils/main.dart';
import 'package:json_annotation/json_annotation.dart';
part 'token_model_v2.g.dart';

@JsonSerializable()
class AuthenticationResultV2 {
  String? token;
  String? tokenType;
  User? user;
  String? secretKey;
  AuthenticationResultV2(
    this.token,
    this.tokenType,
    this.user,
    this.secretKey,
  );

  factory AuthenticationResultV2.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResultV2FromJson(json);

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => _$AuthenticationResultV2ToJson(this);
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
