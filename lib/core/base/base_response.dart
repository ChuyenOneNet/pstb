import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BaseResponse<T> {
  @JsonKey(name: 'IsError')
  final bool? isError;

  @JsonKey(name: 'Message')
  final String? message;

  @JsonKey(name: 'result')
  final T? data;

  BaseResponse({
    required this.isError,
    this.message,
    this.data,
  });

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$BaseResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$BaseResponseToJson(this, toJsonT);
}

@JsonSerializable(
  genericArgumentFactories: true,
)
class BaseListResponse<T> {
  @JsonKey(name: 'data')
  final List<T>? data;

  @JsonKey(name: 'Total')
  final int? total;

  @JsonKey(name: 'IsError')
  final bool? isError;

  @JsonKey(name: 'message')
  final String? message;

  BaseListResponse({
    this.data,
    this.total,
    this.isError,
    this.message,
  });

  factory BaseListResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$BaseListResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$BaseListResponseToJson(this, toJsonT);
}
