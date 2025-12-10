import 'package:json_annotation/json_annotation.dart';

part 'relative_model.g.dart';

@JsonSerializable()
class RelativeModel {
  final int? id;
  final String? mainCccd;

  final String fullName;
  final String dob; // format YYYY-MM-DD
  final String cccd;
  final String phone;
  final String patientCode;

  final String? addressDetail;
  final String? city;
  final String? ward;
  final String? ethnicity;
  final String? occupation;
  final String? country;
  final String? relationship;

  RelativeModel({
    this.id,
    this.mainCccd,
    required this.fullName,
    required this.dob,
    required this.cccd,
    required this.phone,
    required this.patientCode,
    this.addressDetail,
    this.city,
    this.ward,
    this.ethnicity,
    this.occupation,
    this.country,
    this.relationship,
  });

  factory RelativeModel.fromJson(Map<String, dynamic> json) =>
      _$RelativeModelFromJson(json);

  Map<String, dynamic> toJson() => _$RelativeModelToJson(this);

  RelativeModel copyWith({
    int? id,
    String? mainCccd,
    String? fullName,
    String? dob,
    String? cccd,
    String? phone,
    String? patientCode,
    String? addressDetail,
    String? city,
    String? ward,
    String? ethnicity,
    String? occupation,
    String? country,
    String? relationship,
  }) {
    return RelativeModel(
      id: id ?? this.id,
      mainCccd: mainCccd ?? this.mainCccd,
      fullName: fullName ?? this.fullName,
      dob: dob ?? this.dob,
      cccd: cccd ?? this.cccd,
      phone: phone ?? this.phone,
      patientCode: patientCode ?? this.patientCode,
      addressDetail: addressDetail ?? this.addressDetail,
      city: city ?? this.city,
      ward: ward ?? this.ward,
      ethnicity: ethnicity ?? this.ethnicity,
      occupation: occupation ?? this.occupation,
      country: country ?? this.country,
      relationship: relationship ?? this.relationship,
    );
  }
}
