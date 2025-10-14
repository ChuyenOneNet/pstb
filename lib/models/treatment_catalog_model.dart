import 'package:json_annotation/json_annotation.dart';

part 'treatment_catalog_model.g.dart';

@JsonSerializable()
class TreatmentCatalogModel {
  final String id;
  final String? code;
  final String? name;
  final int? price;
  final String? patientClassificationId;
  final String? patientClassificationName;

  TreatmentCatalogModel({
    required this.id,
    this.code,
    this.name,
    this.price,
    this.patientClassificationId,
    this.patientClassificationName,
  });

  /// Tạo từ JSON
  factory TreatmentCatalogModel.fromJson(Map<String, dynamic> json) =>
      _$TreatmentCatalogModelFromJson(json);

  /// Convert sang JSON
  Map<String, dynamic> toJson() => _$TreatmentCatalogModelToJson(this);
}
