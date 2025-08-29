// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_password_model_v2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangePasswordModelV2 _$ChangePasswordModelV2FromJson(
        Map<String, dynamic> json) =>
    ChangePasswordModelV2(
      id: json['id'] as String?,
      phone: json['phone'] as String?,
      secretKey: json['secretKey'] as String?,
      otp: json['otp'] as String?,
      oldPassword: json['oldPassword'] as String?,
      newPassword: json['newPassword'] as String?,
    );

Map<String, dynamic> _$ChangePasswordModelV2ToJson(
        ChangePasswordModelV2 instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phone': instance.phone,
      'secretKey': instance.secretKey,
      'otp': instance.otp,
      'oldPassword': instance.oldPassword,
      'newPassword': instance.newPassword,
    };
