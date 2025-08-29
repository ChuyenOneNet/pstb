import 'package:json_annotation/json_annotation.dart';

part 'user_his_model.g.dart';

@JsonSerializable()
class UserHisModel {
  final int? id;
  final String? userName;
  final String? name;
  final String? surname;
  final String? emailAddress;
  final bool? isActive;
  final String? fullName;
  final String? lastLoginTime;
  final String? creationTime;
  final List<String>? roleNames;

  UserHisModel({
    this.id,
    this.userName,
    this.name,
    this.surname,
    this.emailAddress,
    this.isActive,
    this.fullName,
    this.lastLoginTime,
    this.creationTime,
    this.roleNames,
  });

  factory UserHisModel.fromJson(Map<String, dynamic> json) =>
      _$UserHisModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserHisModelToJson(this);
}
