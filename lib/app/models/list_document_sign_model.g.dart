// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_document_sign_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListResult<T> _$ListResultFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    ListResult<T>(
      totalCount: (json['totalCount'] as num?)?.toInt(),
      items: (json['items'] as List<dynamic>?)?.map(fromJsonT).toList(),
    );

Map<String, dynamic> _$ListResultToJson<T>(
  ListResult<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'totalCount': instance.totalCount,
      'items': instance.items?.map(toJsonT).toList(),
    };
