// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:json_annotation/json_annotation.dart';
//
// part 'electronic_signature_model.g.dart';
//
// @JsonSerializable()
// class DocumentModel {
//   String? documentId;
//   String? documentName;
//   int? documentStatus;
//   String? createdDate;
//   String? signedDate;
//   String? patientName;
//   String? departmentName;
//   String? documentTypeCode;
//   String? documentTypeName;
//   String? documentTypeId;
//
//   DocumentModel({
//     this.documentId,
//     this.documentName,
//     this.documentStatus,
//     this.patientName,
//     this.createdDate,
//     this.signedDate,
//     this.documentTypeCode,
//     this.documentTypeName,
//     this.documentTypeId,
//   });
//
//   factory DocumentModel.fromJson(Map<String, dynamic> json) =>
//       _$DocumentModelFromJson(json);
//
//   Map<String, dynamic> toJson() => _$DocumentModelToJson(this);
//
//   bool isSigned() => documentStatus == 3;
//
//   void setUnSigned() => documentStatus = 1;
//
//   void setSigned() => documentStatus = 3;
//
//   String get getStatusName {
//     switch (documentStatus) {
//       case 3:
//         return "Đã ký";
//       case 2:
//         return "Đang ký";
//       default:
//         return "Chưa ký";
//     }
//   }
//
//   Color get getStatusColor {
//     switch (documentStatus) {
//       case 3:
//         return Colors.green;
//       case 2:
//         return Colors.orange;
//       default:
//         return Colors.red;
//     }
//   }
// }
class DocumentModel {
  String? id;
  String? name;
  int? signingStatus;
  String? createdDate;
  String? signedDate;
  String? patientName;
  String? departmentName;
  String? documentTypeCode;
  String? documentTypeName;

  DocumentModel(
      {this.id,
      this.name,
      this.signingStatus,
      this.patientName,
      this.createdDate,
      this.signedDate,
      this.documentTypeCode,
      this.documentTypeName});

  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    return DocumentModel(
      id: json['id'],
      name: json['name'],
      signingStatus: json['signingStatus'],
      patientName: json['patientName'],
      createdDate: json['createdDate'],
      signedDate: json['signedDate'],
      documentTypeCode: json['documentTypeCode'],
      documentTypeName: json['documentTypeName'],
    );
  }

  isSigned() {
    return signingStatus == 1;
  }

  setUnSigned() {
    return signingStatus = 0;
  }

  setSigned() {
    return signingStatus = 1;
  }
}
