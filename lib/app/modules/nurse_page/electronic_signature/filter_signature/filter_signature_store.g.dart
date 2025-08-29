// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_signature_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FilterSignatureStore on _FilterSignatureStoreBase, Store {
  late final _$fromDateAtom =
      Atom(name: '_FilterSignatureStoreBase.fromDate', context: context);

  @override
  String? get fromDate {
    _$fromDateAtom.reportRead();
    return super.fromDate;
  }

  @override
  set fromDate(String? value) {
    _$fromDateAtom.reportWrite(value, super.fromDate, () {
      super.fromDate = value;
    });
  }

  late final _$toDateAtom =
      Atom(name: '_FilterSignatureStoreBase.toDate', context: context);

  @override
  String? get toDate {
    _$toDateAtom.reportRead();
    return super.toDate;
  }

  @override
  set toDate(String? value) {
    _$toDateAtom.reportWrite(value, super.toDate, () {
      super.toDate = value;
    });
  }

  late final _$idSigningStatusAtom =
      Atom(name: '_FilterSignatureStoreBase.idSigningStatus', context: context);

  @override
  int? get idSigningStatus {
    _$idSigningStatusAtom.reportRead();
    return super.idSigningStatus;
  }

  @override
  set idSigningStatus(int? value) {
    _$idSigningStatusAtom.reportWrite(value, super.idSigningStatus, () {
      super.idSigningStatus = value;
    });
  }

  late final _$roleSigningAtom =
      Atom(name: '_FilterSignatureStoreBase.roleSigning', context: context);

  @override
  String? get roleSigning {
    _$roleSigningAtom.reportRead();
    return super.roleSigning;
  }

  @override
  set roleSigning(String? value) {
    _$roleSigningAtom.reportWrite(value, super.roleSigning, () {
      super.roleSigning = value;
    });
  }

  late final _$roleCodeAtom =
      Atom(name: '_FilterSignatureStoreBase.roleCode', context: context);

  @override
  String? get roleCode {
    _$roleCodeAtom.reportRead();
    return super.roleCode;
  }

  @override
  set roleCode(String? value) {
    _$roleCodeAtom.reportWrite(value, super.roleCode, () {
      super.roleCode = value;
    });
  }

  late final _$nameSigningStatusAtom = Atom(
      name: '_FilterSignatureStoreBase.nameSigningStatus', context: context);

  @override
  String? get nameSigningStatus {
    _$nameSigningStatusAtom.reportRead();
    return super.nameSigningStatus;
  }

  @override
  set nameSigningStatus(String? value) {
    _$nameSigningStatusAtom.reportWrite(value, super.nameSigningStatus, () {
      super.nameSigningStatus = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_FilterSignatureStoreBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$pagingDepartmentAtom = Atom(
      name: '_FilterSignatureStoreBase.pagingDepartment', context: context);

  @override
  Paging<DepartmentModel> get pagingDepartment {
    _$pagingDepartmentAtom.reportRead();
    return super.pagingDepartment;
  }

  @override
  set pagingDepartment(Paging<DepartmentModel> value) {
    _$pagingDepartmentAtom.reportWrite(value, super.pagingDepartment, () {
      super.pagingDepartment = value;
    });
  }

  late final _$signersAtom =
      Atom(name: '_FilterSignatureStoreBase.signers', context: context);

  @override
  List<SignRolesModel> get signers {
    _$signersAtom.reportRead();
    return super.signers;
  }

  @override
  set signers(List<SignRolesModel> value) {
    _$signersAtom.reportWrite(value, super.signers, () {
      super.signers = value;
    });
  }

  late final _$pagingPatientAtom =
      Atom(name: '_FilterSignatureStoreBase.pagingPatient', context: context);

  @override
  Paging<PatientModel> get pagingPatient {
    _$pagingPatientAtom.reportRead();
    return super.pagingPatient;
  }

  @override
  set pagingPatient(Paging<PatientModel> value) {
    _$pagingPatientAtom.reportWrite(value, super.pagingPatient, () {
      super.pagingPatient = value;
    });
  }

  late final _$pagingTypeDocumentAtom = Atom(
      name: '_FilterSignatureStoreBase.pagingTypeDocument', context: context);

  @override
  Paging<TypeDocumentModel> get pagingTypeDocument {
    _$pagingTypeDocumentAtom.reportRead();
    return super.pagingTypeDocument;
  }

  @override
  set pagingTypeDocument(Paging<TypeDocumentModel> value) {
    _$pagingTypeDocumentAtom.reportWrite(value, super.pagingTypeDocument, () {
      super.pagingTypeDocument = value;
    });
  }

  late final _$typeDocumentAtom =
      Atom(name: '_FilterSignatureStoreBase.typeDocument', context: context);

  @override
  String? get typeDocument {
    _$typeDocumentAtom.reportRead();
    return super.typeDocument;
  }

  @override
  set typeDocument(String? value) {
    _$typeDocumentAtom.reportWrite(value, super.typeDocument, () {
      super.typeDocument = value;
    });
  }

  late final _$departmentModelSelectedAtom = Atom(
      name: '_FilterSignatureStoreBase.departmentModelSelected',
      context: context);

  @override
  DepartmentModel? get departmentModelSelected {
    _$departmentModelSelectedAtom.reportRead();
    return super.departmentModelSelected;
  }

  @override
  set departmentModelSelected(DepartmentModel? value) {
    _$departmentModelSelectedAtom
        .reportWrite(value, super.departmentModelSelected, () {
      super.departmentModelSelected = value;
    });
  }

  late final _$patientModelSelectedAtom = Atom(
      name: '_FilterSignatureStoreBase.patientModelSelected', context: context);

  @override
  PatientModel? get patientModelSelected {
    _$patientModelSelectedAtom.reportRead();
    return super.patientModelSelected;
  }

  @override
  set patientModelSelected(PatientModel? value) {
    _$patientModelSelectedAtom.reportWrite(value, super.patientModelSelected,
        () {
      super.patientModelSelected = value;
    });
  }

  late final _$onSearchDepartmentAsyncAction = AsyncAction(
      '_FilterSignatureStoreBase.onSearchDepartment',
      context: context);

  @override
  Future<void> onSearchDepartment({String? keyword}) {
    return _$onSearchDepartmentAsyncAction
        .run(() => super.onSearchDepartment(keyword: keyword));
  }

  late final _$onSearchTypeDocumentsAsyncAction = AsyncAction(
      '_FilterSignatureStoreBase.onSearchTypeDocuments',
      context: context);

  @override
  Future<void> onSearchTypeDocuments({String? keyword}) {
    return _$onSearchTypeDocumentsAsyncAction
        .run(() => super.onSearchTypeDocuments(keyword: keyword));
  }

  late final _$onSearchPatientAsyncAction = AsyncAction(
      '_FilterSignatureStoreBase.onSearchPatient',
      context: context);

  @override
  Future<void> onSearchPatient({required String search}) {
    return _$onSearchPatientAsyncAction
        .run(() => super.onSearchPatient(search: search));
  }

  late final _$onLoadMorePatientsAsyncAction = AsyncAction(
      '_FilterSignatureStoreBase.onLoadMorePatients',
      context: context);

  @override
  Future<void> onLoadMorePatients() {
    return _$onLoadMorePatientsAsyncAction
        .run(() => super.onLoadMorePatients());
  }

  late final _$onConfirmFilterAsyncAction = AsyncAction(
      '_FilterSignatureStoreBase.onConfirmFilter',
      context: context);

  @override
  Future<void> onConfirmFilter() {
    return _$onConfirmFilterAsyncAction.run(() => super.onConfirmFilter());
  }

  late final _$onLoadMoreTypeDocumentAsyncAction = AsyncAction(
      '_FilterSignatureStoreBase.onLoadMoreTypeDocument',
      context: context);

  @override
  Future<void> onLoadMoreTypeDocument() {
    return _$onLoadMoreTypeDocumentAsyncAction
        .run(() => super.onLoadMoreTypeDocument());
  }

  late final _$onLoadMoreDepartmentAsyncAction = AsyncAction(
      '_FilterSignatureStoreBase.onLoadMoreDepartment',
      context: context);

  @override
  Future<void> onLoadMoreDepartment() {
    return _$onLoadMoreDepartmentAsyncAction
        .run(() => super.onLoadMoreDepartment());
  }

  late final _$onLoadedPatientAsyncAction = AsyncAction(
      '_FilterSignatureStoreBase.onLoadedPatient',
      context: context);

  @override
  Future<void> onLoadedPatient({required String patientCode}) {
    return _$onLoadedPatientAsyncAction
        .run(() => super.onLoadedPatient(patientCode: patientCode));
  }

  late final _$_FilterSignatureStoreBaseActionController =
      ActionController(name: '_FilterSignatureStoreBase', context: context);

  @override
  void initState() {
    final _$actionInfo = _$_FilterSignatureStoreBaseActionController
        .startAction(name: '_FilterSignatureStoreBase.initState');
    try {
      return super.initState();
    } finally {
      _$_FilterSignatureStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearStateFilter() {
    final _$actionInfo = _$_FilterSignatureStoreBaseActionController
        .startAction(name: '_FilterSignatureStoreBase.clearStateFilter');
    try {
      return super.clearStateFilter();
    } finally {
      _$_FilterSignatureStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onChangeStartDate(DateTime start) {
    final _$actionInfo = _$_FilterSignatureStoreBaseActionController
        .startAction(name: '_FilterSignatureStoreBase.onChangeStartDate');
    try {
      return super.onChangeStartDate(start);
    } finally {
      _$_FilterSignatureStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onChangeSigningStatus({int? signingStatusSelected}) {
    final _$actionInfo = _$_FilterSignatureStoreBaseActionController
        .startAction(name: '_FilterSignatureStoreBase.onChangeSigningStatus');
    try {
      return super
          .onChangeSigningStatus(signingStatusSelected: signingStatusSelected);
    } finally {
      _$_FilterSignatureStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onChangeEndDate(DateTime end) {
    final _$actionInfo = _$_FilterSignatureStoreBaseActionController
        .startAction(name: '_FilterSignatureStoreBase.onChangeEndDate');
    try {
      return super.onChangeEndDate(end);
    } finally {
      _$_FilterSignatureStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onChangedValueSearch({String? value}) {
    final _$actionInfo = _$_FilterSignatureStoreBaseActionController
        .startAction(name: '_FilterSignatureStoreBase.onChangedValueSearch');
    try {
      return super.onChangedValueSearch(value: value);
    } finally {
      _$_FilterSignatureStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onSelectedPatient({required PatientModel patient}) {
    final _$actionInfo = _$_FilterSignatureStoreBaseActionController
        .startAction(name: '_FilterSignatureStoreBase.onSelectedPatient');
    try {
      return super.onSelectedPatient(patient: patient);
    } finally {
      _$_FilterSignatureStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onSelectedDepartment({required DepartmentModel departmentModel}) {
    final _$actionInfo = _$_FilterSignatureStoreBaseActionController
        .startAction(name: '_FilterSignatureStoreBase.onSelectedDepartment');
    try {
      return super.onSelectedDepartment(departmentModel: departmentModel);
    } finally {
      _$_FilterSignatureStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onChangeRollSigner(String? value) {
    final _$actionInfo = _$_FilterSignatureStoreBaseActionController
        .startAction(name: '_FilterSignatureStoreBase.onChangeRollSigner');
    try {
      return super.onChangeRollSigner(value);
    } finally {
      _$_FilterSignatureStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onSelectedTypeDocument(
      {required TypeDocumentModel typeDocumentModelSelected}) {
    final _$actionInfo = _$_FilterSignatureStoreBaseActionController
        .startAction(name: '_FilterSignatureStoreBase.onSelectedTypeDocument');
    try {
      return super.onSelectedTypeDocument(
          typeDocumentModelSelected: typeDocumentModelSelected);
    } finally {
      _$_FilterSignatureStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
fromDate: ${fromDate},
toDate: ${toDate},
idSigningStatus: ${idSigningStatus},
roleSigning: ${roleSigning},
roleCode: ${roleCode},
nameSigningStatus: ${nameSigningStatus},
isLoading: ${isLoading},
pagingDepartment: ${pagingDepartment},
signers: ${signers},
pagingPatient: ${pagingPatient},
pagingTypeDocument: ${pagingTypeDocument},
typeDocument: ${typeDocument},
departmentModelSelected: ${departmentModelSelected},
patientModelSelected: ${patientModelSelected}
    ''';
  }
}
