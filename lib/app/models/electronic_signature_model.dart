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
import 'package:json_annotation/json_annotation.dart';

part 'electronic_signature_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DocumentModel {
  String? id;
  String? name;

  /// 0 = chưa ký, 1 = đã ký, 2 = thu hồi
  @JsonKey(fromJson: _signingStatusFromJson, toJson: _signingStatusToJson)
  int? signingStatus;

  String? createdDate;
  String? signedDate;
  String? patientName;
  String? departmentName;
  String? documentTypeCode;
  String? documentTypeName;

  DocumentModel({
    this.id,
    this.name,
    this.signingStatus,
    this.patientName,
    this.createdDate,
    this.signedDate,
    this.documentTypeCode,
    this.documentTypeName,
  });

  factory DocumentModel.fromJson(Map<String, dynamic> json) =>
      _$DocumentModelFromJson(json);
  Map<String, dynamic> toJson() => _$DocumentModelToJson(this);

  // Helpers logic (không ảnh hưởng serialize)
  bool isSigned() => signingStatus == 1;
  void setUnSigned() => signingStatus = 0;
  void setSigned() => signingStatus = 1;

  // ---- converters ----
  static int? _signingStatusFromJson(dynamic v) {
    // Hỗ trợ cả bool di sản "isSign"
    if (v == null) return null;
    if (v is bool) return v ? 1 : 0;
    if (v is num) return v.toInt();
    if (v is String) {
      final asInt = int.tryParse(v);
      if (asInt != null) return asInt;
      // fallback: "signed"/"pending"/"revoked"
      switch (v.toLowerCase()) {
        case 'signed':
          return 1;
        case 'pending':
        case 'unsigned':
          return 0;
        case 'revoked':
          return 2;
      }
    }
    return null;
  }

  static int? _signingStatusToJson(int? v) => v;
}
