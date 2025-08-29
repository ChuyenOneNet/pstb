// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clinic_room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClinicRoom _$ClinicRoomFromJson(Map<String, dynamic> json) => ClinicRoom(
      id: json['ID'] as String,
      code: json['MA'] as String,
      name: json['TEN'] as String,
      note: json['GHICHU'] as String,
      departmentId: json['DEPARTMENT_ID'] as String,
      order: (json['STT'] as num).toInt(),
      active: (json['HIEULUC'] as num).toInt(),
      specialtyId: json['CHUYENKHOA_ID'] as String,
      requestType: (json['CHUYENYEUCAU'] as num).toInt(),
    );

Map<String, dynamic> _$ClinicRoomToJson(ClinicRoom instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'MA': instance.code,
      'TEN': instance.name,
      'GHICHU': instance.note,
      'DEPARTMENT_ID': instance.departmentId,
      'STT': instance.order,
      'HIEULUC': instance.active,
      'CHUYENKHOA_ID': instance.specialtyId,
      'CHUYENYEUCAU': instance.requestType,
    };
