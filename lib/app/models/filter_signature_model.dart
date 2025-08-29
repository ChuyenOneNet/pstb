// // class FilterSignatureModel {
// //   String? userName;
// //   int? idSigningStatus;
// //   String? roleCode;
// //   String? searchValue;
// //   String? fromDate;
// //   String? toDate;
// //   String? departmentCode;
// //   String? patientCode;
// //   String? documentTypeCode;
// //   int? pageIndex;
// //
// //   FilterSignatureModel(
// //       {this.userName,
// //       this.idSigningStatus,
// //       this.roleCode,
// //       this.searchValue,
// //       this.fromDate,
// //       this.toDate,
// //       this.departmentCode,
// //       this.documentTypeCode,
// //         this.pageIndex,
// //       this.patientCode});
// //
// //   Map<String, dynamic> toJson() {
// //     return {
// //       'userName': userName,
// //       'roleCode': roleCode,
// //       'keyword': searchValue,
// //       'signingStatus': idSigningStatus,
// //       'fromDate': fromDate,
// //       'toDate': toDate,
// //       'departmentCode': departmentCode,
// //       'patientCode': patientCode,
// //       'documentTypeCode': documentTypeCode,
// //       'pageIndex': pageIndex
// //     };
// //   }
// // }
// import 'package:json_annotation/json_annotation.dart';
//
// part 'filter_signature_model.g.dart';
//
// @JsonSerializable(includeIfNull: false)
// class FilterSignatureModel {
//   final int? maxResultCount;
//   final int? skipCount;
//   final String? sorting;
//   final int? userId;
//   final String? registrationId;
//   final String? patientId;
//   final String? patientName;
//   final String? patientCode;
//   final String? documentId;
//   final String? documentName;
//   final String? documentTypeId;
//   final String? documentTypeName;
//   final String? departmentCode;
//   final String? departmentName;
//   final String? signatureRoleId;
//   final String? signatureRoleCode;
//   final int? documentStatus;
//
//   final String? createdDate;
//   final String? createdDateStart;
//   final String? createdDateEnd;
//   final String? transferSignDate;
//   final String? transferSignDateStart;
//   final String? transferSignDateEnd;
//   final String? signedDate;
//   final String? signedDateStart;
//   final String? signedDateEnd;
//
//   final int? sortType;
//   final int? sortDirection;
//
//   const FilterSignatureModel({
//     this.maxResultCount = 2147483647,
//     this.skipCount,
//     this.sorting,
//     this.userId,
//     this.registrationId,
//     this.patientId,
//     this.patientName,
//     this.patientCode,
//     this.documentId,
//     this.documentName,
//     this.documentTypeId,
//     this.documentTypeName,
//     this.departmentCode,
//     this.departmentName,
//     this.signatureRoleId,
//     this.signatureRoleCode,
//     this.documentStatus,
//     this.createdDate,
//     this.createdDateStart,
//     this.createdDateEnd,
//     this.transferSignDate,
//     this.transferSignDateStart,
//     this.transferSignDateEnd,
//     this.signedDate,
//     this.signedDateStart,
//     this.signedDateEnd,
//     this.sortType,
//     this.sortDirection,
//   });
//
//   factory FilterSignatureModel.fromJson(Map<String, dynamic> json) =>
//       _$FilterSignatureModelFromJson(json);
//
//   Map<String, dynamic> toJson() => _$FilterSignatureModelToJson(this);
// }
class FilterSignatureModel {
  String? userName;
  int? idSigningStatus;
  String? roleCode;
  String? searchValue;
  String? fromDate;
  String? toDate;
  String? departmentCode;
  String? patientCode;
  String? documentTypeCode;
  int? pageIndex;

  FilterSignatureModel(
      {this.userName,
      this.idSigningStatus,
      this.roleCode,
      this.searchValue,
      this.fromDate,
      this.toDate,
      this.departmentCode,
      this.documentTypeCode,
      this.pageIndex,
      this.patientCode});

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'roleCode': roleCode,
      'keyword': searchValue,
      'signingStatus': idSigningStatus,
      'fromDate': fromDate,
      'toDate': toDate,
      'departmentCode': departmentCode,
      'patientCode': patientCode,
      'documentTypeCode': documentTypeCode,
      'pageIndex': pageIndex
    };
  }
}
