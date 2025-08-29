// To parse this JSON data, do
//
//     final medicalRecordsDetailResponsitory = medicalRecordsDetailResponsitoryFromJson(jsonString);

import 'dart:convert';

import 'package:pstb/app/models/examination_results_model.dart';
import 'package:pstb/app/models/medical_records_model.dart';

class MedicalRecordsDetailModel {
  MedicalRecordsDetailModel({
    this.comment,
    this.statusCode,
    this.data,
  });

  String? comment;
  int? statusCode;
  Data? data;

  factory MedicalRecordsDetailModel.fromRawJson(String str) =>
      MedicalRecordsDetailModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MedicalRecordsDetailModel.fromJson(Map<String, dynamic> json) =>
      MedicalRecordsDetailModel(
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
    this.ketQuaCls,
  });

  List<MedicalRecords>? hoSoKhamBenh;
  List<ExaminationResults>? ketQuaCls;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        hoSoKhamBenh: json["HoSoKhamBenh"] == null
            ? null
            : List<MedicalRecords>.from(
                json["HoSoKhamBenh"].map((x) => MedicalRecords.fromJson(x))),
        ketQuaCls: json["KetQuaCLS"] == null
            ? null
            : List<ExaminationResults>.from(
                json["KetQuaCLS"].map((x) => ExaminationResults.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "HoSoKhamBenh": hoSoKhamBenh == null
            ? null
            : List<dynamic>.from(hoSoKhamBenh!.map((x) => x.toJson())),
        "KetQuaCLS": ketQuaCls == null
            ? null
            : List<dynamic>.from(ketQuaCls!.map((x) => x.toJson())),
      };
}
