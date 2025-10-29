import 'package:json_annotation/json_annotation.dart';
part 'history_entry.g.dart';

@JsonSerializable()
class HistoryEntry {
  final String id;
  final String patientName;
  final String phone;
  final String serviceName;
  final String visitDateIso; // ISO
  final String visitTimeIso; // ISO
  final String branch;
  final String status; // pending/confirmed/...
  final String createdAtIso; // ISO

  HistoryEntry({
    required this.id,
    required this.patientName,
    required this.phone,
    required this.serviceName,
    required this.visitDateIso,
    required this.visitTimeIso,
    required this.branch,
    required this.status,
    required this.createdAtIso,
  });

  factory HistoryEntry.fromJson(Map<String, dynamic> json) =>
      _$HistoryEntryFromJson(json);
  Map<String, dynamic> toJson() => _$HistoryEntryToJson(this);
}
