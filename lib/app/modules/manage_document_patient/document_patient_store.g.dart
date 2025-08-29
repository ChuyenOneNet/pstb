// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_patient_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DocumentPatientStore on DocumentPatientStoreBase, Store {
  late final _$isLoginAtom =
      Atom(name: 'DocumentPatientStoreBase.isLogin', context: context);

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

  late final _$urlPdfAtom =
      Atom(name: 'DocumentPatientStoreBase.urlPdf', context: context);

  @override
  String get urlPdf {
    _$urlPdfAtom.reportRead();
    return super.urlPdf;
  }

  @override
  set urlPdf(String value) {
    _$urlPdfAtom.reportWrite(value, super.urlPdf, () {
      super.urlPdf = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'DocumentPatientStoreBase.isLoading', context: context);

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

  late final _$loadSignatureAtom =
      Atom(name: 'DocumentPatientStoreBase.loadSignature', context: context);

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

  late final _$documentPaginationAtom = Atom(
      name: 'DocumentPatientStoreBase.documentPagination', context: context);

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

  late final _$nameRollAtom =
      Atom(name: 'DocumentPatientStoreBase.nameRoll', context: context);

  @override
  String? get nameRoll {
    _$nameRollAtom.reportRead();
    return super.nameRoll;
  }

  @override
  set nameRoll(String? value) {
    _$nameRollAtom.reportWrite(value, super.nameRoll, () {
      super.nameRoll = value;
    });
  }

  late final _$isLoadingMoreItemAtom = Atom(
      name: 'DocumentPatientStoreBase.isLoadingMoreItem', context: context);

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

  late final _$isShowCheckedItemAtom = Atom(
      name: 'DocumentPatientStoreBase.isShowCheckedItem', context: context);

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

  late final _$statusSignatureAtom =
      Atom(name: 'DocumentPatientStoreBase.statusSignature', context: context);

  @override
  int get statusSignature {
    _$statusSignatureAtom.reportRead();
    return super.statusSignature;
  }

  @override
  set statusSignature(int value) {
    _$statusSignatureAtom.reportWrite(value, super.statusSignature, () {
      super.statusSignature = value;
    });
  }

  late final _$listESMAtom =
      Atom(name: 'DocumentPatientStoreBase.listESM', context: context);

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

  late final _$statusAtom =
      Atom(name: 'DocumentPatientStoreBase.status', context: context);

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
      Atom(name: 'DocumentPatientStoreBase.checkSigning', context: context);

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
      Atom(name: 'DocumentPatientStoreBase.prepareSign', context: context);

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
      Atom(name: 'DocumentPatientStoreBase.transactionId', context: context);

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

  late final _$selectedDocumentsAtom = Atom(
      name: 'DocumentPatientStoreBase.selectedDocuments', context: context);

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
      Atom(name: 'DocumentPatientStoreBase.signingStatus', context: context);

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

  late final _$startAtom =
      Atom(name: 'DocumentPatientStoreBase.start', context: context);

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

  late final _$pageAtom =
      Atom(name: 'DocumentPatientStoreBase.page', context: context);

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
      Atom(name: 'DocumentPatientStoreBase.enableText', context: context);

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

  late final _$documentTypeCodeAtom =
      Atom(name: 'DocumentPatientStoreBase.documentTypeCode', context: context);

  @override
  String? get documentTypeCode {
    _$documentTypeCodeAtom.reportRead();
    return super.documentTypeCode;
  }

  @override
  set documentTypeCode(String? value) {
    _$documentTypeCodeAtom.reportWrite(value, super.documentTypeCode, () {
      super.documentTypeCode = value;
    });
  }

  late final _$idsAtom =
      Atom(name: 'DocumentPatientStoreBase.ids', context: context);

  @override
  List<String> get ids {
    _$idsAtom.reportRead();
    return super.ids;
  }

  @override
  set ids(List<String> value) {
    _$idsAtom.reportWrite(value, super.ids, () {
      super.ids = value;
    });
  }

  late final _$documentsAtom =
      Atom(name: 'DocumentPatientStoreBase.documents', context: context);

  @override
  List<DocumentModel> get documents {
    _$documentsAtom.reportRead();
    return super.documents;
  }

  @override
  set documents(List<DocumentModel> value) {
    _$documentsAtom.reportWrite(value, super.documents, () {
      super.documents = value;
    });
  }

  late final _$headerForPdfAtom =
      Atom(name: 'DocumentPatientStoreBase.headerForPdf', context: context);

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

  late final _$onChooseAllDocumentAsyncAction = AsyncAction(
      'DocumentPatientStoreBase.onChooseAllDocument',
      context: context);

  @override
  Future<void> onChooseAllDocument(String documentTypeCode) {
    return _$onChooseAllDocumentAsyncAction
        .run(() => super.onChooseAllDocument(documentTypeCode));
  }

  late final _$prepareSignDocumentsAsyncAction = AsyncAction(
      'DocumentPatientStoreBase.prepareSignDocuments',
      context: context);

  @override
  Future<void> prepareSignDocuments(List<String> Ids, String documentTypeCode) {
    return _$prepareSignDocumentsAsyncAction
        .run(() => super.prepareSignDocuments(Ids, documentTypeCode));
  }

  late final _$documentsVerifyOtpAsyncAction = AsyncAction(
      'DocumentPatientStoreBase.documentsVerifyOtp',
      context: context);

  @override
  Future<void> documentsVerifyOtp(
      String otp, String transactionId, List<DocumentModel> documents) {
    return _$documentsVerifyOtpAsyncAction
        .run(() => super.documentsVerifyOtp(otp, transactionId, documents));
  }

  late final _$getSignerAsyncAction =
      AsyncAction('DocumentPatientStoreBase.getSigner', context: context);

  @override
  Future<void> getSigner() {
    return _$getSignerAsyncAction.run(() => super.getSigner());
  }

  late final _$onRefreshPageAsyncAction =
      AsyncAction('DocumentPatientStoreBase.onRefreshPage', context: context);

  @override
  Future<void> onRefreshPage() {
    return _$onRefreshPageAsyncAction.run(() => super.onRefreshPage());
  }

  late final _$loadMoreSignatureAsyncAction = AsyncAction(
      'DocumentPatientStoreBase.loadMoreSignature',
      context: context);

  @override
  Future<void> loadMoreSignature() {
    return _$loadMoreSignatureAsyncAction.run(() => super.loadMoreSignature());
  }

  late final _$onRefreshPDFAsyncAction =
      AsyncAction('DocumentPatientStoreBase.onRefreshPDF', context: context);

  @override
  Future<void> onRefreshPDF(DocumentModel documentModel) {
    return _$onRefreshPDFAsyncAction
        .run(() => super.onRefreshPDF(documentModel));
  }

  late final _$getHeaderForPdfAsyncAction =
      AsyncAction('DocumentPatientStoreBase.getHeaderForPdf', context: context);

  @override
  Future<dynamic> getHeaderForPdf() {
    return _$getHeaderForPdfAsyncAction.run(() => super.getHeaderForPdf());
  }

  late final _$DocumentPatientStoreBaseActionController =
      ActionController(name: 'DocumentPatientStoreBase', context: context);

  @override
  void setIsLogin(UserStatus loginStatus) {
    final _$actionInfo = _$DocumentPatientStoreBaseActionController.startAction(
        name: 'DocumentPatientStoreBase.setIsLogin');
    try {
      return super.setIsLogin(loginStatus);
    } finally {
      _$DocumentPatientStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onChangeValue(int index) {
    final _$actionInfo = _$DocumentPatientStoreBaseActionController.startAction(
        name: 'DocumentPatientStoreBase.onChangeValue');
    try {
      return super.onChangeValue(index);
    } finally {
      _$DocumentPatientStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLogin: ${isLogin},
urlPdf: ${urlPdf},
isLoading: ${isLoading},
loadSignature: ${loadSignature},
documentPagination: ${documentPagination},
nameRoll: ${nameRoll},
isLoadingMoreItem: ${isLoadingMoreItem},
isShowCheckedItem: ${isShowCheckedItem},
statusSignature: ${statusSignature},
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
documentTypeCode: ${documentTypeCode},
ids: ${ids},
documents: ${documents},
headerForPdf: ${headerForPdf}
    ''';
  }
}
