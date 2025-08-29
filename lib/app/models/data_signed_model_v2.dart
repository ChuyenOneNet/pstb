import 'package:json_annotation/json_annotation.dart';

part 'data_signed_model_v2.g.dart';

@JsonSerializable()
class SignedDocumentModelV2 {
  @JsonKey(name: 'status')
  final int? status;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'result')
  final String? result;

  @JsonKey(name: 'OriginFileId')
  final String? originFileId;

  @JsonKey(name: 'SignedFileId')
  final String? signedFileId;

  @JsonKey(name: 'ViewData')
  final String? viewData;

  @JsonKey(name: 'SignedInfoDto')
  final SignedInfoDto? signedInfoDto;

  @JsonKey(name: 'CreateVersion')
  final bool? createVersion;

  @JsonKey(name: 'SignTime')
  final String? signTime;

  SignedDocumentModelV2({
    this.status,
    this.message,
    this.result,
    this.originFileId,
    this.signedFileId,
    this.viewData,
    this.signedInfoDto,
    this.createVersion,
    this.signTime,
  });

  factory SignedDocumentModelV2.fromJson(Map<String, dynamic> json) =>
      _$SignedDocumentModelV2FromJson(json);

  Map<String, dynamic> toJson() => _$SignedDocumentModelV2ToJson(this);
}

@JsonSerializable()
class SignedInfoDto {
  @JsonKey(name: 'signerCode')
  final String? signerCode;

  @JsonKey(name: 'signerName')
  final String? signerName;

  @JsonKey(name: 'signedTime')
  final String? signedTime;

  SignedInfoDto({this.signerCode, this.signerName, this.signedTime});

  factory SignedInfoDto.fromJson(Map<String, dynamic> json) =>
      _$SignedInfoDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SignedInfoDtoToJson(this);
}
