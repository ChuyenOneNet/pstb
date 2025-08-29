// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_signed_model_v2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignedDocumentModelV2 _$SignedDocumentModelV2FromJson(
        Map<String, dynamic> json) =>
    SignedDocumentModelV2(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      result: json['result'] as String?,
      originFileId: json['OriginFileId'] as String?,
      signedFileId: json['SignedFileId'] as String?,
      viewData: json['ViewData'] as String?,
      signedInfoDto: json['SignedInfoDto'] == null
          ? null
          : SignedInfoDto.fromJson(
              json['SignedInfoDto'] as Map<String, dynamic>),
      createVersion: json['CreateVersion'] as bool?,
      signTime: json['SignTime'] as String?,
    );

Map<String, dynamic> _$SignedDocumentModelV2ToJson(
        SignedDocumentModelV2 instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'result': instance.result,
      'OriginFileId': instance.originFileId,
      'SignedFileId': instance.signedFileId,
      'ViewData': instance.viewData,
      'SignedInfoDto': instance.signedInfoDto,
      'CreateVersion': instance.createVersion,
      'SignTime': instance.signTime,
    };

SignedInfoDto _$SignedInfoDtoFromJson(Map<String, dynamic> json) =>
    SignedInfoDto(
      signerCode: json['signerCode'] as String?,
      signerName: json['signerName'] as String?,
      signedTime: json['signedTime'] as String?,
    );

Map<String, dynamic> _$SignedInfoDtoToJson(SignedInfoDto instance) =>
    <String, dynamic>{
      'signerCode': instance.signerCode,
      'signerName': instance.signerName,
      'signedTime': instance.signedTime,
    };
