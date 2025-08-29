// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_signature_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DetailSignatureStore on _DetailSignatureStoreBase, Store {
  late final _$linkPdfAtom =
      Atom(name: '_DetailSignatureStoreBase.linkPdf', context: context);

  @override
  String? get linkPdf {
    _$linkPdfAtom.reportRead();
    return super.linkPdf;
  }

  @override
  set linkPdf(String? value) {
    _$linkPdfAtom.reportWrite(value, super.linkPdf, () {
      super.linkPdf = value;
    });
  }

  late final _$nameStatusAtom =
      Atom(name: '_DetailSignatureStoreBase.nameStatus', context: context);

  @override
  String? get nameStatus {
    _$nameStatusAtom.reportRead();
    return super.nameStatus;
  }

  @override
  set nameStatus(String? value) {
    _$nameStatusAtom.reportWrite(value, super.nameStatus, () {
      super.nameStatus = value;
    });
  }

  late final _$statusSuccessAtom =
      Atom(name: '_DetailSignatureStoreBase.statusSuccess', context: context);

  @override
  String? get statusSuccess {
    _$statusSuccessAtom.reportRead();
    return super.statusSuccess;
  }

  @override
  set statusSuccess(String? value) {
    _$statusSuccessAtom.reportWrite(value, super.statusSuccess, () {
      super.statusSuccess = value;
    });
  }

  late final _$onDetailDocumentsAsyncAction = AsyncAction(
      '_DetailSignatureStoreBase.onDetailDocuments',
      context: context);

  @override
  Future<void> onDetailDocuments(
      {required DocumentModel documentModelSelected,
      required int indexSelected}) {
    return _$onDetailDocumentsAsyncAction.run(() => super.onDetailDocuments(
        documentModelSelected: documentModelSelected,
        indexSelected: indexSelected));
  }

  late final _$actionDocumentAsyncAction =
      AsyncAction('_DetailSignatureStoreBase.actionDocument', context: context);

  @override
  Future<void> actionDocument() {
    return _$actionDocumentAsyncAction.run(() => super.actionDocument());
  }

  late final _$onRefreshAsyncAction =
      AsyncAction('_DetailSignatureStoreBase.onRefresh', context: context);

  @override
  Future<void> onRefresh() {
    return _$onRefreshAsyncAction.run(() => super.onRefresh());
  }

  @override
  String toString() {
    return '''
linkPdf: ${linkPdf},
nameStatus: ${nameStatus},
statusSuccess: ${statusSuccess}
    ''';
  }
}
