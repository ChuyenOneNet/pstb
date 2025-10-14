import 'package:json_annotation/json_annotation.dart';

part 'treatment_catalog_department_model.g.dart';

@JsonSerializable()
class TreatmentCatalogDepartmentModel {
  final String id;
  final String? code;
  final String? name;
  TreatmentCatalogDepartmentModel({
    required this.id,
    this.code,
    this.name,
  });

  /// Tạo từ JSON
  factory TreatmentCatalogDepartmentModel.fromJson(Map<String, dynamic> json) =>
      _$TreatmentCatalogDepartmentModelFromJson(json);

  /// Convert sang JSON
  Map<String, dynamic> toJson() =>
      _$TreatmentCatalogDepartmentModelToJson(this);
}
