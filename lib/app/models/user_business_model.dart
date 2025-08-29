import 'package:json_annotation/json_annotation.dart';

part 'user_business_model.g.dart';

@JsonSerializable()
class UserBusinessModel {
  final String? id;
  final String? ma;
  final String? hoTen;
  final int? gioiTinh;
  final String? ngaySinh;
  final String? ngaySinhText;
  final String? diaChiLienHe;
  final String? dienThoai;
  final String? passWord;
  final String? passWordDefault;
  final String? lastTimeUpdate;
  final String? soCmt;
  final String? thuDienTu;
  final String? tuoi;
  final String? maTheBHYT;

  @JsonKey(name: 'diaChiHanhChinh_ID')
  final String? diaChiHanhChinhId;

  UserBusinessModel({
    this.id,
    this.ma,
    this.hoTen,
    this.gioiTinh,
    this.ngaySinh,
    this.ngaySinhText,
    this.diaChiLienHe,
    this.dienThoai,
    this.passWord,
    this.passWordDefault,
    this.lastTimeUpdate,
    this.soCmt,
    this.thuDienTu,
    this.tuoi,
    this.maTheBHYT,
    this.diaChiHanhChinhId,
  });

  factory UserBusinessModel.fromJson(Map<String, dynamic> json) =>
      _$UserBusinessModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserBusinessModelToJson(this);
}
