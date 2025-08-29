import 'dart:convert';
import 'package:pstb/app/models/medical_records_model.dart';

class NewPrescriptionModel {
  NewPrescriptionModel({
    this.comment,
    this.statusCode,
    this.data,
  });

  String? comment;
  int? statusCode;
  Data? data;

  factory NewPrescriptionModel.fromRawJson(String str) =>
      NewPrescriptionModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NewPrescriptionModel.fromJson(Map<String, dynamic> json) =>
      NewPrescriptionModel(
        comment: json["Comment"],
        statusCode: json["StatusCode"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "Comment": comment,
        "StatusCode": statusCode,
        "data": data == null ? null : data!.toJson(),
      };
}

class Data {
  Data({
    this.hoSoKhamBenh,
    this.donThuoc,
  });

  List<MedicalRecords>? hoSoKhamBenh;
  List<DonThuoc>? donThuoc;

  Data copyWith({
    List<MedicalRecords>? hoSoKhamBenh,
    List<DonThuoc>? donThuoc,
  }) =>
      Data(
        hoSoKhamBenh: hoSoKhamBenh ?? this.hoSoKhamBenh,
        donThuoc: donThuoc ?? this.donThuoc,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        hoSoKhamBenh: List<MedicalRecords>.from(
            json["HoSoKhamBenh"].map((x) => MedicalRecords.fromJson(x))),
        donThuoc: List<DonThuoc>.from(
            json["DonThuoc"].map((x) => DonThuoc.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "HoSoKhamBenh":
            List<dynamic>.from(hoSoKhamBenh!.map((x) => x.toJson())),
        "DonThuoc": List<dynamic>.from(donThuoc!.map((x) => x.toJson())),
      };
}

class DonThuoc {
  DonThuoc({
    this.maDonThuoc,
    this.tenDonThuoc,
    this.tenBacSy,
    this.soNgayKhamLai,
    this.loiDan,
    this.anKieng,
    this.chitiet,
    this.trangThai,
  });

  String? maDonThuoc;
  String? tenDonThuoc;
  String? tenBacSy;
  int? soNgayKhamLai;
  String? loiDan;
  dynamic anKieng;
  List<PrescriptionDetails>? chitiet;
  String? trangThai;

  factory DonThuoc.fromRawJson(String str) =>
      DonThuoc.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DonThuoc.fromJson(Map<String, dynamic> json) => DonThuoc(
        maDonThuoc: json["MaDonThuoc"],
        tenDonThuoc: json["TenDonThuoc"],
        tenBacSy: json["TenBacSy"],
        soNgayKhamLai: json["SoNgayKhamLai"],
        loiDan: json["LoiDan"],
        anKieng: json["AnKieng"],
        chitiet: json["chitiet"] == null
            ? null
            : List<PrescriptionDetails>.from(
                json["chitiet"].map((x) => PrescriptionDetails.fromJson(x))),
        trangThai: json["TrangThai"],
      );

  Map<String, dynamic> toJson() => {
        "MaDonThuoc": maDonThuoc,
        "TenDonThuoc": tenDonThuoc,
        "TenBacSy": tenBacSy,
        "SoNgayKhamLai": soNgayKhamLai,
        "LoiDan": loiDan,
        "AnKieng": anKieng,
        "chitiet": chitiet == null
            ? null
            : List<dynamic>.from(chitiet!.map((x) => x.toJson())),
        "TrangThai": trangThai,
      };
}

class PrescriptionDetails {
  PrescriptionDetails({
    this.maDonThuoc,
    this.tenVatTu,
    this.hamLuong,
    this.soLuong,
    this.tenDonVi,
    this.soNgaySuDung,
    this.soLuongSang,
    this.soLuongTrua,
    this.soLuongChieu,
    this.soLuongToi,
    this.huongDanSuDung,
    this.donGia,
  });

  String? maDonThuoc;
  String? tenVatTu;
  String? hamLuong;
  double? soLuong;
  String? tenDonVi;
  String? soNgaySuDung;
  String? soLuongSang;
  String? soLuongTrua;
  String? soLuongChieu;
  String? soLuongToi;
  String? huongDanSuDung;
  int? donGia;

  factory PrescriptionDetails.fromRawJson(String str) =>
      PrescriptionDetails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PrescriptionDetails.fromJson(Map<String, dynamic> json) =>
      PrescriptionDetails(
        maDonThuoc: json["MaDonThuoc"],
        tenVatTu: json["TenVatTu"],
        hamLuong: json["HamLuong"],
        soLuong: json["SoLuong"],
        tenDonVi: json["TenDonVi"],
        soNgaySuDung: json["SoNgaySuDung"],
        soLuongSang: json["SoLuongSang"],
        soLuongTrua: json["SoLuongTrua"],
        soLuongChieu: json["SoLuongChieu"],
        soLuongToi: json["SoLuongToi"],
        huongDanSuDung: json["HuongDanSuDung"],
        donGia: json["DonGia"],
      );

  Map<String, dynamic> toJson() => {
        "MaDonThuoc": maDonThuoc,
        "TenVatTu": tenVatTu,
        "HamLuong": hamLuong,
        "SoLuong": soLuong,
        "TenDonVi": tenDonVi,
        "SoNgaySuDung": soNgaySuDung,
        "SoLuongSang": soLuongSang,
        "SoLuongTrua": soLuongTrua,
        "SoLuongChieu": soLuongChieu,
        "SoLuongToi": soLuongToi,
        "HuongDanSuDung": huongDanSuDung,
        "DonGia": donGia,
      };
}
