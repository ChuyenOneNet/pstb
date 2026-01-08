import 'package:pstb/app/models/paging_model.dart';
import 'package:pstb/app/models/electronic_signature_model.dart';
import 'package:pstb/app/models/sign_roles_model.dart';
import 'package:pstb/app/models/data_signed_model.dart';
import 'package:pstb/app/models/data_signed_patient_model.dart';
import 'package:pstb/app/models/detail_document_model.dart';
import 'package:pstb/app/models/department_model.dart';
import 'package:pstb/app/models/document_type_model.dart';
import 'package:pstb/app/models/patient_model.dart';
import '../../../../../../core/base/base_response.dart';
import '../filter_signature_model.dart';
import '../remote/e_signature_api.dart'; // <-- thêm import
import '../remote/e_signature_role_api.dart';
import 'signature_repository.dart';

class SignatureRepositoryImpl implements SignatureRepository {
  final ESignatureApi api;
  final ESignatureRoleApi roleApi;
  SignatureRepositoryImpl(this.api, this.roleApi);

  // Helper: unwrap base {status,data}
  T _unwrap<T>(StatusDataResponse<T> wrap) {
    if (wrap.status == true && wrap.data != null) return wrap.data as T;
    final msg = (wrap.errors != null && wrap.errors!.isNotEmpty)
        ? (wrap.errors!.first.message ?? 'Unknown error')
        : 'Unknown error';
    throw Exception(msg);
  }

  List<T> _unwrapList<T>(StatusListResponse<T> wrap) {
    if (wrap.ok) return wrap.data!;
    final msg =
        wrap.errorMessage.isNotEmpty ? wrap.errorMessage : 'Unknown error';
    throw Exception(msg);
  }

  List<T> _unwrapListV2<T>(StatusListResponseV2<T> wrap) {
    if (wrap.ok) return wrap.data!;
    final msg =
        wrap.errorMessage.isNotEmpty ? wrap.errorMessage : 'Unknown error';
    throw Exception(msg);
  }

  Map<String, dynamic> _clean(Map<String, dynamic> m) {
    m.removeWhere((k, v) => v == null || (v is String && v.trim().isEmpty));
    return m;
  }

  // Roles/Documents
  @override
  Future<List<SignRolesModel>> getRolesV1(String userName) async {
    // ESignatureApi.getRolesV1 phải trả về StatusListResponse<SignRolesModel>
    final wrap = await api.getRolesV1({'username': userName});
    return _unwrapList<SignRolesModel>(wrap);
  }

  @override
  Future<Paging<DocumentModel>> getDocumentsV1({
    required String userName,
    required String roleCode,
    int pageIndex = 0,
    int pageSize = 10,
  }) async {
    final wrap = await api.getDocumentsV1(_clean({
      'userName': userName,
      'roleCode': roleCode,
      'pageIndex': pageIndex,
      'pageSize': pageSize,
      'offset': pageIndex * pageSize,
    }));
    return _unwrap<Paging<DocumentModel>>(wrap);
  }

  @override
  Future<Paging<DocumentModel>> getDocumentsWithFilterV1(
      FilterSignatureModelV2 filter) async {
    // đảm bảo có mặc định pageIndex/pageSize/offset
    //final f = filter.copyWithDefaults(pageIndex: 0, pageSize: 9999);
    final qp = _clean(filter.toJson()
        // ..addAll({
        //   'PageIndex': f.pageIndex ?? 0,
        //   'PageSize': f.pageSize ?? 10,
        //   'Offset': (f.pageIndex ?? 0) * (f.pageSize ?? 10),
        // })
        );
    final wrap = await api.getDocumentsWithFilterV1(qp);
    return _unwrap<Paging<DocumentModel>>(wrap);
  }

  // Sign/Revoke (không bọc base)
  @override
  Future<SignedDoucmentModel> signV1({
    required String userName,
    required String roleCode,
    required List<String> ids,
  }) async {
    final wrap = await api.signV1({
      'UserName': userName,
      'RoleCode': roleCode,
      'Ids': ids,
    });

    // sign: có thể ok nhưng data=null
    final ok = wrap.ok;
    final data = wrap.data; // SignedDocData? (null với response hiện tại)
    return SignedDoucmentModel(
      isTempSuccess: ok,
      message: data?.message ?? (ok ? 'Ký thành công' : wrap.errorMessage),
      ids: data?.ids ?? const [],
    );
  }

  @override
  Future<SignedDoucmentModel> revokeV1({
    required String userName,
    required List<String> ids,
  }) async {
    final wrap = await api.revokeV1({
      'username': userName,
      'ids': ids,
    });

    // revoke: thường có data { ids, message }
    final ok = wrap.ok;
    final data = wrap.data; // SignedDocData?
    return SignedDoucmentModel(
      isTempSuccess: ok,
      message: data?.message ?? (ok ? 'Thu hồi thành công' : wrap.errorMessage),
      ids: data?.ids ?? const [],
    );
  }

  // Misc
  @override
  Future<DataSignedPatientModel> patientPrepare({
    required List<String> ids,
    required String documentTypeCode,
  }) =>
      api.patientPrepare({'ids': ids, 'documentTypeCode': documentTypeCode});

  @override
  Future<DetailDocumentModel?> getDetailByUrl(String absoluteUrl) async {
    final uri = Uri.parse(absoluteUrl);
    return api.getDetailByQuery(Map.from(uri.queryParameters));
  }

  // Lookups (PHÂN TRANG) -> unwrap base
  @override
  Future<Paging<DepartmentModel>> getDepartments(
      {String? keyword, int? pageIndex = 0}) async {
    final wrap = await api.getDepartments(_clean({
      'Keyword': keyword,
      'PageIndex': pageIndex,
      'PageSize': 9999,
    }));
    return _unwrap<Paging<DepartmentModel>>(wrap);
  }

  @override
  Future<Paging<TypeDocumentModel>> getTypeDocuments(
      {String? keyword, int? pageIndex = 0}) async {
    final wrap = await api.getTypeDocuments(_clean({
      'Keyword': keyword,
      'PageIndex': pageIndex,
      'PageSize': 9999,
    }));
    return _unwrap<Paging<TypeDocumentModel>>(wrap);
  }

  @override
  Future<Paging<PatientModel>> getPatients(
      {required String keyword, int? pageIndex = 0}) async {
    final wrap = await api.getPatients({
      'Keyword': keyword,
      'PageIndex': pageIndex,
    });
    return _unwrap<Paging<PatientModel>>(wrap);
  }

  @override
  Future<List<SignRolesModel>> getSignerRolesForDocument({
    required String userName,
    required String documentId,
  }) async {
    final raw = await roleApi.getSignerRolesForDocument({
      'userName': userName,
      'documentId': documentId,
    });
    final result = _unwrapListV2<SignRolesModel>(raw);

    return result;
  }
}
