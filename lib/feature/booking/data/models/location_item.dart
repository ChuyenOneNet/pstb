import 'package:json_annotation/json_annotation.dart';
part 'location_item.g.dart';

@JsonSerializable()
class LocationItem {
  final String id;
  final String name;

  const LocationItem({
    required this.id,
    required this.name,
  });

  factory LocationItem.fromJson(Map<String, dynamic> json) =>
      _$LocationItemFromJson(json);
  Map<String, dynamic> toJson() => _$LocationItemToJson(this);
}
