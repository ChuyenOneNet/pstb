// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusinessModel _$BusinessModelFromJson(Map<String, dynamic> json) =>
    BusinessModel(
      id: json['id'] as String,
      malk: json['malk'] as String?,
      lyDoVaoVien: json['lyDoVaoVien'] as String?,
      phanLoai: (json['phanLoai'] as num?)?.toInt(),
      dateModified: json['dateModified'] as String?,
      benhNhanId: json['benhNhanId'] as String?,
      thoiGianVao: json['thoiGianVao'] as String?,
      vao: json['vao'] as String?,
      thoiGianRa: json['thoiGianRa'] as String?,
      ra: json['ra'] as String?,
      khamChuaBenhs: (json['khamChuaBenhs'] as List<dynamic>?)
              ?.map(
                  (e) => KhamChuaBenhModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$BusinessModelToJson(BusinessModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'benhNhanId': instance.benhNhanId,
      'malk': instance.malk,
      'lyDoVaoVien': instance.lyDoVaoVien,
      'phanLoai': instance.phanLoai,
      'thoiGianVao': instance.thoiGianVao,
      'vao': instance.vao,
      'thoiGianRa': instance.thoiGianRa,
      'ra': instance.ra,
      'dateModified': instance.dateModified,
      'khamChuaBenhs': instance.khamChuaBenhs,
    };
