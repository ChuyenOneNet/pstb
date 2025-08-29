// To parse this JSON data, do
//
//     final discountModel = discountModelFromJson(jsonString);

import 'dart:convert';

class DiscountModel {
  DiscountModel({
    this.denNgay,
    this.maCtkm,
    this.tuNgay,
  });

  DateTime? denNgay;
  dynamic maCtkm;
  DateTime? tuNgay;

  factory DiscountModel.fromRawJson(String str) =>
      DiscountModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DiscountModel.fromJson(Map<String, dynamic> json) => DiscountModel(
        denNgay:
            json["DenNgay"] == null ? null : DateTime.parse(json["DenNgay"]),
        maCtkm: json["MaCTKM"],
        tuNgay: json["TuNgay"] == null ? null : DateTime.parse(json["TuNgay"]),
      );

  Map<String, dynamic> toJson() => {
        "DenNgay": denNgay == null ? null : denNgay!.toIso8601String(),
        "MaCTKM": maCtkm,
        "TuNgay": tuNgay == null ? null : tuNgay!.toIso8601String(),
      };
}
