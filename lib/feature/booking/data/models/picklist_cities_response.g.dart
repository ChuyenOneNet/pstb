// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'picklist_cities_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PicklistCitiesResponse _$PicklistCitiesResponseFromJson(
        Map<String, dynamic> json) =>
    PicklistCitiesResponse(
      success: PicklistCitiesResponse._successFromJson(json['success']),
      picklistOptions: (json['picklist_options'] as List<dynamic>?)
              ?.map((e) => MailingCityItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$PicklistCitiesResponseToJson(
        PicklistCitiesResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'picklist_options': instance.picklistOptions,
    };

MailingCityItem _$MailingCityItemFromJson(Map<String, dynamic> json) =>
    MailingCityItem(
      key: json['key'] as String,
      label: json['label'] as String,
      value: json['value'] as String?,
    );

Map<String, dynamic> _$MailingCityItemToJson(MailingCityItem instance) =>
    <String, dynamic>{
      'key': instance.key,
      'label': instance.label,
      'value': instance.value,
    };
