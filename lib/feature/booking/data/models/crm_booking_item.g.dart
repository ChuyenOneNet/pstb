// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crm_booking_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CrmBookingItem _$CrmBookingItemFromJson(Map<String, dynamic> json) =>
    CrmBookingItem(
      id: json['id'] as String?,
      cpbookingid: json['cpbookingid'] as String?,
      cpbooking_no: json['cpbooking_no'] as String?,
      cpbooking_status: json['cpbooking_status'] as String?,
      cpbooking_remind_status: json['cpbooking_remind_status'] as String?,
      sync_his_status: json['sync_his_status'] as String?,
      related_contact: json['related_contact'] as String?,
      related_contact_label: json['related_contact_label'] as String?,
      related_contactmobile: json['related_contactmobile'] as String?,
      related_contactidentification_number:
          json['related_contactidentification_number'] as String?,
      related_contactbirthday: json['related_contactbirthday'] as String?,
      start_day: json['start_day'] as String?,
      start_time: json['start_time'] as String?,
      cpbooking_shift: json['cpbooking_shift'] as String?,
      related_cpspecialtycategory:
          json['related_cpspecialtycategory'] as String?,
      related_cpspecialtycategory_label:
          json['related_cpspecialtycategory_label'] as String?,
      note: json['note'] as String?,
      cpbooking_source: json['cpbooking_source'] as String?,
      main_owner_id: json['main_owner_id'] as String?,
      main_owner_name: json['main_owner_name'] as String?,
      assigned_owners: json['assigned_owners'] as List<dynamic>?,
      createdtime: json['createdtime'] as String?,
      modifiedtime: json['modifiedtime'] as String?,
      patient_name: json['patient_name'] as String?,
      patientName: json['patientName'] as String?,
      firstname: json['firstname'] as String?,
      last_name: json['last_name'] as String?,
      service_name: json['service_name'] as String?,
      serviceName: json['serviceName'] as String?,
      leads_interest_service: json['leads_interest_service'] as String?,
      branch: json['branch'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$CrmBookingItemToJson(CrmBookingItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cpbookingid': instance.cpbookingid,
      'cpbooking_no': instance.cpbooking_no,
      'cpbooking_status': instance.cpbooking_status,
      'cpbooking_remind_status': instance.cpbooking_remind_status,
      'sync_his_status': instance.sync_his_status,
      'related_contact': instance.related_contact,
      'related_contact_label': instance.related_contact_label,
      'related_contactmobile': instance.related_contactmobile,
      'related_contactidentification_number':
          instance.related_contactidentification_number,
      'related_contactbirthday': instance.related_contactbirthday,
      'start_day': instance.start_day,
      'start_time': instance.start_time,
      'cpbooking_shift': instance.cpbooking_shift,
      'related_cpspecialtycategory': instance.related_cpspecialtycategory,
      'related_cpspecialtycategory_label':
          instance.related_cpspecialtycategory_label,
      'note': instance.note,
      'cpbooking_source': instance.cpbooking_source,
      'main_owner_id': instance.main_owner_id,
      'main_owner_name': instance.main_owner_name,
      'assigned_owners': instance.assigned_owners,
      'createdtime': instance.createdtime,
      'modifiedtime': instance.modifiedtime,
      'patient_name': instance.patient_name,
      'patientName': instance.patientName,
      'firstname': instance.firstname,
      'last_name': instance.last_name,
      'service_name': instance.service_name,
      'serviceName': instance.serviceName,
      'leads_interest_service': instance.leads_interest_service,
      'branch': instance.branch,
      'status': instance.status,
    };
