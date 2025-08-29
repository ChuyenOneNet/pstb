import 'package:json_annotation/json_annotation.dart';

part 'business_detail_model.g.dart';

@JsonSerializable(explicitToJson: true)
class BusinessDetailModel {
  final String? title;
  final String? xuTri;
  final String? ngayVaoVien;
  final String? ngayRaVien;
  final SinhHieu? sinhHieu;
  final List<UrlDataInfo>? urlDataInfos;
  final List<dynamic>? docmments;
  final List<XetNghiemInfo>? xetNghiemInfos;
  final List<ToaThuocInfo>? toaThuocInfos;
  final List<VienPhiInfo>? vienPhiInfos;

  BusinessDetailModel({
    this.title,
    this.xuTri,
    this.ngayVaoVien,
    this.ngayRaVien,
    this.sinhHieu,
    this.urlDataInfos,
    this.docmments,
    this.xetNghiemInfos,
    this.toaThuocInfos,
    this.vienPhiInfos,
  });

  factory BusinessDetailModel.fromJson(Map<String, dynamic> json) =>
      _$BusinessDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$BusinessDetailModelToJson(this);
}

@JsonSerializable()
class SinhHieu {
  final String? chanDoanPhanBiet;
  final String? benhChinh;
  final String? benhKemTheo;
  final String? id;
  final String? dangKyId;
  final String? khamBenhId;
  final String? noiTruId;
  final String? mach;
  final String? nhietDo;
  final String? huyetApMin;
  final String? huyetApMax;
  final String? nhipTho;
  final String? canNang;
  final String? chieuCao;
  final String? bmi;
  final String? spo2;
  final String? thoiGian;
  final int? loai;
  final String? lyDoDenKham;

  SinhHieu({
    this.chanDoanPhanBiet,
    this.benhChinh,
    this.benhKemTheo,
    this.id,
    this.dangKyId,
    this.khamBenhId,
    this.noiTruId,
    this.mach,
    this.nhietDo,
    this.huyetApMin,
    this.huyetApMax,
    this.nhipTho,
    this.canNang,
    this.chieuCao,
    this.bmi,
    this.spo2,
    this.thoiGian,
    this.loai,
    this.lyDoDenKham,
  });

  factory SinhHieu.fromJson(Map<String, dynamic> json) =>
      _$SinhHieuFromJson(json);

  Map<String, dynamic> toJson() => _$SinhHieuToJson(this);
}

@JsonSerializable()
class UrlDataInfo {
  final String? id;
  final String? dangKyId;
  final String? benhNhanId;
  final String? maDichVu;
  final String? tenDichVu;
  final String? fileUrl;
  final String? ketLuan;

  UrlDataInfo({
    this.id,
    this.dangKyId,
    this.benhNhanId,
    this.maDichVu,
    this.tenDichVu,
    this.fileUrl,
    this.ketLuan,
  });

  factory UrlDataInfo.fromJson(Map<String, dynamic> json) =>
      _$UrlDataInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UrlDataInfoToJson(this);
}

@JsonSerializable()
class ToaThuocInfo {
  final String? id;
  final String? loai;
  final String? soLuong;
  final String? donViTinh;
  final String? cachDung;
  final String? tenHang;
  final String? hoatChat;
  final String? duongDung;
  final String? thoiGian;
  final String? toaThuoc_ID;
  final String? dangKy_ID;
  final String? bacSi;

  ToaThuocInfo({
    this.id,
    this.loai,
    this.soLuong,
    this.donViTinh,
    this.cachDung,
    this.tenHang,
    this.hoatChat,
    this.duongDung,
    this.thoiGian,
    this.toaThuoc_ID,
    this.dangKy_ID,
    this.bacSi,
  });

  factory ToaThuocInfo.fromJson(Map<String, dynamic> json) =>
      _$ToaThuocInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ToaThuocInfoToJson(this);
}

@JsonSerializable()
class VienPhiInfo {
  final String? id;
  final String? dangKy_ID;
  final String? benhNhan_ID;
  final String? lastTimeUpdate;
  final String? thoiGian;
  final String? maGiaoDich;
  final String? xmlData;
  final String? maHoaDon;

  VienPhiInfo({
    this.id,
    this.dangKy_ID,
    this.benhNhan_ID,
    this.lastTimeUpdate,
    this.thoiGian,
    this.maGiaoDich,
    this.xmlData,
    this.maHoaDon,
  });

  factory VienPhiInfo.fromJson(Map<String, dynamic> json) =>
      _$VienPhiInfoFromJson(json);

  Map<String, dynamic> toJson() => _$VienPhiInfoToJson(this);
}

@JsonSerializable()
class XetNghiemInfo {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'xetNghiem_ID')
  final String? xetNghiemId;

  @JsonKey(name: 'loaiXetNghiem_ID')
  final String? loaiXetNghiemId;
  final String? tenLoaiXetNghiem;
  @JsonKey(name: 'chiSoXetNghiem_ID')
  final String? chiSoXetNghiemId;
  final String? giaTri;
  final String? normalRange;
  final String? tenChiSo;
  final String? donViTinh;
  final String? tenDichVu;
  final DateTime? thoiGian;
  @JsonKey(name: 'dangKy_ID')
  final String? dangKyId;

  XetNghiemInfo({
    this.id,
    this.xetNghiemId,
    this.loaiXetNghiemId,
    this.tenLoaiXetNghiem,
    this.chiSoXetNghiemId,
    this.giaTri,
    this.normalRange,
    this.tenChiSo,
    this.donViTinh,
    this.tenDichVu,
    this.thoiGian,
    this.dangKyId,
  });

  factory XetNghiemInfo.fromJson(Map<String, dynamic> json) =>
      _$XetNghiemInfoFromJson(json);

  Map<String, dynamic> toJson() => _$XetNghiemInfoToJson(this);
}
