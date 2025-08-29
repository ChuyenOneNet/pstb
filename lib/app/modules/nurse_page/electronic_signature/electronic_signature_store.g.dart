// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'electronic_signature_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ElectronicSignatureStore on _ElectronicSignatureStoreBase, Store {
  late final _$isShowCheckedItemAtom = Atom(
      name: '_ElectronicSignatureStoreBase.isShowCheckedItem',
      context: context);

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

  late final _$documentPaginationAtom = Atom(
      name: '_ElectronicSignatureStoreBase.documentPagination',
      context: context);

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

  late final _$selectedDocumentsAtom = Atom(
      name: '_ElectronicSignatureStoreBase.selectedDocuments',
      context: context);

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

  late final _$isCancelCheckedBoxAtom = Atom(
      name: '_ElectronicSignatureStoreBase.isCancelCheckedBox',
      context: context);

  @override
  bool get isCancelCheckedBox {
    _$isCancelCheckedBoxAtom.reportRead();
    return super.isCancelCheckedBox;
  }

  @override
  set isCancelCheckedBox(bool value) {
    _$isCancelCheckedBoxAtom.reportWrite(value, super.isCancelCheckedBox, () {
      super.isCancelCheckedBox = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_ElectronicSignatureStoreBase.isLoading', context: context);

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

  late final _$isLoadingMoreItemAtom = Atom(
      name: '_ElectronicSignatureStoreBase.isLoadingMoreItem',
      context: context);

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

  late final _$statusAtom =
      Atom(name: '_ElectronicSignatureStoreBase.status', context: context);

  @override
  int? get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(int? value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  late final _$isChangeStatusAtom = Atom(
      name: '_ElectronicSignatureStoreBase.isChangeStatus', context: context);

  @override
  bool? get isChangeStatus {
    _$isChangeStatusAtom.reportRead();
    return super.isChangeStatus;
  }

  @override
  set isChangeStatus(bool? value) {
    _$isChangeStatusAtom.reportWrite(value, super.isChangeStatus, () {
      super.isChangeStatus = value;
    });
  }

  late final _$nameRollAtom =
      Atom(name: '_ElectronicSignatureStoreBase.nameRoll', context: context);

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

  late final _$signerRollAtom =
      Atom(name: '_ElectronicSignatureStoreBase.signerRoll', context: context);

  @override
  SignRolesModel? get signerRoll {
    _$signerRollAtom.reportRead();
    return super.signerRoll;
  }

  @override
  set signerRoll(SignRolesModel? value) {
    _$signerRollAtom.reportWrite(value, super.signerRoll, () {
      super.signerRoll = value;
    });
  }

  late final _$headerForPdfAtom = Atom(
      name: '_ElectronicSignatureStoreBase.headerForPdf', context: context);

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

  late final _$initStateAsyncAction =
      AsyncAction('_ElectronicSignatureStoreBase.initState', context: context);

  @override
  Future<void> initState({String? userName, String? roleCode}) {
    return _$initStateAsyncAction
        .run(() => super.initState(userName: userName, roleCode: roleCode));
  }

  late final _$signDocumentsAsyncAction = AsyncAction(
      '_ElectronicSignatureStoreBase.signDocuments',
      context: context);

  @override
  Future<void> signDocuments() {
    return _$signDocumentsAsyncAction.run(() => super.signDocuments());
  }

  late final _$revokeSignaturesAsyncAction = AsyncAction(
      '_ElectronicSignatureStoreBase.revokeSignatures',
      context: context);

  @override
  Future<void> revokeSignatures() {
    return _$revokeSignaturesAsyncAction.run(() => super.revokeSignatures());
  }

  late final _$toggleDocumentStateAsyncAction = AsyncAction(
      '_ElectronicSignatureStoreBase.toggleDocumentState',
      context: context);

  @override
  Future<void> toggleDocumentState({required String id, required int index}) {
    return _$toggleDocumentStateAsyncAction
        .run(() => super.toggleDocumentState(id: id, index: index));
  }

  late final _$onRefreshPageAsyncAction = AsyncAction(
      '_ElectronicSignatureStoreBase.onRefreshPage',
      context: context);

  @override
  Future<void> onRefreshPage() {
    return _$onRefreshPageAsyncAction.run(() => super.onRefreshPage());
  }

  late final _$loadDocumentsAsyncAction = AsyncAction(
      '_ElectronicSignatureStoreBase.loadDocuments',
      context: context);

  @override
  Future<void> loadDocuments() {
    return _$loadDocumentsAsyncAction.run(() => super.loadDocuments());
  }

  late final _$getHeaderForPdfAsyncAction = AsyncAction(
      '_ElectronicSignatureStoreBase.getHeaderForPdf',
      context: context);

  @override
  Future<dynamic> getHeaderForPdf() {
    return _$getHeaderForPdfAsyncAction.run(() => super.getHeaderForPdf());
  }

  late final _$_ElectronicSignatureStoreBaseActionController =
      ActionController(name: '_ElectronicSignatureStoreBase', context: context);

  @override
  void onShowCheckedItem({required int index}) {
    final _$actionInfo = _$_ElectronicSignatureStoreBaseActionController
        .startAction(name: '_ElectronicSignatureStoreBase.onShowCheckedItem');
    try {
      return super.onShowCheckedItem(index: index);
    } finally {
      _$_ElectronicSignatureStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onCancelPickItems() {
    final _$actionInfo = _$_ElectronicSignatureStoreBaseActionController
        .startAction(name: '_ElectronicSignatureStoreBase.onCancelPickItems');
    try {
      return super.onCancelPickItems();
    } finally {
      _$_ElectronicSignatureStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onChangeValue({required int index}) {
    final _$actionInfo = _$_ElectronicSignatureStoreBaseActionController
        .startAction(name: '_ElectronicSignatureStoreBase.onChangeValue');
    try {
      return super.onChangeValue(index: index);
    } finally {
      _$_ElectronicSignatureStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onClickAllCheckedBox() {
    final _$actionInfo =
        _$_ElectronicSignatureStoreBaseActionController.startAction(
            name: '_ElectronicSignatureStoreBase.onClickAllCheckedBox');
    try {
      return super.onClickAllCheckedBox();
    } finally {
      _$_ElectronicSignatureStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onClickCancelAllCheckedBox() {
    final _$actionInfo =
        _$_ElectronicSignatureStoreBaseActionController.startAction(
            name: '_ElectronicSignatureStoreBase.onClickCancelAllCheckedBox');
    try {
      return super.onClickCancelAllCheckedBox();
    } finally {
      _$_ElectronicSignatureStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isShowCheckedItem: ${isShowCheckedItem},
documentPagination: ${documentPagination},
selectedDocuments: ${selectedDocuments},
isCancelCheckedBox: ${isCancelCheckedBox},
isLoading: ${isLoading},
isLoadingMoreItem: ${isLoadingMoreItem},
status: ${status},
isChangeStatus: ${isChangeStatus},
nameRoll: ${nameRoll},
signerRoll: ${signerRoll},
headerForPdf: ${headerForPdf}
    ''';
  }
}
