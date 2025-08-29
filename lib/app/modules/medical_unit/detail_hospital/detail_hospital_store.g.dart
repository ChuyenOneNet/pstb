// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_hospital_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DetailHospitalStore on _DetailHospitalStoreBase, Store {
  late final _$isLoadingAtom =
      Atom(name: '_DetailHospitalStoreBase.isLoading', context: context);

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

  late final _$isUpdateAtom =
      Atom(name: '_DetailHospitalStoreBase.isUpdate', context: context);

  @override
  bool get isUpdate {
    _$isUpdateAtom.reportRead();
    return super.isUpdate;
  }

  @override
  set isUpdate(bool value) {
    _$isUpdateAtom.reportWrite(value, super.isUpdate, () {
      super.isUpdate = value;
    });
  }

  late final _$rateAtom =
      Atom(name: '_DetailHospitalStoreBase.rate', context: context);

  @override
  int get rate {
    _$rateAtom.reportRead();
    return super.rate;
  }

  @override
  set rate(int value) {
    _$rateAtom.reportWrite(value, super.rate, () {
      super.rate = value;
    });
  }

  late final _$reviewAtom =
      Atom(name: '_DetailHospitalStoreBase.review', context: context);

  @override
  String get review {
    _$reviewAtom.reportRead();
    return super.review;
  }

  @override
  set review(String value) {
    _$reviewAtom.reportWrite(value, super.review, () {
      super.review = value;
    });
  }

  late final _$detailHospitalAtom =
      Atom(name: '_DetailHospitalStoreBase.detailHospital', context: context);

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

  late final _$userReviewModelAtom =
      Atom(name: '_DetailHospitalStoreBase.userReviewModel', context: context);

  @override
  UserReviewModel get userReviewModel {
    _$userReviewModelAtom.reportRead();
    return super.userReviewModel;
  }

  @override
  set userReviewModel(UserReviewModel value) {
    _$userReviewModelAtom.reportWrite(value, super.userReviewModel, () {
      super.userReviewModel = value;
    });
  }

  late final _$listSlideAtom =
      Atom(name: '_DetailHospitalStoreBase.listSlide', context: context);

  @override
  List<Data> get listSlide {
    _$listSlideAtom.reportRead();
    return super.listSlide;
  }

  @override
  set listSlide(List<Data> value) {
    _$listSlideAtom.reportWrite(value, super.listSlide, () {
      super.listSlide = value;
    });
  }

  late final _$listReviewHospitalAtom = Atom(
      name: '_DetailHospitalStoreBase.listReviewHospital', context: context);

  @override
  List<UserReviewModel> get listReviewHospital {
    _$listReviewHospitalAtom.reportRead();
    return super.listReviewHospital;
  }

  @override
  set listReviewHospital(List<UserReviewModel> value) {
    _$listReviewHospitalAtom.reportWrite(value, super.listReviewHospital, () {
      super.listReviewHospital = value;
    });
  }

  late final _$isCheckedAtom =
      Atom(name: '_DetailHospitalStoreBase.isChecked', context: context);

  @override
  bool get isChecked {
    _$isCheckedAtom.reportRead();
    return super.isChecked;
  }

  @override
  set isChecked(bool value) {
    _$isCheckedAtom.reportWrite(value, super.isChecked, () {
      super.isChecked = value;
    });
  }

  late final _$pageAtom =
      Atom(name: '_DetailHospitalStoreBase.page', context: context);

  @override
  int get page {
    _$pageAtom.reportRead();
    return super.page;
  }

  @override
  set page(int value) {
    _$pageAtom.reportWrite(value, super.page, () {
      super.page = value;
    });
  }

  late final _$checkLoginAsyncAction =
      AsyncAction('_DetailHospitalStoreBase.checkLogin', context: context);

  @override
  Future<void> checkLogin() {
    return _$checkLoginAsyncAction.run(() => super.checkLogin());
  }

  late final _$getDetailMedicalAsyncAction = AsyncAction(
      '_DetailHospitalStoreBase.getDetailMedical',
      context: context);

  @override
  Future<void> getDetailMedical(int id) {
    return _$getDetailMedicalAsyncAction.run(() => super.getDetailMedical(id));
  }

  late final _$getSlideMedicalAsyncAction =
      AsyncAction('_DetailHospitalStoreBase.getSlideMedical', context: context);

  @override
  Future<void> getSlideMedical(int id) {
    return _$getSlideMedicalAsyncAction.run(() => super.getSlideMedical(id));
  }

  late final _$getUserReviewUnitAsyncAction = AsyncAction(
      '_DetailHospitalStoreBase.getUserReviewUnit',
      context: context);

  @override
  Future<void> getUserReviewUnit(int id) {
    return _$getUserReviewUnitAsyncAction
        .run(() => super.getUserReviewUnit(id));
  }

  late final _$sendReviewUnitAsyncAction =
      AsyncAction('_DetailHospitalStoreBase.sendReviewUnit', context: context);

  @override
  Future<void> sendReviewUnit(int id, String content, int rate) {
    return _$sendReviewUnitAsyncAction
        .run(() => super.sendReviewUnit(id, content, rate));
  }

  late final _$updateReviewUnitAsyncAction = AsyncAction(
      '_DetailHospitalStoreBase.updateReviewUnit',
      context: context);

  @override
  Future<void> updateReviewUnit(int id, String content, int rate) {
    return _$updateReviewUnitAsyncAction
        .run(() => super.updateReviewUnit(id, content, rate));
  }

  late final _$deleteReviewUnitAsyncAction = AsyncAction(
      '_DetailHospitalStoreBase.deleteReviewUnit',
      context: context);

  @override
  Future<void> deleteReviewUnit(int id) {
    return _$deleteReviewUnitAsyncAction.run(() => super.deleteReviewUnit(id));
  }

  late final _$getReviewHospitalAsyncAction = AsyncAction(
      '_DetailHospitalStoreBase.getReviewHospital',
      context: context);

  @override
  Future<void> getReviewHospital(int id) {
    return _$getReviewHospitalAsyncAction
        .run(() => super.getReviewHospital(id));
  }

  late final _$loadMoreItemAsyncAction =
      AsyncAction('_DetailHospitalStoreBase.loadMoreItem', context: context);

  @override
  Future<void> loadMoreItem(int id) {
    return _$loadMoreItemAsyncAction.run(() => super.loadMoreItem(id));
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
isUpdate: ${isUpdate},
rate: ${rate},
review: ${review},
detailHospital: ${detailHospital},
userReviewModel: ${userReviewModel},
listSlide: ${listSlide},
listReviewHospital: ${listReviewHospital},
isChecked: ${isChecked},
page: ${page}
    ''';
  }
}
