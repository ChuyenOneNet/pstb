// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relative_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RelativeModel _$RelativeModelFromJson(Map<String, dynamic> json) =>
    RelativeModel(
      id: (json['id'] as num?)?.toInt(),
      mainCccd: json['mainCccd'] as String?,
      fullName: json['fullName'] as String,
      dob: json['dob'] as String,
      cccd: json['cccd'] as String,
      phone: json['phone'] as String,
      patientCode: json['patientCode'] as String,
      addressDetail: json['addressDetail'] as String?,
      city: json['city'] as String?,
      ward: json['ward'] as String?,
      ethnicity: json['ethnicity'] as String?,
      occupation: json['occupation'] as String?,
      country: json['country'] as String?,
      relationship: json['relationship'] as String?,
    );

Map<String, dynamic> _$RelativeModelToJson(RelativeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mainCccd': instance.mainCccd,
      'fullName': instance.fullName,
      'dob': instance.dob,
      'cccd': instance.cccd,
      'phone': instance.phone,
      'patientCode': instance.patientCode,
      'addressDetail': instance.addressDetail,
      'city': instance.city,
      'ward': instance.ward,
      'ethnicity': instance.ethnicity,
      'occupation': instance.occupation,
      'country': instance.country,
      'relationship': instance.relationship,
    };
