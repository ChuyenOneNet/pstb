// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'select_doctor_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SelectDoctorStore on _SelectDoctorStoreBase, Store {
  Computed<int>? _$lengthListDoctorComputed;

  @override
  int get lengthListDoctor => (_$lengthListDoctorComputed ??= Computed<int>(
          () => super.lengthListDoctor,
          name: '_SelectDoctorStoreBase.lengthListDoctor'))
      .value;
  Computed<bool>? _$isFinishLoadMoreComputed;

  @override
  bool get isFinishLoadMore => (_$isFinishLoadMoreComputed ??= Computed<bool>(
          () => super.isFinishLoadMore,
          name: '_SelectDoctorStoreBase.isFinishLoadMore'))
      .value;

  late final _$totalsAtom =
      Atom(name: '_SelectDoctorStoreBase.totals', context: context);

  @override
  int get totals {
    _$totalsAtom.reportRead();
    return super.totals;
  }

  @override
  set totals(int value) {
    _$totalsAtom.reportWrite(value, super.totals, () {
      super.totals = value;
    });
  }

  late final _$keywordSearchAtom =
      Atom(name: '_SelectDoctorStoreBase.keywordSearch', context: context);

  @override
  List<String> get keywordSearch {
    _$keywordSearchAtom.reportRead();
    return super.keywordSearch;
  }

  @override
  set keywordSearch(List<String> value) {
    _$keywordSearchAtom.reportWrite(value, super.keywordSearch, () {
      super.keywordSearch = value;
    });
  }

  late final _$keywordAtom =
      Atom(name: '_SelectDoctorStoreBase.keyword', context: context);

  @override
  String get keyword {
    _$keywordAtom.reportRead();
    return super.keyword;
  }

  @override
  set keyword(String value) {
    _$keywordAtom.reportWrite(value, super.keyword, () {
      super.keyword = value;
    });
  }

  late final _$pageIndexAtom =
      Atom(name: '_SelectDoctorStoreBase.pageIndex', context: context);

  @override
  int get pageIndex {
    _$pageIndexAtom.reportRead();
    return super.pageIndex;
  }

  @override
  set pageIndex(int value) {
    _$pageIndexAtom.reportWrite(value, super.pageIndex, () {
      super.pageIndex = value;
    });
  }

  late final _$idDoctorAtom =
      Atom(name: '_SelectDoctorStoreBase.idDoctor', context: context);

  @override
  int get idDoctor {
    _$idDoctorAtom.reportRead();
    return super.idDoctor;
  }

  @override
  set idDoctor(int value) {
    _$idDoctorAtom.reportWrite(value, super.idDoctor, () {
      super.idDoctor = value;
    });
  }

  late final _$medicalUnitIdAtom =
      Atom(name: '_SelectDoctorStoreBase.medicalUnitId', context: context);

  @override
  int get medicalUnitId {
    _$medicalUnitIdAtom.reportRead();
    return super.medicalUnitId;
  }

  @override
  set medicalUnitId(int value) {
    _$medicalUnitIdAtom.reportWrite(value, super.medicalUnitId, () {
      super.medicalUnitId = value;
    });
  }

  late final _$doctorAtom =
      Atom(name: '_SelectDoctorStoreBase.doctor', context: context);

  @override
  DoctorPagingItem get doctor {
    _$doctorAtom.reportRead();
    return super.doctor;
  }

  @override
  set doctor(DoctorPagingItem value) {
    _$doctorAtom.reportWrite(value, super.doctor, () {
      super.doctor = value;
    });
  }

  late final _$listDoctorAtom =
      Atom(name: '_SelectDoctorStoreBase.listDoctor', context: context);

  @override
  ObservableList<DoctorPagingItem> get listDoctor {
    _$listDoctorAtom.reportRead();
    return super.listDoctor;
  }

  @override
  set listDoctor(ObservableList<DoctorPagingItem> value) {
    _$listDoctorAtom.reportWrite(value, super.listDoctor, () {
      super.listDoctor = value;
    });
  }

  late final _$listDoctorSearchAtom =
      Atom(name: '_SelectDoctorStoreBase.listDoctorSearch', context: context);

  @override
  ObservableList<DoctorPagingItem> get listDoctorSearch {
    _$listDoctorSearchAtom.reportRead();
    return super.listDoctorSearch;
  }

  @override
  set listDoctorSearch(ObservableList<DoctorPagingItem> value) {
    _$listDoctorSearchAtom.reportWrite(value, super.listDoctorSearch, () {
      super.listDoctorSearch = value;
    });
  }

  late final _$onGetListDoctorAsyncAction =
      AsyncAction('_SelectDoctorStoreBase.onGetListDoctor', context: context);

  @override
  Future<void> onGetListDoctor(String packageDoctorsName) {
    return _$onGetListDoctorAsyncAction
        .run(() => super.onGetListDoctor(packageDoctorsName));
  }

  late final _$getSearchDoctorAsyncAction =
      AsyncAction('_SelectDoctorStoreBase.getSearchDoctor', context: context);

  @override
  Future<void> getSearchDoctor(String value) {
    return _$getSearchDoctorAsyncAction.run(() => super.getSearchDoctor(value));
  }

  late final _$onLoadMoreAsyncAction =
      AsyncAction('_SelectDoctorStoreBase.onLoadMore', context: context);

  @override
  Future<bool> onLoadMore() {
    return _$onLoadMoreAsyncAction.run(() => super.onLoadMore());
  }

  late final _$onRefreshAsyncAction =
      AsyncAction('_SelectDoctorStoreBase.onRefresh', context: context);

  @override
  Future<void> onRefresh(String packageDoctorsName) {
    return _$onRefreshAsyncAction
        .run(() => super.onRefresh(packageDoctorsName));
  }

  late final _$_SelectDoctorStoreBaseActionController =
      ActionController(name: '_SelectDoctorStoreBase', context: context);

  @override
  void createBuildContext(BuildContext newContext) {
    final _$actionInfo = _$_SelectDoctorStoreBaseActionController.startAction(
        name: '_SelectDoctorStoreBase.createBuildContext');
    try {
      return super.createBuildContext(newContext);
    } finally {
      _$_SelectDoctorStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void navigateTo(String routeName, int id) {
    final _$actionInfo = _$_SelectDoctorStoreBaseActionController.startAction(
        name: '_SelectDoctorStoreBase.navigateTo');
    try {
      return super.navigateTo(routeName, id);
    } finally {
      _$_SelectDoctorStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
totals: ${totals},
keywordSearch: ${keywordSearch},
keyword: ${keyword},
pageIndex: ${pageIndex},
idDoctor: ${idDoctor},
medicalUnitId: ${medicalUnitId},
doctor: ${doctor},
listDoctor: ${listDoctor},
listDoctorSearch: ${listDoctorSearch},
lengthListDoctor: ${lengthListDoctor},
isFinishLoadMore: ${isFinishLoadMore}
    ''';
  }
}
