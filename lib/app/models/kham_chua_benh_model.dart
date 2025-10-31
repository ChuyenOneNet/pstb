import 'package:json_annotation/json_annotation.dart';

part 'kham_chua_benh_model.g.dart';

@JsonSerializable()
class KhamChuaBenhModel {
  final String id;
  final String? key;
  final String? dangKyId;
  final String? benhNhanId;
  final int? trangThai;
  final int? xuTriType;
  final String? xuTriContent;
  final String? thoiGianVao;
  final String? vao;
  final String? thoiGianRa;
  final String? ra;
  final String? icdId;
  final String? moTaIcd;
  final String? chanDoanPhanBiet;
  final String? benhKemTheo;
  final int? loai;
  final String? dateModified;
  final dynamic sinhHieuChamSocDto;
  KhamChuaBenhModel({
    required this.id,
    this.key,
    this.dangKyId,
    this.benhNhanId,
    this.trangThai,
    this.xuTriType,
    this.xuTriContent,
    this.thoiGianVao,
    this.vao,
    this.thoiGianRa,
    this.ra,
    this.icdId,
    this.moTaIcd,
    this.chanDoanPhanBiet,
    this.benhKemTheo,
    this.loai,
    this.dateModified,
    this.sinhHieuChamSocDto,
  });

  factory KhamChuaBenhModel.fromJson(Map<String, dynamic> json) =>
      _$KhamChuaBenhModelFromJson(json);

  Map<String, dynamic> toJson() => _$KhamChuaBenhModelToJson(this);
}
