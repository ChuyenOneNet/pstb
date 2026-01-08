import 'package:json_annotation/json_annotation.dart';

part 'picklist_cities_response.g.dart';

@JsonSerializable()
class PicklistCitiesResponse {
  @JsonKey(fromJson: _successFromJson)
  final bool success;

  @JsonKey(name: 'picklist_options', defaultValue: <MailingCityItem>[])
  final List<MailingCityItem> picklistOptions;

  const PicklistCitiesResponse({
    required this.success,
    required this.picklistOptions,
  });

  factory PicklistCitiesResponse.fromJson(Map<String, dynamic> json) =>
      _$PicklistCitiesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PicklistCitiesResponseToJson(this);

  static bool _successFromJson(dynamic v) {
    if (v is bool) return v;
    if (v is num) return v == 1;
    if (v is String) return v.trim() == '1' || v.trim().toLowerCase() == 'true';
    return false;
  }
}

@JsonSerializable()
class MailingCityItem {
  // API trả "key" là UUID -> cái này bạn muốn dùng để submit
  final String key;

  // API trả "label" là tên tỉnh/TP để hiển thị
  final String label;

  // có thể có "value" (thường trùng key) nhưng không bắt buộc
  final String? value;

  const MailingCityItem({
    required this.key,
    required this.label,
    this.value,
  });

  factory MailingCityItem.fromJson(Map<String, dynamic> json) =>
      _$MailingCityItemFromJson(json);

  Map<String, dynamic> toJson() => _$MailingCityItemToJson(this);
}
