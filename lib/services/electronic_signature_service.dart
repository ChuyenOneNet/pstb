// import 'dart:convert';
//
// import 'package:pstb/app/models/data_signed_model.dart';
// import 'package:pstb/app/models/electronic_signature_model.dart';
// import 'package:pstb/app/models/paging_model.dart';
// import 'package:pstb/app/models/sign_roles_model.dart';
// import 'package:pstb/services/api_base_helper.dart';
// import 'package:pstb/utils/api_url.dart';
//
// import '../app/models/data_signed_model_v2.dart';
// import '../app/models/data_signed_patient_model.dart';
// import '../app/models/detail_document_model.dart';
// import '../app/models/list_document_sign_model.dart';
//
// class ElectronicSignatureService {
//   final ApiBaseHelper apiBaseHelper;
//
//   ElectronicSignatureService({required this.apiBaseHelper});
//
//   // Future<Paging<DocumentModel>> getDocumentsSignature(
//   //     {required String? userName,
//   //     required String? roleCode,
//   //     int? pageIndex = 0}) async {
//   //   final data = await apiBaseHelper.get(
//   //       ApiUrl.getDocuments,
//   //       {
//   //         'userName': userName,
//   //         'roleCode': roleCode,
//   //         'pageIndex': pageIndex,
//   //         'pageSize': 10
//   //       },
//   //       const Duration(seconds: 20));
//   //   return Paging<DocumentModel>.fromJson(data, (value) {
//   //     return DocumentModel.fromJson(value);
//   //   });
//   // }
//
//   Future<Paging<DocumentModel>> getDocumentsSignatureV2(
//       {required String? userId,
//       required String? roleId,
//       int? pageIndex = 0}) async {
//     final data = await apiBaseHelper.postDocs(
//       ApiUrl.getDocumentsV2,
//       {
//         "userId": userId,
//         "signatureRoleId": roleId,
//         "sortType": 0,
//         "sortDirection": 0
//       },
//       //const Duration(seconds: 20),
//     );
//     final docResult = ListResult<DocumentModel>.fromJson(
//       data,
//       (json) => DocumentModel.fromJson(json as Map<String, dynamic>),
//     );
//
//     return convertToPaging<DocumentModel>(
//       docResult,
//     );
//   }
//
//   Paging<T> convertToPaging<T>(ListResult<T> result) {
//     return Paging<T>(
//       total: result.totalCount,
//       items: result.items,
//       pageIndex: 0,
//       pageSize: result.items?.length,
//       count: result.items?.length,
//       countOfPage: null,
//     );
//   }
//
//   // Future<List<SignRolesModel>> getSigners({required String? userName}) async {
//   //   List<SignRolesModel> roleSigners = [];
//   //   final data = await apiBaseHelper.get(ApiUrl.getRoles,
//   //       {'username': userName}, const Duration(seconds: 20), headers);
//   //   final rollSigners = data.map((e) => SignRolesModel.fromJson(e)).toList();
//   //   for (final role in rollSigners) {
//   //     roleSigners.add(role);
//   //   }
//   //   return roleSigners;
//   // }
//
//   Future<List<SignRolesModel>> getSigners({required String userName}) async {
//     List<SignRolesModel> roleSigners = [];
//     final data = await apiBaseHelper.getDocs(
//         ApiUrl.getRolesV2 + userName, {}, const Duration(seconds: 20), headers);
//     print("haha $data");
//     final rollSigners = data.map((e) => SignRolesModel.fromJson(e)).toList();
//     for (final role in rollSigners) {
//       roleSigners.add(role);
//     }
//     return roleSigners;
//   }
//
//   // Future<SignedDoucmentModel?> signDocument(
//   //     {required String? userName,
//   //     required String? roleCode,
//   //     required List<String> ids}) async {
//   //   final data = await apiBaseHelper.put(
//   //       ApiUrl.sign,
//   //       jsonEncode({"UserName": userName, "RoleCode": roleCode, "Ids": ids}),
//   //       headers,
//   //       null,
//   //       true);
//   //   return data == null
//   //       ? null
//   //       : (data != true)
//   //           ? SignedDoucmentModel.fromJson(data)
//   //           : SignedDoucmentModel(isTempSuccess: true);
//   // }
//
//   Future<SignedDocumentModelV2?> signDocumentDocs({
//     required String? userName,
//     required String? roleId,
//     required String? tag,
//     required List<String> ids,
//   }) async {
//     final signatureDtoList = ids.map((id) {
//       return {
//         "documentId": id,
//         "tag": tag, // Nếu bạn có tên, truyền vào
//
//         "ownerId": userName,
//       };
//     }).toList();
//
//     final requestBody = {
//       "ownerId": userName,
//       "signatureDto": signatureDtoList,
//       "roleId": roleId,
//     };
//
//     final data = await apiBaseHelper.postDocs(
//       ApiUrl.signV2,
//       requestBody,
//     );
//
//     print("sign data $data");
//
//     return data == null ? null : SignedDocumentModelV2.fromJson(data);
//   }
//
//   // Future<SignedDoucmentModel> revokeSignatures(
//   //     {required String? userName, required List<String> ids}) async {
//   //   final data = await apiBaseHelper.put(
//   //       ApiUrl.revokeSignatureV2, jsonEncode({"": userName, "ids": ids}));
//   //   return SignedDoucmentModel.fromJson(data);
//   // }
//
//   Future<SignedDocumentModelV2?> revokeSignatures({
//     required String? userName,
//     required List<String> ids,
//     required String documentTypeId,
//   }) async {
//     final data = await apiBaseHelper.postDocs(ApiUrl.revokeSignatureV2, {
//       "loginName": userName,
//       "documentIds": ids,
//       "documentTypeId": documentTypeId,
//     });
//     print(" sign data $data");
//     return data == null ? null : SignedDocumentModelV2.fromJson(data);
//   }
//
//   Future<DetailDocumentModel?> detailDocument({required String url}) async {
//     final data = await apiBaseHelper.getDocs(url);
//     print(" sign data $data");
//     return data == null ? null : DetailDocumentModel.fromJson(data);
//   }
//
//   Future<DataSignedPatientModel> patientPrepare(
//       {required List<String> ids, required String documentTypeCode}) async {
//     final data = await apiBaseHelper.put(
//       ApiUrl.patientPrepareSigning,
//       jsonEncode({
//         "ids": ids,
//         "documentTypeCode": documentTypeCode,
//       }),
//     );
//     return DataSignedPatientModel.fromJson(data);
//   }
// }

