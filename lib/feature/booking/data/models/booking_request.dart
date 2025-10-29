import 'package:json_annotation/json_annotation.dart';
part 'booking_request.g.dart';

@JsonSerializable(explicitToJson: true)
class BookingRequest {
  final String access_key; // "TXEjpPNBINpFYD70"
  final String simple_params; // "0"
  final String input_source; // "APP MOBILE" / "LADIPAGE"
  final BookingData data;

  BookingRequest({
    required this.access_key,
    required this.simple_params,
    required this.input_source,
    required this.data,
  });

  factory BookingRequest.fromJson(Map<String, dynamic> json) =>
      _$BookingRequestFromJson(json);
  Map<String, dynamic> toJson() => _$BookingRequestToJson(this);
}

@JsonSerializable()
class BookingData {
  final String firstname;
  final String mobile;
  final String email;
  final String leads_interest_service; // code
  final String identification_number;
  final String identity_card_issue_date; // dd/MM/yyyy
  final String branch; // text
  final String start_day; // dd-MM-yyyy
  final List<String> start_time; // ["HH:mm Sáng/Chiều"]
  final String note;
  final String source_description;
  BookingData(
      {required this.firstname,
      required this.mobile,
      required this.email,
      required this.leads_interest_service,
      required this.identification_number,
      required this.identity_card_issue_date,
      required this.branch,
      required this.start_day,
      required this.start_time,
      required this.note,
      required this.source_description});

  factory BookingData.fromJson(Map<String, dynamic> json) =>
      _$BookingDataFromJson(json);
  Map<String, dynamic> toJson() => _$BookingDataToJson(this);
}
