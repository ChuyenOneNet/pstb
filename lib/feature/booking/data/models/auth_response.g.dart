// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthResponse _$AuthResponseFromJson(Map<String, dynamic> json) => AuthResponse(
      access_token: json['access_token'] as String,
      created_time: (json['created_time'] as num).toInt(),
      expire_time: (json['expire_time'] as num).toInt(),
    );

Map<String, dynamic> _$AuthResponseToJson(AuthResponse instance) =>
    <String, dynamic>{
      'access_token': instance.access_token,
      'created_time': instance.created_time,
      'expire_time': instance.expire_time,
    };
