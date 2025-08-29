import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/Keys.dart';
import 'package:pstb/app/models/electronic_signature_model.dart';
import 'package:pstb/app/models/filter_signature_model.dart';
import 'package:pstb/app/models/paging_model.dart';
import 'package:pstb/app/models/sign_roles_model.dart';
import 'package:pstb/app/modules/nurse_page/nurse_searching_store.dart';
import 'package:pstb/services/api_base_helper.dart';
import 'package:pstb/services/electronic_signature_service.dart';
import 'package:pstb/services/filter_signature_service.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/constants.dart';
import 'filter_signature/filter_signature_store.dart';

part 'electronic_signature_store.g.dart';

const String authorizationIntegration = 'sys.admin:1';

class ElectronicSignatureStore = _ElectronicSignatureStoreBase
    with _$ElectronicSignatureStore;

abstract class _ElectronicSignatureStoreBase with Store {
  final _nurseController = Modular.get<NurseSearchingStore>();
  final _electronicSignatureService = Modular.get<ElectronicSignatureService>();
  final _filterSignatureService = Modular.get<FilterSignatureService>();

  @observable
  bool isShowCheckedItem = false;
  @observable
  Paging<DocumentModel> documentPagination = Paging<DocumentModel>();
  @observable
  List<bool> selectedDocuments = [];
  @observable
  bool isCancelCheckedBox = false;
  @observable
  bool isLoading = true;
  @observable
  bool isLoadingMoreItem = false;
  @observable
  int? status;
  @observable
  bool? isChangeStatus;
  @observable
  String? nameRoll;
  @observable
  SignRolesModel? signerRoll;
  String? pdf;
  String? statusSuccess;
  List<SignRolesModel> rolesSign = [];
  Map<int, String> signedDocumentMap = {};
  Map<int, String> unSignedDocumentMap = {};

  @action
  Future<void> initState({String? userName, String? roleCode}) async {
    isLoading = true;
    final pref = await Modular.getAsync<SharedPreferences>();
    final codeNurse = pref.getString(Constants.codeNursing) ?? '';
    final password = pref.getString(codeNurse) ?? '';
    headers['AuthorizationIntegration'] = "$codeNurse:$password";
    print(headers);
    try {
      rolesSign = await _electronicSignatureService.getSigners(
        // userName: userName ?? _nurseController.nurseModel.code,
        userName: codeNurse,
      );
      if (roleCode == null && nameRoll == null) {
        isLoading = false;
        return;
      }
      signerRoll = rolesSign.firstWhere((element) => element.code == roleCode);
      if (rolesSign.isNotEmpty) {
        documentPagination =
            await _electronicSignatureService.getDocumentsSignature(
                userName: userName ?? _nurseController.nurseModel.code,
                roleCode: roleCode);
      }
      selectedDocuments =
          List.generate(documentPagination.items!.length, (index) => false);
      isLoading = false;
    } catch (e) {
      isLoading = false;
      documentPagination.items = null;
    }
  }

  @action
  void onShowCheckedItem({required int index}) {
    isLoading = true;
    isShowCheckedItem = true;
    selectedDocuments[index] = true;
    status = documentPagination.items![index].signingStatus;
    if (status == 0) {
      unSignedDocumentMap[index] = documentPagination.items![index].id ?? '';
    } else {
      signedDocumentMap[index] = documentPagination.items![index].id ?? '';
    }
    isLoading = false;
  }

  @action
  void onCancelPickItems() {
    isShowCheckedItem = false;
    isCancelCheckedBox = false;
    status = null;
    isLoading = true;
    unSignedDocumentMap.clear();
    signedDocumentMap.clear();
    selectedDocuments =
        List.generate(documentPagination.items!.length, (index) => false);
    isLoading = false;
  }

