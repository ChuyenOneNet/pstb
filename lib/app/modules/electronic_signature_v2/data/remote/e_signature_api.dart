import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

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

import '../../../../../../core/base/base_response.dart';
import '../signed_models.dart'; // <-- thêm import

part 'e_signature_api.g.dart';

@RestApi()
abstract class ESignatureApi {
  factory ESignatureApi(Dio dio, {String baseUrl}) = _ESignatureApi;

  // ---- V1 ONLY ----

  // Documents (query by userName/roleCode/paging)  <-- BỌC BASE
  @GET('/api/signing/document')
  Future<StatusDataResponse<Paging<DocumentModel>>> getDocumentsV1(
    @Queries() Map<String, dynamic> query,
  );

  // (filter cũng dùng cùng endpoint)  <-- BỌC BASE
  @GET('/api/signing/document')
  Future<StatusDataResponse<Paging<DocumentModel>>> getDocumentsWithFilterV1(
    @Queries() Map<String, dynamic> query,
  );

  // Roles (không phân trang -> giữ nguyên)
  @GET('/api/signing/signer-roles')
  Future<StatusListResponse<SignRolesModel>> getRolesV1(
    @Queries() Map<String, dynamic> query,
  );

  // Sign/Revoke (giữ nguyên)
  @PUT('/api/signing/document/sign')
  Future<StatusDataResponse<SignedDocData?>> signV1(
      @Body() Map<String, dynamic> body);

  @PUT('/api/signing/document/revoke-signature')
  Future<StatusDataResponse<SignedDocData?>> revokeV1(
      @Body() Map<String, dynamic> body);

  // Patient prepare (giữ nguyên)
  @PUT('/api/signing/patient/prepare')
  Future<DataSignedPatientModel> patientPrepare(
    @Body() Map<String, dynamic> body,
  );

  // Detail (giữ nguyên)
  @GET('/api/signing/document/detail')
  Future<DetailDocumentModel?> getDetailByQuery(
    @Queries() Map<String, dynamic> query,
  );

  // Lookups (PHÂN TRANG)  <-- BỌC BASE
  @GET('/api/signing/department')
  Future<StatusDataResponse<Paging<DepartmentModel>>> getDepartments(
    @Queries() Map<String, dynamic> query,
  );

  @GET('/api/signing/document/document-type')
  Future<StatusDataResponse<Paging<TypeDocumentModel>>> getTypeDocuments(
    @Queries() Map<String, dynamic> query,
  );

  @GET('/api/signing/patient')
  Future<StatusDataResponse<Paging<PatientModel>>> getPatients(
    @Queries() Map<String, dynamic> query,
  );
}
