import 'package:json_annotation/json_annotation.dart';
part 'time_slot.g.dart';

@JsonSerializable()
class TimeSlot {
  final String id;
  final String startAt; // ISO 8601
  final bool available;

  TimeSlot({required this.id, required this.startAt, required this.available});

  factory TimeSlot.fromJson(Map<String, dynamic> json) =>
      _$TimeSlotFromJson(json);
  Map<String, dynamic> toJson() => _$TimeSlotToJson(this);
}
