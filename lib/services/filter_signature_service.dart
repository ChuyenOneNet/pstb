// import 'package:pstb/app/models/department_model.dart';
// import 'package:pstb/app/models/document_type_model.dart';
// import 'package:pstb/app/models/electronic_signature_model.dart';
// import 'package:pstb/app/models/filter_signature_model.dart';
// import 'package:pstb/app/models/paging_model.dart';
// import 'package:pstb/app/models/patient_model.dart';
// import 'package:pstb/services/api_base_helper.dart';
// import 'package:pstb/utils/api_url.dart';
//
// import '../app/models/list_document_sign_model.dart';
//
// class FilterSignatureService {
//   final ApiBaseHelper apiBaseHelper;
//
//   FilterSignatureService({required this.apiBaseHelper});
//
//   // Future<Paging<DepartmentModel>> getDepartments(
//   //     {String? value, int? pageIndex}) async {
//   //   Paging<DepartmentModel> pagingDepartments = Paging();
//   //   final data = await apiBaseHelper.get(
//   //     ApiUrl.signDepartment,
//   //     {'keyword': value, 'pageIndex': pageIndex},
//   //     // const Duration(seconds: 20),
//   //     // headers,
//   //   );
//   //   pagingDepartments = Paging.fromJson(data, (item) {
//   //     return DepartmentModel.fromJson(item);
//   //   });
//   //   return pagingDepartments;
//   // }
//   Future<Paging<DepartmentModel>> getDepartments(
//       {String? value, int? pageIndex}) async {
//     Paging<DepartmentModel> pagingDepartments = Paging();
//     var MaxResultCount = 15;
//     final data = await apiBaseHelper.getDocs(
//       ApiUrl.documentTypeV2,
//       {
//         'keyword': value,
//         'SkipCount': ((pageIndex ?? 0) * MaxResultCount),
//         'MaxResultCount': 15,
//         //'pageIndex': pageIndex
//       },
//       // const Duration(seconds: 20),
//       // headers,
//     );
//     final docResult = ListResult<DepartmentModel>.fromJson(
//       data,
//       (json) => DepartmentModel.fromJson(json as Map<String, dynamic>),
//     );
//
//     return convertToPaging<DepartmentModel>(
//       docResult,
//     );
//   }
//
//   // Future<Paging<DocumentModel>> getDocuments(
//   //     {FilterSignatureModel? filterSignatureModel}) async {
//   //   Paging<DocumentModel> pagingDocuments = Paging();
//   //   final data = await apiBaseHelper.get(
//   //     ApiUrl.getDocuments,
//   //     filterSignatureModel?.toJson(),
//   //     // const Duration(seconds: 20),
//   //     // headers,
//   //   );
//   //   pagingDocuments = Paging.fromJson(data, (item) {
//   //     return DocumentModel.fromJson(item);
//   //   });
//   //   return pagingDocuments;
//   // }
//   Future<Paging<DocumentModel>> getDocuments(
//       {FilterSignatureModel? filterSignatureModel, String? userName}) async {
//     print(filterSignatureModel?.toJson());
//     // final data = await apiBaseHelper.postDocs(
//     //   ApiUrl.getDocumentsV2,
//     //   filterSignatureModel,
//     //   //const Duration(seconds: 20),
//     // );
//     final data = await apiBaseHelper.postDocs(
//       "/api/treereference/get-filtered-signbatch",
//       filterSignatureModel,
//       {"userName": userName},
//     );
//     print("data $data");
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
//   Future<Paging<PatientModel>> getPatients(
//       {required String value, int? pageIndex}) async {
//     Paging<PatientModel> pagingPatient = Paging();
//     final data = await apiBaseHelper.get(
//       ApiUrl.signPatient,
//       {'keyword': value, 'pageIndex': pageIndex},
//       // const Duration(seconds: 20),
//       // headers
//     );
//     pagingPatient = Paging.fromJson(data, (item) {
//       return PatientModel.fromJson(item);
//     });
//     return pagingPatient;
//   }
//
//   Future<Paging<TypeDocumentModel>> getTypeDocument(
//       {String? value, int? pageIndex}) async {
//     Paging<TypeDocumentModel> listTypeDocuments = Paging();
//     var MaxResultCount = 15;
//     final data = await apiBaseHelper.getDocs(
//       ApiUrl.documentTypeV2,
//       {
//         'keyword': value,
//         'SkipCount': ((pageIndex ?? 0) * MaxResultCount),
//         'MaxResultCount': 15,
//         //'pageIndex': pageIndex
//       },
//       // const Duration(seconds: 20),
//       // headers,
//     );
//     final docResult = ListResult<TypeDocumentModel>.fromJson(
//       data,
//       (json) => TypeDocumentModel.fromJson(json as Map<String, dynamic>),
//     );
//
//     return convertToPaging<TypeDocumentModel>(
//       docResult,
//     );
//     // listTypeDocuments = Paging.fromJson(data, (item) {
//     //   return TypeDocumentModel.fromJson(item);
//     // });
//     // return listTypeDocuments;
//   }
//
//   Future<PatientModel> getPatient({required String patientCode}) async {
//     final response = await apiBaseHelper.get(ApiUrl.staffPatient, {
//       'patientCode': patientCode,
//     });
//     return PatientModel.fromJson(response);
//   }
// }

