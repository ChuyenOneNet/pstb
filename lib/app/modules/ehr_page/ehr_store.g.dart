// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ehr_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EHRStore on EHRStoreBase, Store {
  late final _$isLoginAtom =
      Atom(name: 'EHRStoreBase.isLogin', context: context);

  @override
  UserStatus get isLogin {
    _$isLoginAtom.reportRead();
    return super.isLogin;
  }

  @override
  set isLogin(UserStatus value) {
    _$isLoginAtom.reportWrite(value, super.isLogin, () {
      super.isLogin = value;
    });
  }

  late final _$dataAtom = Atom(name: 'EHRStoreBase.data', context: context);

  @override
  MedicalRecordModel get data {
    _$dataAtom.reportRead();
    return super.data;
  }

  @override
  set data(MedicalRecordModel value) {
    _$dataAtom.reportWrite(value, super.data, () {
      super.data = value;
    });
  }

  late final _$patientAtom =
      Atom(name: 'EHRStoreBase.patient', context: context);

  @override
  Patient? get patient {
    _$patientAtom.reportRead();
    return super.patient;
  }

  @override
  set patient(Patient? value) {
    _$patientAtom.reportWrite(value, super.patient, () {
      super.patient = value;
    });
  }

  late final _$currentIndexPrescriptionsAtom =
      Atom(name: 'EHRStoreBase.currentIndexPrescriptions', context: context);

  @override
  int get currentIndexPrescriptions {
    _$currentIndexPrescriptionsAtom.reportRead();
    return super.currentIndexPrescriptions;
  }

  @override
  set currentIndexPrescriptions(int value) {
    _$currentIndexPrescriptionsAtom
        .reportWrite(value, super.currentIndexPrescriptions, () {
      super.currentIndexPrescriptions = value;
    });
  }

  late final _$currentIndexIndicationsAtom =
      Atom(name: 'EHRStoreBase.currentIndexIndications', context: context);

  @override
  int get currentIndexIndications {
    _$currentIndexIndicationsAtom.reportRead();
    return super.currentIndexIndications;
  }

  @override
  set currentIndexIndications(int value) {
    _$currentIndexIndicationsAtom
        .reportWrite(value, super.currentIndexIndications, () {
      super.currentIndexIndications = value;
    });
  }

  late final _$imageFileAtom =
      Atom(name: 'EHRStoreBase.imageFile', context: context);

  @override
  File? get imageFile {
    _$imageFileAtom.reportRead();
    return super.imageFile;
  }

  @override
  set imageFile(File? value) {
    _$imageFileAtom.reportWrite(value, super.imageFile, () {
      super.imageFile = value;
    });
  }

  late final _$prescriptionDateAtom =
      Atom(name: 'EHRStoreBase.prescriptionDate', context: context);

  @override
  ObservableList<String> get prescriptionDate {
    _$prescriptionDateAtom.reportRead();
    return super.prescriptionDate;
  }

  @override
  set prescriptionDate(ObservableList<String> value) {
    _$prescriptionDateAtom.reportWrite(value, super.prescriptionDate, () {
      super.prescriptionDate = value;
    });
  }

  late final _$selectDateAtom =
      Atom(name: 'EHRStoreBase.selectDate', context: context);

  @override
  String get selectDate {
    _$selectDateAtom.reportRead();
    return super.selectDate;
  }

  @override
  set selectDate(String value) {
    _$selectDateAtom.reportWrite(value, super.selectDate, () {
      super.selectDate = value;
    });
  }

  late final _$imageAtom = Atom(name: 'EHRStoreBase.image', context: context);

  @override
  String get image {
    _$imageAtom.reportRead();
    return super.image;
  }

  @override
  set image(String value) {
    _$imageAtom.reportWrite(value, super.image, () {
      super.image = value;
    });
  }

  late final _$loadingAtom =
      Atom(name: 'EHRStoreBase.loading', context: context);

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  late final _$resultsDataAtom =
      Atom(name: 'EHRStoreBase.resultsData', context: context);

  @override
  ExaminationResultModel get resultsData {
    _$resultsDataAtom.reportRead();
    return super.resultsData;
  }

  @override
  set resultsData(ExaminationResultModel value) {
    _$resultsDataAtom.reportWrite(value, super.resultsData, () {
      super.resultsData = value;
    });
  }

  late final _$isListPrescriptionsExpandedAtom =
      Atom(name: 'EHRStoreBase.isListPrescriptionsExpanded', context: context);

  @override
  ObservableList<bool> get isListPrescriptionsExpanded {
    _$isListPrescriptionsExpandedAtom.reportRead();
    return super.isListPrescriptionsExpanded;
  }

  @override
  set isListPrescriptionsExpanded(ObservableList<bool> value) {
    _$isListPrescriptionsExpandedAtom
        .reportWrite(value, super.isListPrescriptionsExpanded, () {
      super.isListPrescriptionsExpanded = value;
    });
  }

  late final _$isListIndicationsExpandedAtom =
      Atom(name: 'EHRStoreBase.isListIndicationsExpanded', context: context);

  @override
  List<bool> get isListIndicationsExpanded {
    _$isListIndicationsExpandedAtom.reportRead();
    return super.isListIndicationsExpanded;
  }

  @override
  set isListIndicationsExpanded(List<bool> value) {
    _$isListIndicationsExpandedAtom
        .reportWrite(value, super.isListIndicationsExpanded, () {
      super.isListIndicationsExpanded = value;
    });
  }

  late final _$listIndicationsGroupByDayAtom =
      Atom(name: 'EHRStoreBase.listIndicationsGroupByDay', context: context);

  @override
  List<Indications> get listIndicationsGroupByDay {
    _$listIndicationsGroupByDayAtom.reportRead();
    return super.listIndicationsGroupByDay;
  }

  @override
  set listIndicationsGroupByDay(List<Indications> value) {
    _$listIndicationsGroupByDayAtom
        .reportWrite(value, super.listIndicationsGroupByDay, () {
      super.listIndicationsGroupByDay = value;
    });
  }

  late final _$prescriptionDataAtom =
      Atom(name: 'EHRStoreBase.prescriptionData', context: context);

  @override
  ObservableList<Prescription> get prescriptionData {
    _$prescriptionDataAtom.reportRead();
    return super.prescriptionData;
  }

  @override
  set prescriptionData(ObservableList<Prescription> value) {
    _$prescriptionDataAtom.reportWrite(value, super.prescriptionData, () {
      super.prescriptionData = value;
    });
  }

  late final _$indicationGroupByDateAtom =
      Atom(name: 'EHRStoreBase.indicationGroupByDate', context: context);

  @override
  List<Map<String, List<Indications>>> get indicationGroupByDate {
    _$indicationGroupByDateAtom.reportRead();
    return super.indicationGroupByDate;
  }

  @override
  set indicationGroupByDate(List<Map<String, List<Indications>>> value) {
    _$indicationGroupByDateAtom.reportWrite(value, super.indicationGroupByDate,
        () {
      super.indicationGroupByDate = value;
    });
  }

  late final _$listPrescriptionModelAtom =
      Atom(name: 'EHRStoreBase.listPrescriptionModel', context: context);

  @override
  List<List<PrescriptionModel>> get listPrescriptionModel {
    _$listPrescriptionModelAtom.reportRead();
    return super.listPrescriptionModel;
  }

  @override
  set listPrescriptionModel(List<List<PrescriptionModel>> value) {
    _$listPrescriptionModelAtom.reportWrite(value, super.listPrescriptionModel,
        () {
      super.listPrescriptionModel = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'EHRStoreBase.isLoading', context: context);

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

  late final _$uint8listAtom =
      Atom(name: 'EHRStoreBase.uint8list', context: context);

  @override
  Uint8List? get uint8list {
    _$uint8listAtom.reportRead();
    return super.uint8list;
  }

  @override
  set uint8list(Uint8List? value) {
    _$uint8listAtom.reportWrite(value, super.uint8list, () {
      super.uint8list = value;
    });
  }

  late final _$pageSolutionAtom =
      Atom(name: 'EHRStoreBase.pageSolution', context: context);

  @override
  int get pageSolution {
    _$pageSolutionAtom.reportRead();
    return super.pageSolution;
  }

  @override
  set pageSolution(int value) {
    _$pageSolutionAtom.reportWrite(value, super.pageSolution, () {
      super.pageSolution = value;
    });
  }

  late final _$isLoadMoreAtom =
      Atom(name: 'EHRStoreBase.isLoadMore', context: context);

  @override
  bool get isLoadMore {
    _$isLoadMoreAtom.reportRead();
    return super.isLoadMore;
  }

  @override
  set isLoadMore(bool value) {
    _$isLoadMoreAtom.reportWrite(value, super.isLoadMore, () {
      super.isLoadMore = value;
    });
  }

  late final _$showMoreAtom =
      Atom(name: 'EHRStoreBase.showMore', context: context);

  @override
  bool get showMore {
    _$showMoreAtom.reportRead();
    return super.showMore;
  }

  @override
  set showMore(bool value) {
    _$showMoreAtom.reportWrite(value, super.showMore, () {
      super.showMore = value;
    });
  }

  late final _$pageIndexAtom =
      Atom(name: 'EHRStoreBase.pageIndex', context: context);

  @override
  int get pageIndex {
    _$pageIndexAtom.reportRead();
    return super.pageIndex;
  }

  @override
  set pageIndex(int value) {
    _$pageIndexAtom.reportWrite(value, super.pageIndex, () {
      super.pageIndex = value;
    });
  }

  late final _$patientNameAtom =
      Atom(name: 'EHRStoreBase.patientName', context: context);

  @override
  String? get patientName {
    _$patientNameAtom.reportRead();
    return super.patientName;
  }

  @override
  set patientName(String? value) {
    _$patientNameAtom.reportWrite(value, super.patientName, () {
      super.patientName = value;
    });
  }

  late final _$loadSignatureAtom =
      Atom(name: 'EHRStoreBase.loadSignature', context: context);

  @override
  bool get loadSignature {
    _$loadSignatureAtom.reportRead();
    return super.loadSignature;
  }

  @override
  set loadSignature(bool value) {
    _$loadSignatureAtom.reportWrite(value, super.loadSignature, () {
      super.loadSignature = value;
    });
  }

  late final _$documentPaginationAtom =
      Atom(name: 'EHRStoreBase.documentPagination', context: context);

  @override
  Paging<DocumentModel> get documentPagination {
    _$documentPaginationAtom.reportRead();
    return super.documentPagination;
  }

  @override
  set documentPagination(Paging<DocumentModel> value) {
    _$documentPaginationAtom.reportWrite(value, super.documentPagination, () {
      super.documentPagination = value;
    });
  }

  late final _$demAtom = Atom(name: 'EHRStoreBase.dem', context: context);

  @override
  int get dem {
    _$demAtom.reportRead();
    return super.dem;
  }

  @override
  set dem(int value) {
    _$demAtom.reportWrite(value, super.dem, () {
      super.dem = value;
    });
  }

  late final _$isLoadingMoreItemAtom =
      Atom(name: 'EHRStoreBase.isLoadingMoreItem', context: context);

  @override
  bool get isLoadingMoreItem {
    _$isLoadingMoreItemAtom.reportRead();
    return super.isLoadingMoreItem;
  }

  @override
  set isLoadingMoreItem(bool value) {
    _$isLoadingMoreItemAtom.reportWrite(value, super.isLoadingMoreItem, () {
      super.isLoadingMoreItem = value;
    });
  }

  late final _$isShowCheckedItemAtom =
      Atom(name: 'EHRStoreBase.isShowCheckedItem', context: context);

  @override
  bool get isShowCheckedItem {
    _$isShowCheckedItemAtom.reportRead();
    return super.isShowCheckedItem;
  }

  @override
  set isShowCheckedItem(bool value) {
    _$isShowCheckedItemAtom.reportWrite(value, super.isShowCheckedItem, () {
      super.isShowCheckedItem = value;
    });
  }

  late final _$listESMAtom =
      Atom(name: 'EHRStoreBase.listESM', context: context);

  @override
  ObservableList<DocumentModel> get listESM {
    _$listESMAtom.reportRead();
    return super.listESM;
  }

  @override
  set listESM(ObservableList<DocumentModel> value) {
    _$listESMAtom.reportWrite(value, super.listESM, () {
      super.listESM = value;
    });
  }

  late final _$statusAtom = Atom(name: 'EHRStoreBase.status', context: context);

  @override
  String? get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(String? value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  late final _$checkSigningAtom =
      Atom(name: 'EHRStoreBase.checkSigning', context: context);

  @override
  bool get checkSigning {
    _$checkSigningAtom.reportRead();
    return super.checkSigning;
  }

  @override
  set checkSigning(bool value) {
    _$checkSigningAtom.reportWrite(value, super.checkSigning, () {
      super.checkSigning = value;
    });
  }

  late final _$prepareSignAtom =
      Atom(name: 'EHRStoreBase.prepareSign', context: context);

  @override
  bool get prepareSign {
    _$prepareSignAtom.reportRead();
    return super.prepareSign;
  }

  @override
  set prepareSign(bool value) {
    _$prepareSignAtom.reportWrite(value, super.prepareSign, () {
      super.prepareSign = value;
    });
  }

  late final _$transactionIdAtom =
      Atom(name: 'EHRStoreBase.transactionId', context: context);

  @override
  String? get transactionId {
    _$transactionIdAtom.reportRead();
    return super.transactionId;
  }

  @override
  set transactionId(String? value) {
    _$transactionIdAtom.reportWrite(value, super.transactionId, () {
      super.transactionId = value;
    });
  }

  late final _$selectedDocumentsAtom =
      Atom(name: 'EHRStoreBase.selectedDocuments', context: context);

  @override
  List<bool> get selectedDocuments {
    _$selectedDocumentsAtom.reportRead();
    return super.selectedDocuments;
  }

  @override
  set selectedDocuments(List<bool> value) {
    _$selectedDocumentsAtom.reportWrite(value, super.selectedDocuments, () {
      super.selectedDocuments = value;
    });
  }

  late final _$signingStatusAtom =
      Atom(name: 'EHRStoreBase.signingStatus', context: context);

  @override
  int? get signingStatus {
    _$signingStatusAtom.reportRead();
    return super.signingStatus;
  }

  @override
  set signingStatus(int? value) {
    _$signingStatusAtom.reportWrite(value, super.signingStatus, () {
      super.signingStatus = value;
    });
  }

  late final _$startAtom = Atom(name: 'EHRStoreBase.start', context: context);

  @override
  int get start {
    _$startAtom.reportRead();
    return super.start;
  }

  @override
  set start(int value) {
    _$startAtom.reportWrite(value, super.start, () {
      super.start = value;
    });
  }

  late final _$pageAtom = Atom(name: 'EHRStoreBase.page', context: context);

  @override
  int get page {
    _$pageAtom.reportRead();
    return super.page;
  }

  @override
  set page(int value) {
    _$pageAtom.reportWrite(value, super.page, () {
      super.page = value;
    });
  }

  late final _$enableTextAtom =
      Atom(name: 'EHRStoreBase.enableText', context: context);

  @override
  bool get enableText {
    _$enableTextAtom.reportRead();
    return super.enableText;
  }

  @override
  set enableText(bool value) {
    _$enableTextAtom.reportWrite(value, super.enableText, () {
      super.enableText = value;
    });
  }

  late final _$titleDetailPdfAtom =
      Atom(name: 'EHRStoreBase.titleDetailPdf', context: context);

  @override
  String get titleDetailPdf {
    _$titleDetailPdfAtom.reportRead();
    return super.titleDetailPdf;
  }

  @override
  set titleDetailPdf(String value) {
    _$titleDetailPdfAtom.reportWrite(value, super.titleDetailPdf, () {
      super.titleDetailPdf = value;
    });
  }

  late final _$listPatientAtom =
      Atom(name: 'EHRStoreBase.listPatient', context: context);

  @override
  List<Patient> get listPatient {
    _$listPatientAtom.reportRead();
    return super.listPatient;
  }

  @override
  set listPatient(List<Patient> value) {
    _$listPatientAtom.reportWrite(value, super.listPatient, () {
      super.listPatient = value;
    });
  }

  late final _$headerForPdfAtom =
      Atom(name: 'EHRStoreBase.headerForPdf', context: context);

  @override
  Map<String, String>? get headerForPdf {
    _$headerForPdfAtom.reportRead();
    return super.headerForPdf;
  }

  @override
  set headerForPdf(Map<String, String>? value) {
    _$headerForPdfAtom.reportWrite(value, super.headerForPdf, () {
      super.headerForPdf = value;
    });
  }

  late final _$initDetailExaminationStateAsyncAction =
      AsyncAction('EHRStoreBase.initDetailExaminationState', context: context);

  @override
  Future<void> initDetailExaminationState({String? examinationRegisId}) {
    return _$initDetailExaminationStateAsyncAction.run(() => super
        .initDetailExaminationState(examinationRegisId: examinationRegisId));
  }

  late final _$loadPatientRecordAsyncAction =
      AsyncAction('EHRStoreBase.loadPatientRecord', context: context);

  @override
  Future<dynamic> loadPatientRecord() {
    return _$loadPatientRecordAsyncAction.run(() => super.loadPatientRecord());
  }

  late final _$loadMedicalRecordAsyncAction =
      AsyncAction('EHRStoreBase.loadMedicalRecord', context: context);

  @override
  Future<dynamic> loadMedicalRecord(String patientId) {
    return _$loadMedicalRecordAsyncAction
        .run(() => super.loadMedicalRecord(patientId));
  }

  late final _$loadDetailExaminationAsyncAction =
      AsyncAction('EHRStoreBase.loadDetailExamination', context: context);

  @override
  Future<dynamic> loadDetailExamination(String registrationId) {
    return _$loadDetailExaminationAsyncAction
        .run(() => super.loadDetailExamination(registrationId));
  }

  late final _$loadDetailIndicationAsyncAction =
      AsyncAction('EHRStoreBase.loadDetailIndication', context: context);

  @override
  Future<void> loadDetailIndication(int index, bool value) {
    return _$loadDetailIndicationAsyncAction
        .run(() => super.loadDetailIndication(index, value));
  }

  late final _$loadListPrescriptionAsyncAction =
      AsyncAction('EHRStoreBase.loadListPrescription', context: context);

  @override
  Future<void> loadListPrescription(String dateTime, int index,
      {bool value = false}) {
    return _$loadListPrescriptionAsyncAction
        .run(() => super.loadListPrescription(dateTime, index, value: value));
  }

  late final _$onChangeIndexSolutionAsyncAction =
      AsyncAction('EHRStoreBase.onChangeIndexSolution', context: context);

  @override
  Future<void> onChangeIndexSolution(int index) {
    return _$onChangeIndexSolutionAsyncAction
        .run(() => super.onChangeIndexSolution(index));
  }

  late final _$loadPrescriptionDateAsyncAction =
      AsyncAction('EHRStoreBase.loadPrescriptionDate', context: context);

  @override
  Future<void> loadPrescriptionDate(String registrationId) {
    return _$loadPrescriptionDateAsyncAction
        .run(() => super.loadPrescriptionDate(registrationId));
  }

  late final _$getDetailPrescriptionAsyncAction =
      AsyncAction('EHRStoreBase.getDetailPrescription', context: context);

  @override
  Future<void> getDetailPrescription(
      {String? medicalInstructionId, String? examinationId, String? type}) {
    return _$getDetailPrescriptionAsyncAction.run(() => super
        .getDetailPrescription(
            medicalInstructionId: medicalInstructionId,
            examinationId: examinationId,
            type: type));
  }

  late final _$reloadDataAsyncAction =
      AsyncAction('EHRStoreBase.reloadData', context: context);

  @override
  Future<dynamic> reloadData(String patientId, String phone) {
    return _$reloadDataAsyncAction
        .run(() => super.reloadData(patientId, phone));
  }

  late final _$getSignerAsyncAction =
      AsyncAction('EHRStoreBase.getSigner', context: context);

  @override
  Future<void> getSigner() {
    return _$getSignerAsyncAction.run(() => super.getSigner());
  }

  late final _$onRefreshPageAsyncAction =
      AsyncAction('EHRStoreBase.onRefreshPage', context: context);

  @override
  Future<void> onRefreshPage() {
    return _$onRefreshPageAsyncAction.run(() => super.onRefreshPage());
  }

  late final _$loadMoreSignatureAsyncAction =
      AsyncAction('EHRStoreBase.loadMoreSignature', context: context);

  @override
  Future<void> loadMoreSignature() {
    return _$loadMoreSignatureAsyncAction.run(() => super.loadMoreSignature());
  }

  late final _$prepareSignPatientAsyncAction =
      AsyncAction('EHRStoreBase.prepareSignPatient', context: context);

  @override
  Future<void> prepareSignPatient(String id, String documentTypeCode) {
    return _$prepareSignPatientAsyncAction
        .run(() => super.prepareSignPatient(id, documentTypeCode));
  }

  late final _$patientVerifyOtpAsyncAction =
      AsyncAction('EHRStoreBase.patientVerifyOtp', context: context);

  @override
  Future<void> patientVerifyOtp(
      String otp, String transactionId, DocumentModel documentModel) {
    return _$patientVerifyOtpAsyncAction
        .run(() => super.patientVerifyOtp(otp, transactionId, documentModel));
  }

  late final _$onRefreshPDFAsyncAction =
      AsyncAction('EHRStoreBase.onRefreshPDF', context: context);

  @override
  Future<void> onRefreshPDF(DocumentModel documentModel) {
    return _$onRefreshPDFAsyncAction
        .run(() => super.onRefreshPDF(documentModel));
  }

  late final _$getHeaderForPdfAsyncAction =
      AsyncAction('EHRStoreBase.getHeaderForPdf', context: context);

  @override
  Future<dynamic> getHeaderForPdf() {
    return _$getHeaderForPdfAsyncAction.run(() => super.getHeaderForPdf());
  }

  late final _$EHRStoreBaseActionController =
      ActionController(name: 'EHRStoreBase', context: context);

  @override
  void setIsLogin(UserStatus loginStatus) {
    final _$actionInfo = _$EHRStoreBaseActionController.startAction(
        name: 'EHRStoreBase.setIsLogin');
    try {
      return super.setIsLogin(loginStatus);
    } finally {
      _$EHRStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDate(String date) {
    final _$actionInfo = _$EHRStoreBaseActionController.startAction(
        name: 'EHRStoreBase.setDate');
    try {
      return super.setDate(date);
    } finally {
      _$EHRStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String getChiSoBMI(InfoExaminations? data) {
    final _$actionInfo = _$EHRStoreBaseActionController.startAction(
        name: 'EHRStoreBase.getChiSoBMI');
    try {
      return super.getChiSoBMI(data);
    } finally {
      _$EHRStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLogin: ${isLogin},
data: ${data},
patient: ${patient},
currentIndexPrescriptions: ${currentIndexPrescriptions},
currentIndexIndications: ${currentIndexIndications},
imageFile: ${imageFile},
prescriptionDate: ${prescriptionDate},
selectDate: ${selectDate},
image: ${image},
loading: ${loading},
resultsData: ${resultsData},
isListPrescriptionsExpanded: ${isListPrescriptionsExpanded},
isListIndicationsExpanded: ${isListIndicationsExpanded},
listIndicationsGroupByDay: ${listIndicationsGroupByDay},
prescriptionData: ${prescriptionData},
indicationGroupByDate: ${indicationGroupByDate},
listPrescriptionModel: ${listPrescriptionModel},
isLoading: ${isLoading},
uint8list: ${uint8list},
pageSolution: ${pageSolution},
isLoadMore: ${isLoadMore},
showMore: ${showMore},
pageIndex: ${pageIndex},
patientName: ${patientName},
loadSignature: ${loadSignature},
documentPagination: ${documentPagination},
dem: ${dem},
isLoadingMoreItem: ${isLoadingMoreItem},
isShowCheckedItem: ${isShowCheckedItem},
listESM: ${listESM},
status: ${status},
checkSigning: ${checkSigning},
prepareSign: ${prepareSign},
transactionId: ${transactionId},
selectedDocuments: ${selectedDocuments},
signingStatus: ${signingStatus},
start: ${start},
page: ${page},
enableText: ${enableText},
titleDetailPdf: ${titleDetailPdf},
listPatient: ${listPatient},
headerForPdf: ${headerForPdf}
    ''';
  }
}
