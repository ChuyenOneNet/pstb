import 'package:freezed_annotation/freezed_annotation.dart';

import '../../services/api_response.dart';

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

@JsonSerializable(genericArgumentFactories: true)
class StatusDataResponse<T> {
  @JsonKey(name: 'status')
  final bool? status;

  @JsonKey(name: 'data')
  final T? data;

  @JsonKey(name: 'errors')
  final List<ApiError>? errors;

  StatusDataResponse({this.status, this.data, this.errors});

  factory StatusDataResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$StatusDataResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$StatusDataResponseToJson(this, toJsonT);

  bool get ok => status == true;
  String get errorMessage => (errors != null && errors!.isNotEmpty)
      ? (errors!.first.message ?? '')
      : 'Unknown error';
}

@JsonSerializable(genericArgumentFactories: true, explicitToJson: true)
class StatusListResponse<T> {
  @JsonKey(name: 'status')
  final bool? status;

  /// Danh sách phần tử kiểu T; có thể null nếu lỗi.
  @JsonKey(name: 'data')
  final List<T>? data;

  @JsonKey(name: 'errors')
  final List<ApiError>? errors;

  const StatusListResponse({
    this.status,
    this.data,
    this.errors,
  });

  factory StatusListResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$StatusListResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(
    Object? Function(T value) toJsonT,
  ) =>
      _$StatusListResponseToJson(this, toJsonT);

  /// Tiện kiểm tra OK
  bool get ok => status == true && data != null;

  /// Lấy thông điệp lỗi đầu tiên (nếu có), fallback mặc định
  String get errorMessage => (errors != null && errors!.isNotEmpty)
      ? (errors!.first.message ?? '')
      : 'Unknown error';
}

@JsonSerializable(genericArgumentFactories: true, explicitToJson: true)
class StatusListResponseV2<T> {
  @JsonKey(name: 'status')
  final int? status;

  /// Danh sách phần tử kiểu T; có thể null nếu lỗi.
  @JsonKey(name: 'data')
  final List<T>? data;

  @JsonKey(name: 'errors')
  final String? errors;

  const StatusListResponseV2({
    this.status,
    this.data,
    this.errors,
  });

  factory StatusListResponseV2.fromJson(
      Map<String, dynamic> json,
      T Function(Object? json) fromJsonT,
      ) =>
      _$StatusListResponseV2FromJson(json, fromJsonT);

  Map<String, dynamic> toJson(
      Object? Function(T value) toJsonT,
      ) =>
      _$StatusListResponseV2ToJson(this, toJsonT);

  /// Tiện kiểm tra OK
  bool get ok => status == 200 && data != null;

  /// Lấy thông điệp lỗi đầu tiên (nếu có), fallback mặc định
  String get errorMessage => (errors != null && errors!.isNotEmpty)
      ? (errors ?? '')
      : 'Unknown error';
}