import 'dart:convert';

import 'package:pstb/app/models/data_signed_model.dart';
import 'package:pstb/app/models/electronic_signature_model.dart';
import 'package:pstb/app/models/paging_model.dart';
import 'package:pstb/app/models/sign_roles_model.dart';
import 'package:pstb/services/api_base_helper.dart';
import 'package:pstb/utils/api_url.dart';

import '../app/models/data_signed_patient_model.dart';

class ElectronicSignatureService {
  final ApiBaseHelper apiBaseHelper;

  ElectronicSignatureService({required this.apiBaseHelper});

  Future<Paging<DocumentModel>> getDocumentsSignature(
      {required String? userName,
      required String? roleCode,
      int? pageIndex = 0}) async {
    final data = await apiBaseHelper.get(
        ApiUrl.getDocuments,
        {
          'userName': userName,
          'roleCode': roleCode,
          'pageIndex': pageIndex,
          'pageSize': 10
        },
        const Duration(seconds: 20));
    return Paging<DocumentModel>.fromJson(data, (value) {
      return DocumentModel.fromJson(value);
    });
  }

  Future<List<SignRolesModel>> getSigners({required String? userName}) async {
    List<SignRolesModel> roleSigners = [];
    final data = await apiBaseHelper.get(ApiUrl.getRoles,
        {'username': userName}, const Duration(seconds: 20), headers);
    final rollSigners = data.map((e) => SignRolesModel.fromJson(e)).toList();
    for (final role in rollSigners) {
      roleSigners.add(role);
    }
    return roleSigners;
  }

  Future<SignedDoucmentModel> signDocument(
      {required String? userName,
      required String? roleCode,
      required List<String> ids}) async {
    final data = await apiBaseHelper.put(
        ApiUrl.sign,
        jsonEncode({"UserName": userName, "RoleCode": roleCode, "Ids": ids}),
        headers);
    return SignedDoucmentModel.fromJson(data);
  }

  Future<SignedDoucmentModel> revokeSignatures(
      {required String? userName, required List<String> ids}) async {
    final data = await apiBaseHelper.put(
        ApiUrl.revokeSignature, jsonEncode({"username": userName, "ids": ids}));
    return SignedDoucmentModel.fromJson(data);
  }

  Future<DataSignedPatientModel> patientPrepare(
      {required List<String> ids, required String documentTypeCode}) async {
    final data = await apiBaseHelper.put(
      ApiUrl.patientPrepareSigning,
      jsonEncode({
        "ids": ids,
        "documentTypeCode": documentTypeCode,
      }),
    );
    return DataSignedPatientModel.fromJson(data);
  }
}
