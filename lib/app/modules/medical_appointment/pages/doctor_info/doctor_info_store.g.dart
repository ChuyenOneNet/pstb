// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_info_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DoctorInfoStore on DoctorInfoStoreBase, Store {
  late final _$doctorDataAtom =
      Atom(name: 'DoctorInfoStoreBase.doctorData', context: context);

  @override
  DoctorPagingItem get doctorData {
    _$doctorDataAtom.reportRead();
    return super.doctorData;
  }

  @override
  set doctorData(DoctorPagingItem value) {
    _$doctorDataAtom.reportWrite(value, super.doctorData, () {
      super.doctorData = value;
    });
  }

  late final _$packagesListAtom =
      Atom(name: 'DoctorInfoStoreBase.packagesList', context: context);

  @override
  ObservableList<PackageModel> get packagesList {
    _$packagesListAtom.reportRead();
    return super.packagesList;
  }

  @override
  set packagesList(ObservableList<PackageModel> value) {
    _$packagesListAtom.reportWrite(value, super.packagesList, () {
      super.packagesList = value;
    });
  }

  late final _$onGetDoctorAsyncAction =
      AsyncAction('DoctorInfoStoreBase.onGetDoctor', context: context);

  @override
  Future<void> onGetDoctor(String id) {
    return _$onGetDoctorAsyncAction.run(() => super.onGetDoctor(id));
  }

  late final _$setDoctorAsyncAction =
      AsyncAction('DoctorInfoStoreBase.setDoctor', context: context);

  @override
  Future<void> setDoctor(DoctorPagingItem doctor) {
    return _$setDoctorAsyncAction.run(() => super.setDoctor(doctor));
  }

  late final _$getMedicalServiceAsyncAction =
      AsyncAction('DoctorInfoStoreBase.getMedicalService', context: context);

  @override
  Future<void> getMedicalService(int id) {
    return _$getMedicalServiceAsyncAction
        .run(() => super.getMedicalService(id));
  }

  @override
  String toString() {
    return '''
doctorData: ${doctorData},
packagesList: ${packagesList}
    ''';
  }
}
