// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_model_v2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthenticationResultV2 _$AuthenticationResultV2FromJson(
        Map<String, dynamic> json) =>
    AuthenticationResultV2(
      json['token'] as String?,
      json['tokenType'] as String?,
      json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      json['secretKey'] as String?,
    );

Map<String, dynamic> _$AuthenticationResultV2ToJson(
        AuthenticationResultV2 instance) =>
    <String, dynamic>{
      'token': instance.token,
      'tokenType': instance.tokenType,
      'user': instance.user,
      'secretKey': instance.secretKey,
    };
