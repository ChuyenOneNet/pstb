// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selection_hospital_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SelectionHospitalStore on _SelectionHospitalStoreBase, Store {
  late final _$isLoadingAtom =
      Atom(name: '_SelectionHospitalStoreBase.isLoading', context: context);

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

  late final _$isChooseAtom =
      Atom(name: '_SelectionHospitalStoreBase.isChoose', context: context);

  @override
  bool get isChoose {
    _$isChooseAtom.reportRead();
    return super.isChoose;
  }

  @override
  set isChoose(bool value) {
    _$isChooseAtom.reportWrite(value, super.isChoose, () {
      super.isChoose = value;
    });
  }

  late final _$slideNoAtom =
      Atom(name: '_SelectionHospitalStoreBase.slideNo', context: context);

  @override
  int get slideNo {
    _$slideNoAtom.reportRead();
    return super.slideNo;
  }

  @override
  set slideNo(int value) {
    _$slideNoAtom.reportWrite(value, super.slideNo, () {
      super.slideNo = value;
    });
  }

  late final _$listHospitalAtom =
      Atom(name: '_SelectionHospitalStoreBase.listHospital', context: context);

  @override
  List<HospitalModel> get listHospital {
    _$listHospitalAtom.reportRead();
    return super.listHospital;
  }

  @override
  set listHospital(List<HospitalModel> value) {
    _$listHospitalAtom.reportWrite(value, super.listHospital, () {
      super.listHospital = value;
    });
  }

  late final _$detailHospitalAtom = Atom(
      name: '_SelectionHospitalStoreBase.detailHospital', context: context);

  @override
  DetailHospitalModel get detailHospital {
    _$detailHospitalAtom.reportRead();
    return super.detailHospital;
  }

  @override
  set detailHospital(DetailHospitalModel value) {
    _$detailHospitalAtom.reportWrite(value, super.detailHospital, () {
      super.detailHospital = value;
    });
  }

  late final _$checkedAtom =
      Atom(name: '_SelectionHospitalStoreBase.checked', context: context);

  @override
  List<bool> get checked {
    _$checkedAtom.reportRead();
    return super.checked;
  }

  @override
  set checked(List<bool> value) {
    _$checkedAtom.reportWrite(value, super.checked, () {
      super.checked = value;
    });
  }

  late final _$listUnitProminentAtom = Atom(
      name: '_SelectionHospitalStoreBase.listUnitProminent', context: context);

  @override
  List<HospitalModel> get listUnitProminent {
    _$listUnitProminentAtom.reportRead();
    return super.listUnitProminent;
  }

  @override
  set listUnitProminent(List<HospitalModel> value) {
    _$listUnitProminentAtom.reportWrite(value, super.listUnitProminent, () {
      super.listUnitProminent = value;
    });
  }

  late final _$getHospitalsAsyncAction =
      AsyncAction('_SelectionHospitalStoreBase.getHospitals', context: context);

  @override
  Future<void> getHospitals(bool forced) {
    return _$getHospitalsAsyncAction.run(() => super.getHospitals(forced));
  }

  late final _$checkUnitChooseAsyncAction = AsyncAction(
      '_SelectionHospitalStoreBase.checkUnitChoose',
      context: context);

  @override
  Future<void> checkUnitChoose() {
    return _$checkUnitChooseAsyncAction.run(() => super.checkUnitChoose());
  }

  late final _$getUnitProminentAsyncAction = AsyncAction(
      '_SelectionHospitalStoreBase.getUnitProminent',
      context: context);

  @override
  Future<void> getUnitProminent() {
    return _$getUnitProminentAsyncAction.run(() => super.getUnitProminent());
  }

  late final _$_SelectionHospitalStoreBaseActionController =
      ActionController(name: '_SelectionHospitalStoreBase', context: context);

  @override
  void changeNews(dynamic indexOfPage) {
    final _$actionInfo = _$_SelectionHospitalStoreBaseActionController
        .startAction(name: '_SelectionHospitalStoreBase.changeNews');
    try {
      return super.changeNews(indexOfPage);
    } finally {
      _$_SelectionHospitalStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
isChoose: ${isChoose},
slideNo: ${slideNo},
listHospital: ${listHospital},
detailHospital: ${detailHospital},
checked: ${checked},
listUnitProminent: ${listUnitProminent}
    ''';
  }
}
