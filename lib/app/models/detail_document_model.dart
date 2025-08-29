import 'package:json_annotation/json_annotation.dart';

part 'detail_document_model.g.dart';

@JsonSerializable()
class DetailDocumentModel {
  @JsonKey(name: 'status')
  final int? status;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'result')
  final String? result;

  @JsonKey(name: 'viewData')
  final String? viewData;

  DetailDocumentModel({
    this.status,
    this.message,
    this.result,
    this.viewData,
  });

  factory DetailDocumentModel.fromJson(Map<String, dynamic> json) =>
      _$DetailDocumentModelFromJson(json);

  Map<String, dynamic> toJson() => _$DetailDocumentModelToJson(this);
}
