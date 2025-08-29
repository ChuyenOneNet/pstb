import 'package:json_annotation/json_annotation.dart';

part 'create_request_response.g.dart';

@JsonSerializable()
class CreateRequestResponse {
  final String requestId;
  final String pdfBase64;
  final String createdAt;
  final String patientName;
  final String examTypeName;
  final String roomName;

  CreateRequestResponse({
    required this.requestId,
    required this.pdfBase64,
    required this.createdAt,
    required this.patientName,
    required this.examTypeName,
    required this.roomName,
  });

  factory CreateRequestResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateRequestResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateRequestResponseToJson(this);
}