import 'package:pstb/app/models/department_model.dart';
import 'package:pstb/app/models/document_type_model.dart';
import 'package:pstb/app/models/electronic_signature_model.dart';
import 'package:pstb/app/models/filter_signature_model.dart';
import 'package:pstb/app/models/paging_model.dart';
import 'package:pstb/app/models/patient_model.dart';
import 'package:pstb/services/api_base_helper.dart';
import 'package:pstb/utils/api_url.dart';

class FilterSignatureService {
  final ApiBaseHelper apiBaseHelper;

  FilterSignatureService({required this.apiBaseHelper});

  Future<Paging<DepartmentModel>> getDepartments(
      {String? value, int? pageIndex}) async {
    Paging<DepartmentModel> pagingDepartments = Paging();
    final data = await apiBaseHelper.get(
      ApiUrl.signDepartment,
      {'keyword': value, 'pageIndex': pageIndex},
      // const Duration(seconds: 20),
      // headers,
    );
    pagingDepartments = Paging.fromJson(data, (item) {
      return DepartmentModel.fromJson(item);
    });
    return pagingDepartments;
  }

  Future<Paging<DocumentModel>> getDocuments(
      {FilterSignatureModel? filterSignatureModel}) async {
    Paging<DocumentModel> pagingDocuments = Paging();
    final data = await apiBaseHelper.get(
      ApiUrl.getDocuments,
      filterSignatureModel?.toJson(),
      // const Duration(seconds: 20),
      // headers,
    );
    pagingDocuments = Paging.fromJson(data, (item) {
      return DocumentModel.fromJson(item);
    });
    return pagingDocuments;
  }

  Future<Paging<PatientModel>> getPatients(
      {required String value, int? pageIndex}) async {
    Paging<PatientModel> pagingPatient = Paging();
    final data = await apiBaseHelper.get(
      ApiUrl.signPatient,
      {'keyword': value, 'pageIndex': pageIndex},
      // const Duration(seconds: 20),
      // headers
    );
    pagingPatient = Paging.fromJson(data, (item) {
      return PatientModel.fromJson(item);
    });
    return pagingPatient;
  }

  Future<Paging<TypeDocumentModel>> getTypeDocument(
      {String? value, int? pageIndex}) async {
    Paging<TypeDocumentModel> listTypeDocuments = Paging();
    final data = await apiBaseHelper.get(
      ApiUrl.documentType,
      {'keyword': value, 'pageIndex': pageIndex},
      // const Duration(seconds: 20),
      // headers,
    );
    listTypeDocuments = Paging.fromJson(data, (item) {
      return TypeDocumentModel.fromJson(item);
    });
    return listTypeDocuments;
  }

  Future<PatientModel> getPatient({required String patientCode}) async {
    final response = await apiBaseHelper.get(ApiUrl.staffPatient, {
      'patientCode': patientCode,
    });
    return PatientModel.fromJson(response);
  }
}
