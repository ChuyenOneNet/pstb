import 'package:json_annotation/json_annotation.dart';

part 'list_document_sign_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ListResult<T> {
  final int? totalCount;
  final List<T>? items;

  ListResult({
    this.totalCount,
    this.items,
  });

  factory ListResult.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$ListResultFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(
    Object Function(T value) toJsonT,
  ) =>
      _$ListResultToJson(this, toJsonT);
}
