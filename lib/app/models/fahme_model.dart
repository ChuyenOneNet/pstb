// To parse this JSON data, do
//
//     final fahmeModel = fahmeModelFromJson(jsonString);

import 'dart:convert';

class FahmeModel {
  FahmeModel({
    required this.maBenhNhan,
    required this.soDienThoai,
    required this.tenBenhNhan,
    required this.namSinh,
  });

  String maBenhNhan;
  String soDienThoai;
  String tenBenhNhan;
  DateTime namSinh;

  factory FahmeModel.fromRawJson(String str) =>
      FahmeModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FahmeModel.fromJson(Map<String, dynamic> json) => FahmeModel(
        maBenhNhan: json["MaBenhNhan"],
        soDienThoai: json["SoDienThoai"],
        tenBenhNhan: json["TenBenhNhan"],
        namSinh: DateTime.parse(json["NamSinh"]),
      );

  Map<String, dynamic> toJson() => {
        "MaBenhNhan": maBenhNhan,
        "SoDienThoai": soDienThoai,
        "TenBenhNhan": tenBenhNhan,
        "NamSinh":
            "${namSinh.year.toString().padLeft(4, '0')}-${namSinh.month.toString().padLeft(2, '0')}-${namSinh.day.toString().padLeft(2, '0')}",
      };
}

AddHistoryExaminalModel addHistoryExaminalModelFromJson(String str) =>
    AddHistoryExaminalModel.fromJson(json.decode(str));

String addHistoryExaminalModelToJson(AddHistoryExaminalModel data) =>
    json.encode(data.toJson());

class AddHistoryExaminalModel {
  AddHistoryExaminalModel({
    required this.noikham,
    required this.ngaykham,
    required this.diachi,
    required this.images,
    required this.tenbacsy,
  });

  String noikham;
  String ngaykham;
  String diachi;
  List<String> images;
  String tenbacsy;

  factory AddHistoryExaminalModel.fromRawJson(String str) =>
      AddHistoryExaminalModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddHistoryExaminalModel.fromJson(Map<String, dynamic> json) =>
      AddHistoryExaminalModel(
        noikham: json["noikham"],
        ngaykham: json["ngaykham"],
        diachi: json["diachi"],
        images: List<String>.from(json["images"].map((x) => x)),
        tenbacsy: json["tenbacsy"],
      );

  Map<String, dynamic> toJson() => {
        "noikham": noikham,
        "ngaykham": ngaykham,
        "diachi": diachi,
        "images": List<dynamic>.from(images.map((x) => x)),
        "tenbacsy": tenbacsy,
      };
}
