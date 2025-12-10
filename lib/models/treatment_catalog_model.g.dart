// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'treatment_catalog_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TreatmentCatalogModel _$TreatmentCatalogModelFromJson(
        Map<String, dynamic> json) =>
    TreatmentCatalogModel(
      id: json['id'] as String,
      code: json['code'] as String?,
      name: json['name'] as String?,
      price: (json['price'] as num?)?.toInt(),
      patientClassificationId: json['patientClassificationId'] as String?,
      patientClassificationName: json['patientClassificationName'] as String?,
    );

Map<String, dynamic> _$TreatmentCatalogModelToJson(
        TreatmentCatalogModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'price': instance.price,
      'patientClassificationId': instance.patientClassificationId,
      'patientClassificationName': instance.patientClassificationName,
    };
