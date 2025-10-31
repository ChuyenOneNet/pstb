import 'package:json_annotation/json_annotation.dart';
import 'kham_chua_benh_model.dart';

part 'business_model.g.dart';

@JsonSerializable()
class BusinessModel {
  final String id;
  final String? benhNhanId;
  final String? malk;
  final String? lyDoVaoVien;
  final int? phanLoai;
  final String? thoiGianVao;
  final String? vao;
  final String? thoiGianRa;
  final String? ra;
  final String? dateModified;
  @JsonKey(name: 'khamChuaBenhs')
  final List<KhamChuaBenhModel> khamChuaBenhs; // New field for nested data

  BusinessModel({
    required this.id,
    this.malk,
    this.lyDoVaoVien,
    this.phanLoai,
    this.dateModified,
    this.benhNhanId,
    this.thoiGianVao,
    this.vao,
    this.thoiGianRa,
    this.ra,
    this.khamChuaBenhs = const [], // Default empty list if null
  });

  factory BusinessModel.fromJson(Map<String, dynamic> json) =>
      _$BusinessModelFromJson(json);

  Map<String, dynamic> toJson() => _$BusinessModelToJson(this);
}
