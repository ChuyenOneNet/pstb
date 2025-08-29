import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:pstb/app/models/department_model.dart';
import 'package:pstb/app/models/document_type_model.dart';
import 'package:pstb/app/models/filter_signature_model.dart';
import 'package:pstb/app/models/paging_model.dart';
import 'package:pstb/app/models/patient_model.dart';
import 'package:pstb/app/models/sign_roles_model.dart';
import 'package:pstb/app/modules/nurse_page/electronic_signature/electronic_signature_store.dart';
import 'package:pstb/app/modules/nurse_page/nurse_searching_store.dart';
import 'package:pstb/services/api_exception.dart';
import 'package:pstb/services/filter_signature_service.dart';
import 'package:pstb/utils/main.dart';
import 'package:mobx/mobx.dart';
part 'filter_signature_store.g.dart';

class FilterSignatureStore = _FilterSignatureStoreBase
    with _$FilterSignatureStore;

abstract class _FilterSignatureStoreBase with Store {
  final _nurseController = Modular.get<NurseSearchingStore>();
  final _electronicSignatureStore = Modular.get<ElectronicSignatureStore>();
  final _filterSignatureService = Modular.get<FilterSignatureService>();
  @observable
  String? fromDate;
  @observable
  String? toDate;
  @observable
  int? idSigningStatus;
  @observable
  String? roleSigning;
  @observable
  String? roleCode;
  @observable
  String? nameSigningStatus;
  @observable
  bool isLoading = false;
  @observable
  Paging<DepartmentModel> pagingDepartment = Paging();
  @observable
  List<SignRolesModel> signers = [];
  @observable
  Paging<PatientModel> pagingPatient = Paging();
  @observable
  Paging<TypeDocumentModel> pagingTypeDocument = Paging();
  @observable
  String? typeDocument;
  @observable
  DepartmentModel? departmentModelSelected;
  @observable
  PatientModel? patientModelSelected;
  String? documentTypeCode;
  String? _keywordTypeDocument;
  String? _keywordDepartment;
  String? _keywordPatient;
  String? searchValue;
  String resultError = '';
  @action
  void initState() {
    toDate = fromDate = nameSigningStatus = roleCode = typeDocument =
        documentTypeCode = idSigningStatus =
            departmentModelSelected = patientModelSelected = null;
    signers = _electronicSignatureStore.rolesSign;
    var seen = Set<String>();
    signers = signers.where((signModel) => seen.add(signModel.name!)).toList();
  }

  @action
  void clearStateFilter() {
    toDate = fromDate = nameSigningStatus = typeDocument =
        idSigningStatus = departmentModelSelected = patientModelSelected = null;
  }

  @action
  void onChangeStartDate(DateTime start) {
    fromDate = DateFormat(DateTimeFormatPattern.dobddMMyyyy).format(start);
  }

  @action
  void onChangeSigningStatus({int? signingStatusSelected}) {
    idSigningStatus = signingStatusSelected;
  }

  @action
  void onChangeEndDate(DateTime end) {
    toDate = DateFormat(DateTimeFormatPattern.dobddMMyyyy).format(end);
  }

  @action
  void onChangedValueSearch({String? value}) {
    searchValue = value;
  }

  @action
  Future<void> onSearchDepartment({String? keyword}) async {
    _keywordDepartment = keyword;
    try {
      pagingDepartment = await _filterSignatureService.getDepartments(
          value: _keywordDepartment);
    } catch (e) {
      pagingDepartment.items = null;
    }
  }

  @action
  Future<void> onSearchTypeDocuments({String? keyword}) async {
    _keywordTypeDocument = keyword;
    try {
      pagingTypeDocument = await _filterSignatureService.getTypeDocument(
          value: _keywordTypeDocument);
    } catch (e) {
      pagingTypeDocument.items = null;
    }
  }

