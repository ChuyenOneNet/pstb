// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'electronic_signature_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentModel _$DocumentModelFromJson(Map<String, dynamic> json) =>
    DocumentModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      signingStatus:
          DocumentModel._signingStatusFromJson(json['signingStatus']),
      patientName: json['patientName'] as String?,
      createdDate: json['createdDate'] as String?,
      signedDate: json['signedDate'] as String?,
      documentTypeCode: json['documentTypeCode'] as String?,
      documentTypeName: json['documentTypeName'] as String?,
    )..departmentName = json['departmentName'] as String?;

Map<String, dynamic> _$DocumentModelToJson(DocumentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'signingStatus':
          DocumentModel._signingStatusToJson(instance.signingStatus),
      'createdDate': instance.createdDate,
      'signedDate': instance.signedDate,
      'patientName': instance.patientName,
      'departmentName': instance.departmentName,
      'documentTypeCode': instance.documentTypeCode,
      'documentTypeName': instance.documentTypeName,
    };
