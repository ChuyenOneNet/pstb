// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kham_chua_benh_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KhamChuaBenhModel _$KhamChuaBenhModelFromJson(Map<String, dynamic> json) =>
    KhamChuaBenhModel(
      id: json['id'] as String,
      key: json['key'] as String?,
      dangKyId: json['dangKyId'] as String?,
      benhNhanId: json['benhNhanId'] as String?,
      trangThai: (json['trangThai'] as num?)?.toInt(),
      xuTriType: (json['xuTriType'] as num?)?.toInt(),
      xuTriContent: json['xuTriContent'] as String?,
      thoiGianVao: json['thoiGianVao'] as String?,
      vao: json['vao'] as String?,
      thoiGianRa: json['thoiGianRa'] as String?,
      ra: json['ra'] as String?,
      icdId: json['icdId'] as String?,
      moTaIcd: json['moTaIcd'] as String?,
      chanDoanPhanBiet: json['chanDoanPhanBiet'] as String?,
      benhKemTheo: json['benhKemTheo'] as String?,
      loai: (json['loai'] as num?)?.toInt(),
      dateModified: json['dateModified'] as String?,
      sinhHieuChamSocDto: json['sinhHieuChamSocDto'],
    );

Map<String, dynamic> _$KhamChuaBenhModelToJson(KhamChuaBenhModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'key': instance.key,
      'dangKyId': instance.dangKyId,
      'benhNhanId': instance.benhNhanId,
      'trangThai': instance.trangThai,
      'xuTriType': instance.xuTriType,
      'xuTriContent': instance.xuTriContent,
      'thoiGianVao': instance.thoiGianVao,
      'vao': instance.vao,
      'thoiGianRa': instance.thoiGianRa,
      'ra': instance.ra,
      'icdId': instance.icdId,
      'moTaIcd': instance.moTaIcd,
      'chanDoanPhanBiet': instance.chanDoanPhanBiet,
      'benhKemTheo': instance.benhKemTheo,
      'loai': instance.loai,
      'dateModified': instance.dateModified,
      'sinhHieuChamSocDto': instance.sinhHieuChamSocDto,
    };
