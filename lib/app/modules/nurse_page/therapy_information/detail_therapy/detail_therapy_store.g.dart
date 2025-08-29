// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_therapy_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DetailTherapyStore on _DetailTherapyStoreBase, Store {
  late final _$commandDataAtom =
      Atom(name: '_DetailTherapyStoreBase.commandData', context: context);

  @override
  List<CommandModel> get commandData {
    _$commandDataAtom.reportRead();
    return super.commandData;
  }

  @override
  set commandData(List<CommandModel> value) {
    _$commandDataAtom.reportWrite(value, super.commandData, () {
      super.commandData = value;
    });
  }

  late final _$patientModelAtom =
      Atom(name: '_DetailTherapyStoreBase.patientModel', context: context);

  @override
  PatientModel get patientModel {
    _$patientModelAtom.reportRead();
    return super.patientModel;
  }

  @override
  set patientModel(PatientModel value) {
    _$patientModelAtom.reportWrite(value, super.patientModel, () {
      super.patientModel = value;
    });
  }

  late final _$healthCareDataAtom =
      Atom(name: '_DetailTherapyStoreBase.healthCareData', context: context);

  @override
  List<NurseModel> get healthCareData {
    _$healthCareDataAtom.reportRead();
    return super.healthCareData;
  }

  @override
  set healthCareData(List<NurseModel> value) {
    _$healthCareDataAtom.reportWrite(value, super.healthCareData, () {
      super.healthCareData = value;
    });
  }

  late final _$dateTimeSelectedAtom =
      Atom(name: '_DetailTherapyStoreBase.dateTimeSelected', context: context);

  @override
  DateTime get dateTimeSelected {
    _$dateTimeSelectedAtom.reportRead();
    return super.dateTimeSelected;
  }

  @override
  set dateTimeSelected(DateTime value) {
    _$dateTimeSelectedAtom.reportWrite(value, super.dateTimeSelected, () {
      super.dateTimeSelected = value;
    });
  }

  late final _$currentIndexAtom =
      Atom(name: '_DetailTherapyStoreBase.currentIndex', context: context);

  @override
  int get currentIndex {
    _$currentIndexAtom.reportRead();
    return super.currentIndex;
  }

  @override
  set currentIndex(int value) {
    _$currentIndexAtom.reportWrite(value, super.currentIndex, () {
      super.currentIndex = value;
    });
  }

  late final _$onRefreshAsyncAction =
      AsyncAction('_DetailTherapyStoreBase.onRefresh', context: context);

  @override
  Future<void> onRefresh() {
    return _$onRefreshAsyncAction.run(() => super.onRefresh());
  }

  late final _$_DetailTherapyStoreBaseActionController =
      ActionController(name: '_DetailTherapyStoreBase', context: context);

  @override
  void onChangeIndex(int index) {
    final _$actionInfo = _$_DetailTherapyStoreBaseActionController.startAction(
        name: '_DetailTherapyStoreBase.onChangeIndex');
    try {
      return super.onChangeIndex(index);
    } finally {
      _$_DetailTherapyStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
commandData: ${commandData},
patientModel: ${patientModel},
healthCareData: ${healthCareData},
dateTimeSelected: ${dateTimeSelected},
currentIndex: ${currentIndex}
    ''';
  }
}
