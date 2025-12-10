// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lead_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeadService _$LeadServiceFromJson(Map<String, dynamic> json) => LeadService(
      code: json['service_code'] as String,
      name: json['servicename'] as String,
    );

Map<String, dynamic> _$LeadServiceToJson(LeadService instance) =>
    <String, dynamic>{
      'service_code': instance.code,
      'servicename': instance.name,
    };
