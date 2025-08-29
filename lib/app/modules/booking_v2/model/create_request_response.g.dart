// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_request_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateRequestResponse _$CreateRequestResponseFromJson(
        Map<String, dynamic> json) =>
    CreateRequestResponse(
      requestId: json['requestId'] as String,
      pdfBase64: json['pdfBase64'] as String,
      createdAt: json['createdAt'] as String,
      patientName: json['patientName'] as String,
      examTypeName: json['examTypeName'] as String,
      roomName: json['roomName'] as String,
    );

Map<String, dynamic> _$CreateRequestResponseToJson(
        CreateRequestResponse instance) =>
    <String, dynamic>{
      'requestId': instance.requestId,
      'pdfBase64': instance.pdfBase64,
      'createdAt': instance.createdAt,
      'patientName': instance.patientName,
      'examTypeName': instance.examTypeName,
      'roomName': instance.roomName,
    };
