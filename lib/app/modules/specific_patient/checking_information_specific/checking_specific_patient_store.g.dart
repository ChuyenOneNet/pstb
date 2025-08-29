// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checking_specific_patient_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CheckingSpecificPatientStore
    on CheckingSpecificPatientStoreBase, Store {
  late final _$listRegistrationAtom = Atom(
      name: 'CheckingSpecificPatientStoreBase.listRegistration',
      context: context);

  @override
  List<IndicationModel>? get listRegistration {
    _$listRegistrationAtom.reportRead();
    return super.listRegistration;
  }

  @override
  set listRegistration(List<IndicationModel>? value) {
    _$listRegistrationAtom.reportWrite(value, super.listRegistration, () {
      super.listRegistration = value;
    });
  }

  late final _$initStateAsyncAction = AsyncAction(
      'CheckingSpecificPatientStoreBase.initState',
      context: context);

  @override
  Future<void> initState() {
    return _$initStateAsyncAction.run(() => super.initState());
  }

  @override
  String toString() {
    return '''
listRegistration: ${listRegistration}
    ''';
  }
}
