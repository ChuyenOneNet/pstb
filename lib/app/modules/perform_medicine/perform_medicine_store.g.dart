// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'perform_medicine_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PerformMedicineStore on _PerformMedicineStore, Store {
  late final _$selectedDepartmentAtom =
      Atom(name: '_PerformMedicineStore.selectedDepartment', context: context);

  @override
  DropdownData<dynamic>? get selectedDepartment {
    _$selectedDepartmentAtom.reportRead();
    return super.selectedDepartment;
  }

  @override
  set selectedDepartment(DropdownData<dynamic>? value) {
    _$selectedDepartmentAtom.reportWrite(value, super.selectedDepartment, () {
      super.selectedDepartment = value;
    });
  }

  late final _$selectedRoomAtom =
      Atom(name: '_PerformMedicineStore.selectedRoom', context: context);

  @override
  DropdownData<dynamic>? get selectedRoom {
    _$selectedRoomAtom.reportRead();
    return super.selectedRoom;
  }

  @override
  set selectedRoom(DropdownData<dynamic>? value) {
    _$selectedRoomAtom.reportWrite(value, super.selectedRoom, () {
      super.selectedRoom = value;
    });
  }

  late final _$dateControllerAtom =
      Atom(name: '_PerformMedicineStore.dateController', context: context);

  @override
  TextEditingController get dateController {
    _$dateControllerAtom.reportRead();
    return super.dateController;
  }

  @override
  set dateController(TextEditingController value) {
    _$dateControllerAtom.reportWrite(value, super.dateController, () {
      super.dateController = value;
    });
  }

  late final _$patientCodeControllerAtom = Atom(
      name: '_PerformMedicineStore.patientCodeController', context: context);

  @override
  TextEditingController get patientCodeController {
    _$patientCodeControllerAtom.reportRead();
    return super.patientCodeController;
  }

  @override
  set patientCodeController(TextEditingController value) {
    _$patientCodeControllerAtom.reportWrite(value, super.patientCodeController,
        () {
      super.patientCodeController = value;
    });
  }

  late final _$_PerformMedicineStoreActionController =
      ActionController(name: '_PerformMedicineStore', context: context);

  @override
  void setDepartment(DropdownData<dynamic>? data) {
    final _$actionInfo = _$_PerformMedicineStoreActionController.startAction(
        name: '_PerformMedicineStore.setDepartment');
    try {
      return super.setDepartment(data);
    } finally {
      _$_PerformMedicineStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRoom(DropdownData<dynamic>? data) {
    final _$actionInfo = _$_PerformMedicineStoreActionController.startAction(
        name: '_PerformMedicineStore.setRoom');
    try {
      return super.setRoom(data);
    } finally {
      _$_PerformMedicineStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDate(DateTime date) {
    final _$actionInfo = _$_PerformMedicineStoreActionController.startAction(
        name: '_PerformMedicineStore.setDate');
    try {
      return super.setDate(date);
    } finally {
      _$_PerformMedicineStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedDepartment: ${selectedDepartment},
selectedRoom: ${selectedRoom},
dateController: ${dateController},
patientCodeController: ${patientCodeController}
    ''';
  }
}
