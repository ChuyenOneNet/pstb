import 'package:json_annotation/json_annotation.dart';
part 'crm_booking_response.g.dart';

@JsonSerializable()
class CrmBookingResponse {
  final bool? success;
  final String? message;
  final String? id; // có thể không có

  CrmBookingResponse({this.success, this.message, this.id});

  factory CrmBookingResponse.fromJson(Map<String, dynamic> json) =>
      _$CrmBookingResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CrmBookingResponseToJson(this);
}
