// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_document_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailDocumentModel _$DetailDocumentModelFromJson(Map<String, dynamic> json) =>
    DetailDocumentModel(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      result: json['result'] as String?,
      viewData: json['viewData'] as String?,
    );

Map<String, dynamic> _$DetailDocumentModelToJson(
        DetailDocumentModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'result': instance.result,
      'viewData': instance.viewData,
    };
