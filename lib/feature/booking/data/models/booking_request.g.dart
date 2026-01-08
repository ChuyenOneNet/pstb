// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingRequest _$BookingRequestFromJson(Map<String, dynamic> json) =>
    BookingRequest(
      access_key: json['access_key'] as String,
      simple_params: json['simple_params'] as String,
      input_source: json['input_source'] as String,
      data: BookingData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BookingRequestToJson(BookingRequest instance) =>
    <String, dynamic>{
      'access_key': instance.access_key,
      'simple_params': instance.simple_params,
      'input_source': instance.input_source,
      'data': instance.data.toJson(),
    };

BookingData _$BookingDataFromJson(Map<String, dynamic> json) => BookingData(
      firstname: json['firstname'] as String,
      mobile: json['mobile'] as String,
      email: json['email'] as String,
      leads_interest_service: json['leads_interest_service'] as String,
      identification_number: json['identification_number'] as String,
      identity_card_issue_date: json['identity_card_issue_date'] as String,
      branch: json['branch'] as String,
      start_day: json['start_day'] as String,
      start_time: (json['start_time'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      note: json['note'] as String,
      source_description: json['source_description'] as String,
      cf_related_contact__identification_number:
          json['cf_related_contact__identification_number'] as String,
      mailingcity: json['mailingcity'] as String,
      mailingstate: json['mailingstate'] as String,
      mailingstreet: json['mailingstreet'] as String,
    );

Map<String, dynamic> _$BookingDataToJson(BookingData instance) =>
    <String, dynamic>{
      'firstname': instance.firstname,
      'mobile': instance.mobile,
      'email': instance.email,
      'leads_interest_service': instance.leads_interest_service,
      'identification_number': instance.identification_number,
      'identity_card_issue_date': instance.identity_card_issue_date,
      'branch': instance.branch,
      'start_day': instance.start_day,
      'start_time': instance.start_time,
      'note': instance.note,
      'source_description': instance.source_description,
      'cf_related_contact__identification_number':
          instance.cf_related_contact__identification_number,
      'mailingcity': instance.mailingcity,
      'mailingstate': instance.mailingstate,
      'mailingstreet': instance.mailingstreet,
    };
