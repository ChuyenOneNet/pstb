import 'package:json_annotation/json_annotation.dart';
part 'change_password_model_v2.g.dart';

@JsonSerializable()
class ChangePasswordModelV2 {
  ChangePasswordModelV2({
    this.id,
    this.phone,
    this.secretKey,
    this.otp,
    this.oldPassword,
    this.newPassword,
  });
  String? id;
  String? phone;
  String? secretKey;
  String? otp;
  String? oldPassword;
  String? newPassword;

  factory ChangePasswordModelV2.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordModelV2FromJson(json);

  Map<String, dynamic> toJson() => _$ChangePasswordModelV2ToJson(this);
}
