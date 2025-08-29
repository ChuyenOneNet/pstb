// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'specific_patient_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SpecificPatientStore on SpecificPatientStoreBase, Store {
  late final _$isSuccessPatientAtom =
      Atom(name: 'SpecificPatientStoreBase.isSuccessPatient', context: context);

  @override
  bool get isSuccessPatient {
    _$isSuccessPatientAtom.reportRead();
    return super.isSuccessPatient;
  }

  @override
  set isSuccessPatient(bool value) {
    _$isSuccessPatientAtom.reportWrite(value, super.isSuccessPatient, () {
      super.isSuccessPatient = value;
    });
  }

  late final _$SpecificPatientStoreBaseActionController =
      ActionController(name: 'SpecificPatientStoreBase', context: context);

  @override
  void searchingPatient() {
    final _$actionInfo = _$SpecificPatientStoreBaseActionController.startAction(
        name: 'SpecificPatientStoreBase.searchingPatient');
    try {
      return super.searchingPatient();
    } finally {
      _$SpecificPatientStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onSubmitPatient() {
    final _$actionInfo = _$SpecificPatientStoreBaseActionController.startAction(
        name: 'SpecificPatientStoreBase.onSubmitPatient');
    try {
      return super.onSubmitPatient();
    } finally {
      _$SpecificPatientStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isSuccessPatient: ${isSuccessPatient}
    ''';
  }
}
