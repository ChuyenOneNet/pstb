// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse<T> _$BaseResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    BaseResponse<T>(
      isError: json['IsError'] as bool?,
      message: json['Message'] as String?,
      data: _$nullableGenericFromJson(json['result'], fromJsonT),
    );

Map<String, dynamic> _$BaseResponseToJson<T>(
  BaseResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'IsError': instance.isError,
      'Message': instance.message,
      'result': _$nullableGenericToJson(instance.data, toJsonT),
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);

BaseListResponse<T> _$BaseListResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    BaseListResponse<T>(
      data: (json['data'] as List<dynamic>?)?.map(fromJsonT).toList(),
      total: (json['Total'] as num?)?.toInt(),
      isError: json['IsError'] as bool?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$BaseListResponseToJson<T>(
  BaseListResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'data': instance.data?.map(toJsonT).toList(),
      'Total': instance.total,
      'IsError': instance.isError,
      'message': instance.message,
    };

StatusDataResponse<T> _$StatusDataResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    StatusDataResponse<T>(
      status: json['status'] as bool?,
      data: _$nullableGenericFromJson(json['data'], fromJsonT),
      errors: (json['errors'] as List<dynamic>?)
          ?.map((e) => ApiError.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StatusDataResponseToJson<T>(
  StatusDataResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'status': instance.status,
      'data': _$nullableGenericToJson(instance.data, toJsonT),
      'errors': instance.errors,
    };

StatusListResponse<T> _$StatusListResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    StatusListResponse<T>(
      status: json['status'] as bool?,
      data: (json['data'] as List<dynamic>?)?.map(fromJsonT).toList(),
      errors: (json['errors'] as List<dynamic>?)
          ?.map((e) => ApiError.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StatusListResponseToJson<T>(
  StatusListResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data?.map(toJsonT).toList(),
      'errors': instance.errors?.map((e) => e.toJson()).toList(),
    };

StatusListResponseV2<T> _$StatusListResponseV2FromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    StatusListResponseV2<T>(
      status: (json['status'] as num?)?.toInt(),
      data: (json['data'] as List<dynamic>?)?.map(fromJsonT).toList(),
      errors: json['errors'] as String?,
    );

Map<String, dynamic> _$StatusListResponseV2ToJson<T>(
  StatusListResponseV2<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data?.map(toJsonT).toList(),
      'errors': instance.errors,
    };
