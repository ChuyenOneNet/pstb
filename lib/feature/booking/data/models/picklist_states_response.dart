import 'package:json_annotation/json_annotation.dart';

part 'picklist_states_response.g.dart';

@JsonSerializable()
class PicklistStatesResponse {
  @JsonKey(fromJson: _successFromJson)
  final bool success;

  @JsonKey(name: 'picklist_options', defaultValue: <MailingStateItem>[])
  final List<MailingStateItem> picklistOptions;

  const PicklistStatesResponse({
    required this.success,
    required this.picklistOptions,
  });

  factory PicklistStatesResponse.fromJson(Map<String, dynamic> json) =>
      _$PicklistStatesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PicklistStatesResponseToJson(this);

  static bool _successFromJson(dynamic v) {
    if (v is bool) return v;
    if (v is num) return v == 1;
    if (v is String) return v.trim() == '1' || v.trim().toLowerCase() == 'true';
    return false;
  }
}

@JsonSerializable()
class MailingStateItem {
  // Backend hiện tại trả mailingstate = UUID -> bạn muốn dùng để submit
  @JsonKey(name: 'mailingstate')
  final String mailingstate;

  @JsonKey(name: 'mailingstateid')
  final String? mailingstateId;

  // backend đang bổ sung label; mình cho sẵn 2 khả năng
  final String? label;

  @JsonKey(name: 'mailingstate_label')
  final String? mailingstateLabel;

  const MailingStateItem({
    required this.mailingstate,
    this.mailingstateId,
    this.label,
    this.mailingstateLabel,
  });

  String get displayLabel =>
      (label ?? mailingstateLabel ?? mailingstateId ?? mailingstate).trim();

  factory MailingStateItem.fromJson(Map<String, dynamic> json) =>
      _$MailingStateItemFromJson(json);

  Map<String, dynamic> toJson() => _$MailingStateItemToJson(this);
}
