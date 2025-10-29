import 'package:json_annotation/json_annotation.dart';
part 'lead_service.g.dart';

@JsonSerializable()
class LeadService {
  final String code;
  final String name;

  LeadService({required this.code, required this.name});

  factory LeadService.fromJson(Map<String, dynamic> json) =>
      _$LeadServiceFromJson(json);
  Map<String, dynamic> toJson() => _$LeadServiceToJson(this);
}
