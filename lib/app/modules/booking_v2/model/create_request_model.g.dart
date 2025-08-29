// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateRequestModel _$CreateRequestModelFromJson(Map<String, dynamic> json) =>
    CreateRequestModel(
      name: json['name'] as String,
      cccd: json['identificationCode'] as String,
      age: (json['age'] as num).toInt(),
      gender: (json['gender'] as num).toInt(),
      birthDate: json['dateOfBirth'] as String,
      job: json['jobId'] as String,
      address: json['addressId'] as String,
      addressDetail: json['addressDetail'] as String,
      phone: json['phoneNumber'] as String,
      fatherName: json['fatherName'] as String,
      motherName: json['motherName'] as String,
      idIssueDate: json['dateOfIssueIdentificationCode'] as String,
      idIssuePlace: json['placeOfIssueIdentificationCode'] as String?,
      nationality: json['nationality'] as String?,
      examTypeName: json['examTypeName'] as String?,
      nationalId: json['nationalId'] as String,
      scheduledAt: json['scheduleAt'] as String,
      ethnic: json['ethnicId'] as String,
      examTypeId: json['examTypeId'] as String,
      clinicRoomCode: json['clinicRoomCode'] as String?,
      clinicRoomName: json['clinicRoomName'] as String?,
      reason: json['reason'] as String,
      priority: json['priority'] as String,
      arrivalMethod: json['arrivalMetod'] as String,
      hasInsurance: json['hasInsurance'] as bool? ?? false,
      pathPdf: json['pathPdf'] as String?,
    );

Map<String, dynamic> _$CreateRequestModelToJson(CreateRequestModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'identificationCode': instance.cccd,
      'age': instance.age,
      'gender': instance.gender,
      'dateOfBirth': instance.birthDate,
      'jobId': instance.job,
      'addressId': instance.address,
      'addressDetail': instance.addressDetail,
      'phoneNumber': instance.phone,
      'fatherName': instance.fatherName,
      'motherName': instance.motherName,
      'dateOfIssueIdentificationCode': instance.idIssueDate,
      'placeOfIssueIdentificationCode': instance.idIssuePlace,
      'nationalId': instance.nationalId,
      'nationality': instance.nationality,
      'ethnicId': instance.ethnic,
      'examTypeId': instance.examTypeId,
      'examTypeName': instance.examTypeName,
      'clinicRoomCode': instance.clinicRoomCode,
      'clinicRoomName': instance.clinicRoomName,
      'reason': instance.reason,
      'priority': instance.priority,
      'arrivalMetod': instance.arrivalMethod,
      'scheduleAt': instance.scheduledAt,
      'hasInsurance': instance.hasInsurance,
      'pathPdf': instance.pathPdf,
    };
