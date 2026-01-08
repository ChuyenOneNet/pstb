import 'package:pstb/app/models/paging_model.dart';
import 'package:pstb/app/models/electronic_signature_model.dart';
import 'package:pstb/app/models/sign_roles_model.dart';
import 'package:pstb/app/models/data_signed_model.dart';
import 'package:pstb/app/models/data_signed_patient_model.dart';
import 'package:pstb/app/models/detail_document_model.dart';
import 'package:pstb/app/models/department_model.dart';
import 'package:pstb/app/models/document_type_model.dart';
import 'package:pstb/app/models/patient_model.dart';
import 'package:pstb/app/models/filter_signature_model.dart';

import '../filter_signature_model.dart';

abstract class SignatureRepository {
  // Roles/Documents (V1)
  Future<List<SignRolesModel>> getRolesV1(String userName);

  Future<Paging<DocumentModel>> getDocumentsV1({
    required String userName,
    required String roleCode,
    int pageIndex,
    int pageSize,
  });

  Future<Paging<DocumentModel>> getDocumentsWithFilterV1(
      FilterSignatureModelV2 filter);

  // Sign/Revoke (V1)
  Future<SignedDoucmentModel> signV1({
    required String userName,
    required String roleCode,
    required List<String> ids,
  });

  Future<SignedDoucmentModel> revokeV1({
    required String userName,
    required List<String> ids,
  });

  // Misc (V1)
  Future<DataSignedPatientModel> patientPrepare({
    required List<String> ids,
    required String documentTypeCode,
  });

  Future<DetailDocumentModel?> getDetailByUrl(String absoluteUrl);

  // Lookups (V1)
  Future<Paging<DepartmentModel>> getDepartments(
      {String? keyword, int? pageIndex});
  Future<Paging<TypeDocumentModel>> getTypeDocuments(
      {String? keyword, int? pageIndex});
  Future<Paging<PatientModel>> getPatients(
      {required String keyword, int? pageIndex});
  Future<List<SignRolesModel>> getSignerRolesForDocument({
    required String userName,
    required String documentId,
  });
}
