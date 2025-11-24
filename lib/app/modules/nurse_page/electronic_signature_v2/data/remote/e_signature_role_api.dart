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

part 'e_signature_role_api.g.dart';

@RestApi()
abstract class ESignatureRoleApi {
  factory ESignatureRoleApi(Dio dio, {String baseUrl}) = _ESignatureRoleApi;

  @GET('/api/App/signer-roles')
  Future<StatusListResponseV2<SignRolesModel>> getSignerRolesForDocument(
    @Queries() Map<String, dynamic> query,
  );
}
