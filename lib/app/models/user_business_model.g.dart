// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_business_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserBusinessModel _$UserBusinessModelFromJson(Map<String, dynamic> json) =>
    UserBusinessModel(
      id: json['id'] as String?,
      ma: json['ma'] as String?,
      hoTen: json['hoTen'] as String?,
      gioiTinh: (json['gioiTinh'] as num?)?.toInt(),
      ngaySinh: json['ngaySinh'] as String?,
      ngaySinhText: json['ngaySinhText'] as String?,
      diaChiLienHe: json['diaChiLienHe'] as String?,
      dienThoai: json['dienThoai'] as String?,
      passWord: json['passWord'] as String?,
      passWordDefault: json['passWordDefault'] as String?,
      lastTimeUpdate: json['lastTimeUpdate'] as String?,
      soCmt: json['soCmt'] as String?,
      thuDienTu: json['thuDienTu'] as String?,
      tuoi: json['tuoi'] as String?,
      maTheBHYT: json['maTheBHYT'] as String?,
      diaChiHanhChinhId: json['diaChiHanhChinh_ID'] as String?,
    );

Map<String, dynamic> _$UserBusinessModelToJson(UserBusinessModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ma': instance.ma,
      'hoTen': instance.hoTen,
      'gioiTinh': instance.gioiTinh,
      'ngaySinh': instance.ngaySinh,
      'ngaySinhText': instance.ngaySinhText,
      'diaChiLienHe': instance.diaChiLienHe,
      'dienThoai': instance.dienThoai,
      'passWord': instance.passWord,
      'passWordDefault': instance.passWordDefault,
      'lastTimeUpdate': instance.lastTimeUpdate,
      'soCmt': instance.soCmt,
      'thuDienTu': instance.thuDienTu,
      'tuoi': instance.tuoi,
      'maTheBHYT': instance.maTheBHYT,
      'diaChiHanhChinh_ID': instance.diaChiHanhChinhId,
    };
