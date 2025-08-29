// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusinessModel _$BusinessModelFromJson(Map<String, dynamic> json) =>
    BusinessModel(
      id: json['id'] as String,
      key: json['key'] as String?,
      dangKyId: json['dangKyId'] as String?,
      benhNhanId: json['benhNhanId'] as String?,
      xuTriType: (json['xuTriType'] as num).toInt(),
      xuTriContent: json['xuTriContent'] as String?,
      thoiGianVao: json['thoiGianVao'] as String?,
      vao: json['vao'] as String?,
      thoiGianRa: json['thoiGianRa'] as String?,
      ra: json['ra'] as String?,
      icdId: json['icdId'] as String?,
      moTaIcd: json['moTaIcd'] as String?,
      chanDoanPhanBiet: json['chanDoanPhanBiet'] as String?,
      benhKemTheo: json['benhKemTheo'] as String?,
      loai: (json['loai'] as num).toInt(),
      sinhHieuChamSocDto: json['sinhHieuChamSocDto'],
    );

Map<String, dynamic> _$BusinessModelToJson(BusinessModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'key': instance.key,
      'dangKyId': instance.dangKyId,
      'benhNhanId': instance.benhNhanId,
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
      'sinhHieuChamSocDto': instance.sinhHieuChamSocDto,
    };
