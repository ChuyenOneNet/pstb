// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medical_package_detail_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MedicalPackageDetailStore on MedicalPackageDetailStoreBase, Store {
  Computed<List<ExaminationProcedure>?>? _$sortedProcedureComputed;

  @override
  List<ExaminationProcedure>? get sortedProcedure =>
      (_$sortedProcedureComputed ??= Computed<List<ExaminationProcedure>?>(
              () => super.sortedProcedure,
              name: 'MedicalPackageDetailStoreBase.sortedProcedure'))
          .value;
  Computed<bool>? _$isCovidPackageComputed;

  @override
  bool get isCovidPackage =>
      (_$isCovidPackageComputed ??= Computed<bool>(() => super.isCovidPackage,
              name: 'MedicalPackageDetailStoreBase.isCovidPackage'))
          .value;

  late final _$genderAtom =
      Atom(name: 'MedicalPackageDetailStoreBase.gender', context: context);

  @override
  String get gender {
    _$genderAtom.reportRead();
    return super.gender;
  }

  @override
  set gender(String value) {
    _$genderAtom.reportWrite(value, super.gender, () {
      super.gender = value;
    });
  }

  late final _$relationAtom =
      Atom(name: 'MedicalPackageDetailStoreBase.relation', context: context);

  @override
  Relation get relation {
    _$relationAtom.reportRead();
    return super.relation;
  }

  @override
  set relation(Relation value) {
    _$relationAtom.reportWrite(value, super.relation, () {
      super.relation = value;
    });
  }

  late final _$countAtom =
      Atom(name: 'MedicalPackageDetailStoreBase.count', context: context);

  @override
  int get count {
    _$countAtom.reportRead();
    return super.count;
  }

  @override
  set count(int value) {
    _$countAtom.reportWrite(value, super.count, () {
      super.count = value;
    });
  }

  late final _$loadingOtherAtom = Atom(
      name: 'MedicalPackageDetailStoreBase.loadingOther', context: context);

  @override
  bool get loadingOther {
    _$loadingOtherAtom.reportRead();
    return super.loadingOther;
  }

  @override
  set loadingOther(bool value) {
    _$loadingOtherAtom.reportWrite(value, super.loadingOther, () {
      super.loadingOther = value;
    });
  }

  late final _$packageAtom =
      Atom(name: 'MedicalPackageDetailStoreBase.package', context: context);

  @override
  Package get package {
    _$packageAtom.reportRead();
    return super.package;
  }

  @override
  set package(Package value) {
    _$packageAtom.reportWrite(value, super.package, () {
      super.package = value;
    });
  }

  late final _$detailsAtom =
      Atom(name: 'MedicalPackageDetailStoreBase.details', context: context);

  @override
  PackageModel get details {
    _$detailsAtom.reportRead();
    return super.details;
  }

  @override
  set details(PackageModel value) {
    _$detailsAtom.reportWrite(value, super.details, () {
      super.details = value;
    });
  }

  late final _$otherPackagesAtom = Atom(
      name: 'MedicalPackageDetailStoreBase.otherPackages', context: context);

  @override
  ObservableList<NewMedicalPackageDetailModel> get otherPackages {
    _$otherPackagesAtom.reportRead();
    return super.otherPackages;
  }

  @override
  set otherPackages(ObservableList<NewMedicalPackageDetailModel> value) {
    _$otherPackagesAtom.reportWrite(value, super.otherPackages, () {
      super.otherPackages = value;
    });
  }

  late final _$scrollIsReachedAtom = Atom(
      name: 'MedicalPackageDetailStoreBase.scrollIsReached', context: context);

  @override
  bool get scrollIsReached {
    _$scrollIsReachedAtom.reportRead();
    return super.scrollIsReached;
  }

  @override
  set scrollIsReached(bool value) {
    _$scrollIsReachedAtom.reportWrite(value, super.scrollIsReached, () {
      super.scrollIsReached = value;
    });
  }

  late final _$loadingPackageDetailAtom = Atom(
      name: 'MedicalPackageDetailStoreBase.loadingPackageDetail',
      context: context);

  @override
  bool get loadingPackageDetail {
    _$loadingPackageDetailAtom.reportRead();
    return super.loadingPackageDetail;
  }

  @override
  set loadingPackageDetail(bool value) {
    _$loadingPackageDetailAtom.reportWrite(value, super.loadingPackageDetail,
        () {
      super.loadingPackageDetail = value;
    });
  }

  late final _$getBookingAdvisoryAsyncAction = AsyncAction(
      'MedicalPackageDetailStoreBase.getBookingAdvisory',
      context: context);

  @override
  Future<void> getBookingAdvisory(int packageId) {
    return _$getBookingAdvisoryAsyncAction
        .run(() => super.getBookingAdvisory(packageId));
  }

  late final _$getPackageDetailAsyncAction = AsyncAction(
      'MedicalPackageDetailStoreBase.getPackageDetail',
      context: context);

  @override
  Future<void> getPackageDetail(int? id) {
    return _$getPackageDetailAsyncAction.run(() => super.getPackageDetail(id));
  }

  late final _$getNewPackageDetailAsyncAction = AsyncAction(
      'MedicalPackageDetailStoreBase.getNewPackageDetail',
      context: context);

  @override
  Future<void> getNewPackageDetail(int id) {
    return _$getNewPackageDetailAsyncAction
        .run(() => super.getNewPackageDetail(id));
  }

  late final _$MedicalPackageDetailStoreBaseActionController =
      ActionController(name: 'MedicalPackageDetailStoreBase', context: context);

  @override
  void changeGender(String g) {
    final _$actionInfo = _$MedicalPackageDetailStoreBaseActionController
        .startAction(name: 'MedicalPackageDetailStoreBase.changeGender');
    try {
      return super.changeGender(g);
    } finally {
      _$MedicalPackageDetailStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeRelation(Relation r) {
    final _$actionInfo = _$MedicalPackageDetailStoreBaseActionController
        .startAction(name: 'MedicalPackageDetailStoreBase.changeRelation');
    try {
      return super.changeRelation(r);
    } finally {
      _$MedicalPackageDetailStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void createBuildContext(BuildContext newContext) {
    final _$actionInfo = _$MedicalPackageDetailStoreBaseActionController
        .startAction(name: 'MedicalPackageDetailStoreBase.createBuildContext');
    try {
      return super.createBuildContext(newContext);
    } finally {
      _$MedicalPackageDetailStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void scrollListener(double height) {
    final _$actionInfo = _$MedicalPackageDetailStoreBaseActionController
        .startAction(name: 'MedicalPackageDetailStoreBase.scrollListener');
    try {
      return super.scrollListener(height);
    } finally {
      _$MedicalPackageDetailStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addListener(BuildContext newContext, double height) {
    final _$actionInfo = _$MedicalPackageDetailStoreBaseActionController
        .startAction(name: 'MedicalPackageDetailStoreBase.addListener');
    try {
      return super.addListener(newContext, height);
    } finally {
      _$MedicalPackageDetailStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void navigateTo(String routeName) {
    final _$actionInfo = _$MedicalPackageDetailStoreBaseActionController
        .startAction(name: 'MedicalPackageDetailStoreBase.navigateTo');
    try {
      return super.navigateTo(routeName);
    } finally {
      _$MedicalPackageDetailStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDetailsPackage(PackageModel data) {
    final _$actionInfo = _$MedicalPackageDetailStoreBaseActionController
        .startAction(name: 'MedicalPackageDetailStoreBase.setDetailsPackage');
    try {
      return super.setDetailsPackage(data);
    } finally {
      _$MedicalPackageDetailStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
gender: ${gender},
relation: ${relation},
count: ${count},
loadingOther: ${loadingOther},
package: ${package},
details: ${details},
otherPackages: ${otherPackages},
scrollIsReached: ${scrollIsReached},
loadingPackageDetail: ${loadingPackageDetail},
sortedProcedure: ${sortedProcedure},
isCovidPackage: ${isCovidPackage}
    ''';
  }
}
