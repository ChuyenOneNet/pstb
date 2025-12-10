// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryEntry _$HistoryEntryFromJson(Map<String, dynamic> json) => HistoryEntry(
      id: json['id'] as String,
      patientName: json['patientName'] as String,
      phone: json['phone'] as String,
      serviceName: json['serviceName'] as String,
      visitDateIso: json['visitDateIso'] as String,
      visitTimeIso: json['visitTimeIso'] as String,
      branch: json['branch'] as String,
      status: json['status'] as String,
      createdAtIso: json['createdAtIso'] as String,
    );

Map<String, dynamic> _$HistoryEntryToJson(HistoryEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'patientName': instance.patientName,
      'phone': instance.phone,
      'serviceName': instance.serviceName,
      'visitDateIso': instance.visitDateIso,
      'visitTimeIso': instance.visitTimeIso,
      'branch': instance.branch,
      'status': instance.status,
      'createdAtIso': instance.createdAtIso,
    };
