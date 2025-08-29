import 'dart:convert';

class ExaminationResults {
  ExaminationResults({
    this.tenDichVu,
    this.ngayChiDinh,
    this.ngayThucHien,
    this.nguoiChiDinh,
    this.nguoiThucHien,
    this.ketQua,
    this.ketLuan,
    this.maPhieu,
    this.pdf,
    this.chitiet,
  });

  String? tenDichVu;
  DateTime? ngayChiDinh;
  DateTime? ngayThucHien;
  String? nguoiChiDinh;
  String? nguoiThucHien;
  String? ketQua;
  String? ketLuan;
  String? maPhieu;
  String? pdf;
  List<Chitiet>? chitiet;

  factory ExaminationResults.fromRawJson(String str) =>
      ExaminationResults.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ExaminationResults.fromJson(Map<String, dynamic> json) =>
      ExaminationResults(
        tenDichVu: json["TenDichVu"],
        ngayChiDinh: json["NgayChiDinh"] == null
            ? null
            : DateTime.parse(json["NgayChiDinh"]),
        ngayThucHien: DateTime.parse(json["NgayThucHien"]),
        nguoiChiDinh:
            json["NguoiChiDinh"],
        nguoiThucHien:
            json["NguoiThucHien"],
        ketQua: json["KetQua"],
        ketLuan: json["KetLuan"],
        maPhieu: json["MaPhieu"],
        pdf: json["PDF"],
        chitiet: json["chitiet"] == null
            ? null
            : List<Chitiet>.from(
                json["chitiet"].map((x) => Chitiet.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "TenDichVu": tenDichVu,
        "NgayChiDinh":
            ngayChiDinh == null ? null : ngayChiDinh!.toIso8601String(),
        "NgayThucHien":
            ngayThucHien == null ? null : ngayThucHien!.toIso8601String(),
        "NguoiChiDinh": nguoiChiDinh,
        "NguoiThucHien": nguoiThucHien,
        "KetQua": ketQua,
        "KetLuan": ketLuan,
        "MaPhieu": maPhieu,
        "PDF": pdf,
        "chitiet": chitiet == null
            ? null
            : List<dynamic>.from(chitiet!.map((x) => x.toJson())),
      };
}

class Chitiet {
  Chitiet({
    this.tenChiTieu,
    this.ketQua,
    this.donViTraKq,
    this.triSoBinhThuong,
    this.maPhieu,
    this.maPhieuChiTiet,
    this.chitietCt,
  });

  String? tenChiTieu;
  String? ketQua;
  String? donViTraKq;
  String? triSoBinhThuong;
  String? maPhieu;
  String? maPhieuChiTiet;
  List<ChitietCt>? chitietCt;

  factory Chitiet.fromRawJson(String str) => Chitiet.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Chitiet.fromJson(Map<String, dynamic> json) => Chitiet(
        tenChiTieu: json["TenChiTieu"],
        ketQua: json["KetQua"],
        donViTraKq: json["DonViTraKQ"],
        triSoBinhThuong:
            json["TriSoBinhThuong"],
        maPhieu: json["MaPhieu"],
        maPhieuChiTiet:
            json["MaPhieuChiTiet"],
        chitietCt: json["chitiet_ct"] == null
            ? null
            : List<ChitietCt>.from(
                json["chitiet_ct"].map((x) => ChitietCt.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "TenChiTieu": tenChiTieu,
        "KetQua": ketQua,
        "DonViTraKQ": donViTraKq,
        "TriSoBinhThuong": triSoBinhThuong,
        "MaPhieu": maPhieu,
        "MaPhieuChiTiet": maPhieuChiTiet,
        "chitiet_ct": chitietCt == null
            ? null
            : List<dynamic>.from(chitietCt!.map((x) => x.toJson())),
      };
}

class ChitietCt {
  ChitietCt(
      {this.tenChiTieuChiTiet,
      this.ketQua,
      this.doViTraKq,
      this.triSoBinhThuong,
      this.maPhieu,
      this.maPhieuChiTiet,
      this.moTa,
      this.soSanhKetQua});

  String? tenChiTieuChiTiet;
  String? ketQua;
  String? doViTraKq;
  String? triSoBinhThuong;
  String? maPhieu;
  String? maPhieuChiTiet;
  String? moTa;
  int? soSanhKetQua;

  factory ChitietCt.fromRawJson(String str) =>
      ChitietCt.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChitietCt.fromJson(Map<String, dynamic> json) => ChitietCt(
        tenChiTieuChiTiet: json["TenChiTieuChiTiet"],
        ketQua: json["KetQua"],
        doViTraKq: json["DoViTraKQ"],
        triSoBinhThuong:
            json["TriSoBinhThuong"],
        maPhieu: json["MaPhieu"],
        maPhieuChiTiet:
            json["MaPhieuChiTiet"],
        moTa: json["MoTa"],
        soSanhKetQua:
            json["SoSanhKetQua"],
      );

  Map<String, dynamic> toJson() => {
        "TenChiTieuChiTiet":
            tenChiTieuChiTiet,
        "KetQua": ketQua,
        "DoViTraKQ": doViTraKq,
        "TriSoBinhThuong": triSoBinhThuong,
        "MaPhieu": maPhieu,
        "MaPhieuChiTiet": maPhieuChiTiet,
        "MoTa": moTa,
        "SoSanhKetQua": soSanhKetQua,
      };
}