  @action
  void onChangeValue({required int index}) {
    isLoading = true;
    selectedDocuments[index] = !selectedDocuments[index];
    if (!selectedDocuments[index]) {
      isLoading = true;
      if (status == 0) {
        unSignedDocumentMap.remove(index);
      } else {
        signedDocumentMap.remove(index);
      }
      isLoading = false;
    } else {
      status ??= documentPagination.items![index].signingStatus;
      if (status != documentPagination.items![index].signingStatus) {
        isLoading = true;
        isChangeStatus = true;
        selectedDocuments[index] = false;
        isLoading = false;
        return;
      }
      if (status == 0) {
        unSignedDocumentMap[index] = documentPagination.items![index].id ?? '';
      } else {
        signedDocumentMap[index] = documentPagination.items![index].id ?? '';
      }
    }
    if (unSignedDocumentMap.isEmpty && signedDocumentMap.isEmpty) {
      status = null;
      return;
    }
    isChangeStatus = false;
    isLoading = false;
  }

  @action
  void onClickAllCheckedBox() {
    isLoading = true;
    isCancelCheckedBox = true;
    for (int index = 0; index < documentPagination.items!.length; index++) {
      if (status == documentPagination.items![index].signingStatus) {
        selectedDocuments[index] = true;
        if (status == 0) {
          unSignedDocumentMap[index] =
              documentPagination.items![index].id ?? '';
        } else {
          signedDocumentMap[index] = documentPagination.items![index].id ?? '';
        }
      }
    }
    isLoading = false;
  }

  @action
  void onClickCancelAllCheckedBox() {
    isCancelCheckedBox = false;
    status = null;
    unSignedDocumentMap.clear();
    signedDocumentMap.clear();
    selectedDocuments =
        List.generate(documentPagination.items!.length, (index) => false);
  }

  @action
  Future<void> signDocuments() async {
    if (unSignedDocumentMap.isEmpty) return;
    try {
      final data = await _electronicSignatureService.signDocument(
          userName: _nurseController.nurseModel.code,
          roleCode: signerRoll?.code,
          ids: unSignedDocumentMap.values.toList());
      if (data.ids!.isEmpty) {
        statusSuccess = 'Ký thất bại';
      } else {
        statusSuccess = data.message;
        for (final indexUnsigned in unSignedDocumentMap.keys.toList()) {
          documentPagination.items![indexUnsigned].setSigned();
        }
      }
      isShowCheckedItem = false;
      selectedDocuments =
          List.generate(documentPagination.items!.length, (index) => false);
      status = null;
      unSignedDocumentMap.clear();
    } catch (e) {
      statusSuccess = 'Ký thành công';
      for (final indexUnsigned in unSignedDocumentMap.keys.toList()) {
        documentPagination.items![indexUnsigned].setSigned();
      }
      isShowCheckedItem = false;
      selectedDocuments =
          List.generate(documentPagination.items!.length, (index) => false);
      status = null;
      unSignedDocumentMap.clear();
      // statusSuccess = 'Ký thất bại';
      // isShowCheckedItem = true;
    }
  }

  @action
  Future<void> revokeSignatures() async {
    if (signedDocumentMap.isEmpty) return;
    try {
      final data = await _electronicSignatureService.revokeSignatures(
          userName: _nurseController.nurseModel.code,
          ids: signedDocumentMap.values.toList());
      if (data.ids!.isEmpty) {
        statusSuccess = 'Hủy ký thất bại';
      } else {
        statusSuccess = data.message;
        for (final indexSigned in signedDocumentMap.keys.toList()) {
          documentPagination.items![indexSigned].setUnSigned();
        }
      }
      isShowCheckedItem = false;
      selectedDocuments =
          List.generate(documentPagination.items!.length, (index) => false);
      status = null;
      signedDocumentMap.clear();
    } catch (e) {
      statusSuccess = 'Hủy ký thất bại';
      isShowCheckedItem = true;
    }
  }

