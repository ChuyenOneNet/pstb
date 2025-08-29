// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_his_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserHisModel _$UserHisModelFromJson(Map<String, dynamic> json) => UserHisModel(
      id: (json['id'] as num?)?.toInt(),
      userName: json['userName'] as String?,
      name: json['name'] as String?,
      surname: json['surname'] as String?,
      emailAddress: json['emailAddress'] as String?,
      isActive: json['isActive'] as bool?,
      fullName: json['fullName'] as String?,
      lastLoginTime: json['lastLoginTime'] as String?,
      creationTime: json['creationTime'] as String?,
      roleNames: (json['roleNames'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$UserHisModelToJson(UserHisModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'name': instance.name,
      'surname': instance.surname,
      'emailAddress': instance.emailAddress,
      'isActive': instance.isActive,
      'fullName': instance.fullName,
      'lastLoginTime': instance.lastLoginTime,
      'creationTime': instance.creationTime,
      'roleNames': instance.roleNames,
    };
