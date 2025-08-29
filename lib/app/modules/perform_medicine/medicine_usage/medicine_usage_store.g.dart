// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicine_usage_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MedicineUsageStore on _MedicineUsageStore, Store {
  late final _$usagesAtom =
      Atom(name: '_MedicineUsageStore.usages', context: context);

  @override
  ObservableList<MedicineUsageModel> get usages {
    _$usagesAtom.reportRead();
    return super.usages;
  }

  @override
  set usages(ObservableList<MedicineUsageModel> value) {
    _$usagesAtom.reportWrite(value, super.usages, () {
      super.usages = value;
    });
  }

  late final _$_MedicineUsageStoreActionController =
      ActionController(name: '_MedicineUsageStore', context: context);

  @override
  void setUsages(List<MedicineUsageModel> data) {
    final _$actionInfo = _$_MedicineUsageStoreActionController.startAction(
        name: '_MedicineUsageStore.setUsages');
    try {
      return super.setUsages(data);
    } finally {
      _$_MedicineUsageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateWholeAmount(int index, double value) {
    final _$actionInfo = _$_MedicineUsageStoreActionController.startAction(
        name: '_MedicineUsageStore.updateWholeAmount');
    try {
      return super.updateWholeAmount(index, value);
    } finally {
      _$_MedicineUsageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updatePartialAmount(int index, double value) {
    final _$actionInfo = _$_MedicineUsageStoreActionController.startAction(
        name: '_MedicineUsageStore.updatePartialAmount');
    try {
      return super.updatePartialAmount(index, value);
    } finally {
      _$_MedicineUsageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleBeforeMeal(int index, bool value) {
    final _$actionInfo = _$_MedicineUsageStoreActionController.startAction(
        name: '_MedicineUsageStore.toggleBeforeMeal');
    try {
      return super.toggleBeforeMeal(index, value);
    } finally {
      _$_MedicineUsageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleAfterMeal(int index, bool value) {
    final _$actionInfo = _$_MedicineUsageStoreActionController.startAction(
        name: '_MedicineUsageStore.toggleAfterMeal');
    try {
      return super.toggleAfterMeal(index, value);
    } finally {
      _$_MedicineUsageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleHasProgress(int index, bool value) {
    final _$actionInfo = _$_MedicineUsageStoreActionController.startAction(
        name: '_MedicineUsageStore.toggleHasProgress');
    try {
      return super.toggleHasProgress(index, value);
    } finally {
      _$_MedicineUsageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleIsOther(int index, bool value) {
    final _$actionInfo = _$_MedicineUsageStoreActionController.startAction(
        name: '_MedicineUsageStore.toggleIsOther');
    try {
      return super.toggleIsOther(index, value);
    } finally {
      _$_MedicineUsageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
usages: ${usages}
    ''';
  }
}
