// To parse this JSON data, do
//
//     final getDoctorModel = getDoctorModelFromJson(jsonString);

import 'dart:convert';

class SearchDoctorModel {
  SearchDoctorModel({
    required this.pageSize,
    required this.pageIndex,
    required this.MedicalUnitId,
  });

  int pageSize;
  int pageIndex;
  int MedicalUnitId;

  factory SearchDoctorModel.fromRawJson(String str) =>
      SearchDoctorModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchDoctorModel.fromJson(Map<String, dynamic> json) =>
      SearchDoctorModel(
        pageSize: json["pageSize"],
        pageIndex: json["pageIndex"],
        MedicalUnitId: json["MedicalUnitId"],
      );

  Map<String, dynamic> toJson() => {
        "pageSize": pageSize,
        "pageIndex": pageIndex,
        "MedicalUnitId": MedicalUnitId,
      };
}
