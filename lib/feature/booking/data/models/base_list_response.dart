import 'package:json_annotation/json_annotation.dart';
part 'base_list_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BaseListResponse<T> {
  final int success;
  final List<T>? entry_list;

  BaseListResponse({required this.success, this.entry_list});

  factory BaseListResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json)
        fromJsonT, // <-- sửa Object? thay vì Map<String,dynamic>
  ) =>
      _$BaseListResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T) toJsonT) =>
      _$BaseListResponseToJson(this, toJsonT);
}
