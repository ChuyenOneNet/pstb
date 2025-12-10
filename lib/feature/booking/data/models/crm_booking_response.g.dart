// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crm_booking_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CrmBookingResponse _$CrmBookingResponseFromJson(Map<String, dynamic> json) =>
    CrmBookingResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$CrmBookingResponseToJson(CrmBookingResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'id': instance.id,
    };
