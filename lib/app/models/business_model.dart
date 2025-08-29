import 'package:json_annotation/json_annotation.dart';

part 'business_model.g.dart';

@JsonSerializable()
class BusinessModel {
  final String id;
  final String? key;
  final String? dangKyId;
  final String? benhNhanId;
  final int xuTriType;
  final String? xuTriContent;
  final String? thoiGianVao;
  final String? vao;
  final String? thoiGianRa;
  final String? ra;
  final String? icdId;
  final String? moTaIcd;
  final String? chanDoanPhanBiet;
  final String? benhKemTheo;
  final int loai;
  final dynamic sinhHieuChamSocDto;

  BusinessModel({
    required this.id,
    this.key,
    this.dangKyId,
    this.benhNhanId,
    required this.xuTriType,
    this.xuTriContent,
    this.thoiGianVao,
    this.vao,
    this.thoiGianRa,
    this.ra,
    this.icdId,
    this.moTaIcd,
    this.chanDoanPhanBiet,
    this.benhKemTheo,
    required this.loai,
    this.sinhHieuChamSocDto,
  });

  factory BusinessModel.fromJson(Map<String, dynamic> json) =>
      _$BusinessModelFromJson(json);

  Map<String, dynamic> toJson() => _$BusinessModelToJson(this);
}