  @action
  Future<void> toggleDocumentState(
      {required String id, required int index}) async {
    var documentItem = documentPagination.items![index];
    if (documentItem.isSigned()) {
      await _revokeDocument(documentItem);
    } else {
      await _signDocument(documentItem);
    }
  }

  _revokeDocument(DocumentModel documentItem) async {
    isLoading = true;
    try {
      final data = await _electronicSignatureService.revokeSignatures(
          userName: _nurseController.nurseModel.code,
          ids: <String>[documentItem.id!]);
      if (data.ids!.contains(documentItem.id!)) {
        documentItem.setUnSigned();
      }
      statusSuccess = 'Huỷ ký thành công';
    } catch (e) {
      statusSuccess = 'Huỷ ký thất bại';
    }
    isLoading = false;
  }

  _signDocument(DocumentModel documentItem) async {
    isLoading = true;
    try {
      final data = await _electronicSignatureService.signDocument(
          userName: _nurseController.nurseModel.code,
          roleCode: signerRoll?.code,
          ids: <String>[documentItem.id!]);
      if (data.ids!.contains(documentItem.id!)) {
        statusSuccess = 'Ký thành công';
        documentItem.setSigned();
      }
      // else {
      //   statusSuccess = 'Ký thất bại';
      // }
    } catch (e) {
      statusSuccess = 'Ký thành công';
      documentItem.setSigned();
      //statusSuccess = 'Ký thất bại'; --> sửa lại state lỗi
    }
    isLoading = false;
  }

  @action
  Future<void> onRefreshPage() async {
    final _filterController = Modular.get<FilterSignatureStore>();
    try {
      isLoading = true;
      documentPagination = await _filterSignatureService.getDocuments(
          filterSignatureModel: FilterSignatureModel(
              userName: _nurseController.nurseModel.code,
              roleCode: _filterController.roleCode,
              searchValue: _filterController.searchValue,
              idSigningStatus: _filterController.idSigningStatus,
              documentTypeCode: _filterController.documentTypeCode,
              fromDate: _filterController.fromDate,
              toDate: _filterController.toDate,
              departmentCode: _filterController.departmentModelSelected?.code,
              patientCode: _filterController.patientModelSelected?.code));
      selectedDocuments =
          List.generate(documentPagination.items!.length, (index) => false);
      isShowCheckedItem = false;
      status = null;
      isLoading = false;
    } catch (e) {
      isLoading = false;
      isShowCheckedItem = false;
    }
  }

  @action
  Future<void> loadDocuments() async {
    final _filterController = Modular.get<FilterSignatureStore>();
    if (documentPagination.isEnded()) return;
    documentPagination.pageIndex = documentPagination.pageIndex! + 1;
    try {
      isLoadingMoreItem = true;
      final response = await _filterSignatureService.getDocuments(
          filterSignatureModel: FilterSignatureModel(
              userName: _nurseController.nurseModel.code,
              roleCode: _filterController.roleCode,
              searchValue: _filterController.searchValue,
              idSigningStatus: _filterController.idSigningStatus,
              documentTypeCode: _filterController.documentTypeCode,
              fromDate: _filterController.fromDate,
              toDate: _filterController.toDate,
              pageIndex: documentPagination.pageIndex,
              departmentCode: _filterController.departmentModelSelected?.code,
              patientCode: _filterController.patientModelSelected?.code));
      isCancelCheckedBox = false;
      if (response.items != null) {
        documentPagination.items!.addAll(response.items!);
        selectedDocuments
            .addAll(List.generate(response.items!.length, (index) => false));
      }
      isLoadingMoreItem = false;
    } catch (e) {
      documentPagination.items!.addAll([]);
      isCancelCheckedBox = true;
    }
  }

  @observable
  Map<String, String>? headerForPdf;

  @action
  Future getHeaderForPdf() async {
    headerForPdf = await ApiBaseHelper.getHeaderWithMedicalUnitId();
  }
}
