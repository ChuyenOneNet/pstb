import 'package:json_annotation/json_annotation.dart';

part 'create_request_model.g.dart';

@JsonSerializable()
class CreateRequestModel {
  // Màn 1
  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'identificationCode')
  final String cccd;

  @JsonKey(name: 'age')
  final int age;

  @JsonKey(name: 'gender')
  final int gender;

  @JsonKey(name: 'dateOfBirth')
  final String birthDate;

  @JsonKey(name: 'jobName')
  final String? jobName; //k truyền tạo

  @JsonKey(name: 'jobId')
  final String job;

  @JsonKey(name: 'addressDetail')
  final String addressDetail;

  @JsonKey(name: 'phoneNumber')
  final String phone;

  @JsonKey(name: 'fatherName')
  final String fatherName;

  @JsonKey(name: 'motherName')
  final String motherName;

  @JsonKey(name: 'dateOfIssueIdentificationCode')
  final String idIssueDate;

  @JsonKey(name: 'placeOfIssueIdentificationCode')
  final String? idIssuePlace;

  @JsonKey(name: 'nationalId')
  final String nationalId;

  @JsonKey(name: 'ethnicId')
  final String ethnic;

  @JsonKey(name: 'provinceId')
  final String provinceId;

  @JsonKey(name: 'communeWardId')
  final String communeWardId;
  //k truyền
  @JsonKey(name: 'nationalName')
  final String? nationalName;

  @JsonKey(name: 'ethnicName')
  final String? ethnicName;

  @JsonKey(name: 'provinceName')
  final String? provinceName;

  @JsonKey(name: 'communeWardName')
  final String? communeWardName;
  //
  // Màn 2
  @JsonKey(name: 'examTypeId')
  final String examTypeId;

  @JsonKey(name: 'examTypeName')
  final String? examTypeName; // k truyền lên

  @JsonKey(name: 'clinicRoomCode')
  final String? clinicRoomCode;

  @JsonKey(name: 'clinicRoomName')
  String? clinicRoomName; // k truyền lên

  @JsonKey(name: 'reason')
  final String reason;

  @JsonKey(name: 'priority')
  final String priority;

  @JsonKey(name: 'arrivalMetod') // backend viết sai chính tả Method -> Metod
  final String arrivalMethod;

  @JsonKey(name: 'scheduleAt')
  final String scheduledAt;

  @JsonKey(name: 'hasInsurance')
  final bool hasInsurance;

  @JsonKey(name: 'pathPdf')
  final String? pathPdf;

  @JsonKey(name: 'price')
  final String? price;

  CreateRequestModel({
    required this.name,
    required this.cccd,
    required this.age,
    required this.gender,
    required this.birthDate,
    required this.job,
    required this.addressDetail,
    required this.phone,
    required this.fatherName,
    required this.motherName,
    required this.idIssueDate,
    this.idIssuePlace,
    this.examTypeName,
    required this.nationalId,
    required this.provinceId,
    required this.communeWardId,
    this.jobName,
    this.nationalName,
    this.ethnicName,
    this.provinceName,
    this.communeWardName,
    required this.scheduledAt,
    required this.ethnic,
    required this.examTypeId,
    this.clinicRoomCode,
    this.clinicRoomName,
    required this.reason,
    required this.priority,
    required this.arrivalMethod,
    this.hasInsurance = false,
    this.pathPdf,
    this.price,
  });

  factory CreateRequestModel.fromJson(Map<String, dynamic> json) =>
      _$CreateRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateRequestModelToJson(this);
}
