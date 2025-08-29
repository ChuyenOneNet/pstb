// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pdf_indication_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PDFIndicationStore on PDFIndicationStoreBase, Store {
  late final _$urlPdfAtom =
      Atom(name: 'PDFIndicationStoreBase.urlPdf', context: context);

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

  late final _$initStateAsyncAction =
      AsyncAction('PDFIndicationStoreBase.initState', context: context);

  @override
  Future<void> initState(String url) {
    return _$initStateAsyncAction.run(() => super.initState(url));
  }

  late final _$getImagePdfPrescriptionAsyncAction = AsyncAction(
      'PDFIndicationStoreBase.getImagePdfPrescription',
      context: context);

  @override
  Future<void> getImagePdfPrescription(Prescription prescription) {
    return _$getImagePdfPrescriptionAsyncAction
        .run(() => super.getImagePdfPrescription(prescription));
  }

  @override
  String toString() {
    return '''
urlPdf: ${urlPdf}
    ''';
  }
}