  @action
  Future<void> onSearchPatient({required String search}) async {
    _keywordPatient = search;
    try {
      isLoading = true;
      if (_keywordPatient!.isEmpty) {
        pagingPatient.items = List.empty(growable: true);
        isLoading = false;
      } else {
        pagingPatient = await _filterSignatureService.getPatients(
            value: _keywordPatient ?? '');
        isLoading = false;
      }
    } catch (e) {
      pagingPatient.items = List.empty(growable: true);
      isLoading = false;
    }
  }

  @action
  Future<void> onLoadMorePatients() async {
    if (pagingPatient.isEnded()) return;
    pagingPatient.pageIndex = pagingPatient.pageIndex! + 1;
    try {
      isLoading = true;
      if (_keywordPatient == null || _keywordPatient!.isEmpty) {
        pagingPatient.items = null;
        return;
      }
      final data = await _filterSignatureService.getPatients(
          value: _keywordPatient!, pageIndex: pagingPatient.pageIndex);
      pagingPatient.items!.addAll(data.items ?? []);
      isLoading = false;
    } catch (e) {
      isLoading = false;
      pagingPatient.items!.addAll([]);
    }
  }

  @action
  Future<void> onConfirmFilter() async {
    try {
      _electronicSignatureStore.documentPagination =
          await _filterSignatureService.getDocuments(
              filterSignatureModel: FilterSignatureModel(
                  userName: _nurseController.nurseModel.code,
                  roleCode: roleCode,
                  searchValue: searchValue,
                  idSigningStatus: idSigningStatus,
                  documentTypeCode: documentTypeCode,
                  fromDate: fromDate,
                  toDate: toDate,
                  departmentCode: departmentModelSelected?.code,
                  patientCode: patientModelSelected?.code));
      _electronicSignatureStore.nameRoll =
          signers.firstWhere((element) => element.code == roleCode).name;
      _electronicSignatureStore.signerRoll =
          signers.firstWhere((element) => element.code == roleCode);
      _electronicSignatureStore.selectedDocuments = List.generate(
          _electronicSignatureStore.documentPagination.items!.length,
          (index) => false);
    } on AppException catch (e) {
      resultError = e.toString();
      _electronicSignatureStore.documentPagination.items = null;
      _electronicSignatureStore.nameRoll = null;
    }
  }

  @action
  void onSelectedPatient({required PatientModel patient}) {
    patientModelSelected = patient;
  }

  @action
  void onSelectedDepartment({required DepartmentModel departmentModel}) {
    departmentModelSelected = departmentModel;
  }

  @action
  void onChangeRollSigner(String? value) {
    roleCode = value;
  }

  @action
  void onSelectedTypeDocument(
      {required TypeDocumentModel typeDocumentModelSelected}) {
    typeDocument = typeDocumentModelSelected.name;
    documentTypeCode = typeDocumentModelSelected.code;
  }

  @action
  Future<void> onLoadMoreTypeDocument() async {
    if (pagingTypeDocument.isEnded()) return;
    pagingTypeDocument.pageIndex = pagingTypeDocument.pageIndex! + 1;
    try {
      isLoading = true;
      final response = await _filterSignatureService.getTypeDocument(
          value: _keywordTypeDocument, pageIndex: pagingTypeDocument.pageIndex);
      pagingTypeDocument.items!
          .addAll(List.from(response.items!, growable: true));
      isLoading = false;
    } catch (e) {
      pagingTypeDocument.items = null;
    }
  }

  @action
  Future<void> onLoadMoreDepartment() async {
    if (pagingDepartment.isEnded()) return;
    pagingDepartment.pageIndex = pagingDepartment.pageIndex! + 1;
    try {
      isLoading = true;
      final response = await _filterSignatureService.getDepartments(
          value: _keywordDepartment, pageIndex: pagingDepartment.pageIndex);
      pagingDepartment.items!
          .addAll(List.from(response.items!, growable: true));
      isLoading = false;
    } catch (e) {
      pagingDepartment.items = null;
    }
  }

  @action
  Future<void> onLoadedPatient({required String patientCode}) async {
    try {
      patientModelSelected =
          await _filterSignatureService.getPatient(patientCode: patientCode);
    } catch (e) {
      patientModelSelected = null;
    }
  }
}
