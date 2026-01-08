// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'picklist_states_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PicklistStatesResponse _$PicklistStatesResponseFromJson(
        Map<String, dynamic> json) =>
    PicklistStatesResponse(
      success: PicklistStatesResponse._successFromJson(json['success']),
      picklistOptions: (json['picklist_options'] as List<dynamic>?)
              ?.map((e) => MailingStateItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$PicklistStatesResponseToJson(
        PicklistStatesResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'picklist_options': instance.picklistOptions,
    };

MailingStateItem _$MailingStateItemFromJson(Map<String, dynamic> json) =>
    MailingStateItem(
      mailingstate: json['mailingstate'] as String,
      mailingstateId: json['mailingstateid'] as String?,
      label: json['label'] as String?,
      mailingstateLabel: json['mailingstate_label'] as String?,
    );

Map<String, dynamic> _$MailingStateItemToJson(MailingStateItem instance) =>
    <String, dynamic>{
      'mailingstate': instance.mailingstate,
      'mailingstateid': instance.mailingstateId,
      'label': instance.label,
      'mailingstate_label': instance.mailingstateLabel,
    };
