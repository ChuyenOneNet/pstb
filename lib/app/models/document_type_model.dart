import 'package:json_annotation/json_annotation.dart';

part 'document_type_model.g.dart';

@JsonSerializable()
class TypeDocumentModel {
  final String? id;
  final String? code;
  final String? name;
  final String? templateCode;
  final String? tableSearch;
  final bool? hasLastSign;
  final int? status;
  final int? signType;

  TypeDocumentModel({
    this.id,
    this.code,
    this.name,
    this.templateCode,
    this.tableSearch,
    this.hasLastSign,
    this.status,
    this.signType,
  });

  factory TypeDocumentModel.fromJson(Map<String, dynamic> json) =>
      _$TypeDocumentModelFromJson(json);

  Map<String, dynamic> toJson() => _$TypeDocumentModelToJson(this);
}
