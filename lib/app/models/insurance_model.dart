// To parse this JSON data, do
//
//     final insuranceModel = insuranceModelFromJson(jsonString);

import 'dart:convert';

class InsuranceModel {
  InsuranceModel({
    this.idInsurance,
    this.type,
    this.address,
    this.registerLocation,
    this.expiredDate,
  });

  int? type;
  String? idInsurance;
  String? address;
  String? registerLocation;
  String? expiredDate;

  factory InsuranceModel.fromRawJson(String str) =>
      InsuranceModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InsuranceModel.fromJson(Map<String, dynamic> json) => InsuranceModel(
        idInsurance: json["id_insurance"],
        type: json["type"],
        address: json["address"],
        registerLocation: json["register_location"],
        expiredDate: json["expired_date"],
      );

  Map<String, dynamic> toJson() => {
        "id_insurance": idInsurance,
        "type": type,
        "address": address,
        "register_location": registerLocation,
        "expired_date": expiredDate,
      };
}
