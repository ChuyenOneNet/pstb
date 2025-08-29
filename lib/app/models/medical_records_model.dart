import 'dart:convert';

class MedicalRecords {
  MedicalRecords({
    this.maHoSo,
    this.ngayVaoKham,
    this.lyDoVaoKham,
    this.tienSuBenhBanThan,
    this.tienSuBenhGiaDinh,
    this.chanDoan,
    this.ketLuan,
    this.xuTri,
    this.tenBacSy,
    this.canNang,
    this.chieuCao,
    this.huyetAp,
    this.nhietDo,
    this.nhipTho,
    this.toanThan,
    this.tuanHoan,
    this.hoHap,
    this.tieuHoa,
    this.thanTietNieu,
    this.noiTiet,
    this.coXuongKhop,
    this.thanKinh,
    this.tamThan,
    this.noiKham,
    this.ketThucKham,
  });

  String? maHoSo;
  DateTime? ngayVaoKham;
  String? lyDoVaoKham;
  String? tienSuBenhBanThan;
  String? tienSuBenhGiaDinh;
  String? chanDoan;
  String? ketLuan;
  String? xuTri;
  String? tenBacSy;
  String? canNang;
  String? chieuCao;
  String? huyetAp;
  String? nhietDo;
  String? nhipTho;
  String? toanThan;
  String? tuanHoan;
  String? hoHap;
  String? tieuHoa;
  String? thanTietNieu;
  String? noiTiet;
  String? coXuongKhop;
  String? thanKinh;
  String? tamThan;
  String? noiKham;
  DateTime? ketThucKham;

  factory MedicalRecords.fromRawJson(String str) =>
      MedicalRecords.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MedicalRecords.fromJson(Map<String, dynamic> json) => MedicalRecords(
        maHoSo: json["MaHoSo"],
        ngayVaoKham: json["NgayVaoKham"] == null
            ? null
            : DateTime.parse(json["NgayVaoKham"]),
        lyDoVaoKham: json["LyDoVaoKham"],
        tienSuBenhBanThan: json["TienSuBenhBanThan"],
        tienSuBenhGiaDinh: json["TienSuBenhGiaDinh"],
        chanDoan: json["ChanDoan"],
        ketLuan: json["KetLuan"],
        xuTri: json["XuTri"],
        tenBacSy: json["TenBacSy"],
        canNang: json["CanNang"],
        chieuCao: json["ChieuCao"],
        huyetAp: json["HuyetAp"],
        nhietDo: json["NhietDo"],
        nhipTho: json["NhipTho"],
        toanThan: json["ToanThan"],
        tuanHoan: json["TuanHoan"],
        hoHap: json["HoHap"],
        tieuHoa: json["TieuHoa"],
        thanTietNieu:
            json["Than_TietNieu"],
        noiTiet: json["NoiTiet"],
        coXuongKhop:
            json["Co_Xuong_Khop"],
        thanKinh: json["ThanKinh"],
        tamThan: json["TamThan"],
        noiKham: json["NoiKham"],
        ketThucKham: json["KetThucKham"] == null
            ? null
            : DateTime.parse(json["KetThucKham"]),
      );

  Map<String, dynamic> toJson() => {
        "MaHoSo": maHoSo,
        "NgayVaoKham":
            ngayVaoKham == null ? null : ngayVaoKham!.toIso8601String(),
        "LyDoVaoKham": lyDoVaoKham,
        "TienSuBenhBanThan":
            tienSuBenhBanThan,
        "TienSuBenhGiaDinh":
            tienSuBenhGiaDinh,
        "ChanDoan": chanDoan,
        "KetLuan": ketLuan,
        "XuTri": xuTri,
        "TenBacSy": tenBacSy,
        "CanNang": canNang,
        "ChieuCao": chieuCao,
        "HuyetAp": huyetAp,
        "NhietDo": nhietDo,
        "NhipTho": nhipTho,
        "ToanThan": toanThan,
        "TuanHoan": tuanHoan,
        "HoHap": hoHap,
        "TieuHoa": tieuHoa,
        "Than_TietNieu": thanTietNieu,
        "NoiTiet": noiTiet,
        "Co_Xuong_Khop": coXuongKhop,
        "ThanKinh": thanKinh,
        "TamThan": tamThan,
        "NoiKham": noiKham,
        "KetThucKham":
            ketThucKham == null ? null : ketThucKham!.toIso8601String(),
      };
}
