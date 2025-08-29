// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TypeDocumentModel _$TypeDocumentModelFromJson(Map<String, dynamic> json) =>
    TypeDocumentModel(
      id: json['id'] as String?,
      code: json['code'] as String?,
      name: json['name'] as String?,
      templateCode: json['templateCode'] as String?,
      tableSearch: json['tableSearch'] as String?,
      hasLastSign: json['hasLastSign'] as bool?,
      status: (json['status'] as num?)?.toInt(),
      signType: (json['signType'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TypeDocumentModelToJson(TypeDocumentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'templateCode': instance.templateCode,
      'tableSearch': instance.tableSearch,
      'hasLastSign': instance.hasLastSign,
      'status': instance.status,
      'signType': instance.signType,
    };
