// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BusinessStore on BusinessStoreBase, Store {
  late final _$loadingAtom =
      Atom(name: 'BusinessStoreBase.loading', context: context);

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  late final _$userBusinessAtom =
      Atom(name: 'BusinessStoreBase.userBusiness', context: context);

  @override
  UserBusinessModel get userBusiness {
    _$userBusinessAtom.reportRead();
    return super.userBusiness;
  }

  @override
  set userBusiness(UserBusinessModel value) {
    _$userBusinessAtom.reportWrite(value, super.userBusiness, () {
      super.userBusiness = value;
    });
  }

  late final _$listBusinessAtom =
      Atom(name: 'BusinessStoreBase.listBusiness', context: context);

  @override
  List<BusinessModel> get listBusiness {
    _$listBusinessAtom.reportRead();
    return super.listBusiness;
  }

  @override
  set listBusiness(List<BusinessModel> value) {
    _$listBusinessAtom.reportWrite(value, super.listBusiness, () {
      super.listBusiness = value;
    });
  }

  late final _$businessDetailAtom =
      Atom(name: 'BusinessStoreBase.businessDetail', context: context);

  @override
  BusinessDetailModel? get businessDetail {
    _$businessDetailAtom.reportRead();
    return super.businessDetail;
  }

  @override
  set businessDetail(BusinessDetailModel? value) {
    _$businessDetailAtom.reportWrite(value, super.businessDetail, () {
      super.businessDetail = value;
    });
  }

  late final _$isLoadingDetailAtom =
      Atom(name: 'BusinessStoreBase.isLoadingDetail', context: context);

  @override
  bool get isLoadingDetail {
    _$isLoadingDetailAtom.reportRead();
    return super.isLoadingDetail;
  }

  @override
  set isLoadingDetail(bool value) {
    _$isLoadingDetailAtom.reportWrite(value, super.isLoadingDetail, () {
      super.isLoadingDetail = value;
    });
  }

  late final _$getUserBusinessAsyncAction =
      AsyncAction('BusinessStoreBase.getUserBusiness', context: context);

  @override
  Future<void> getUserBusiness(
      {required String maYte, required String password}) {
    return _$getUserBusinessAsyncAction
        .run(() => super.getUserBusiness(maYte: maYte, password: password));
  }

  late final _$loadHistoryRecordAsyncAction =
      AsyncAction('BusinessStoreBase.loadHistoryRecord', context: context);

  @override
  Future<dynamic> loadHistoryRecord({DateTime? fromDate, DateTime? toDate}) {
    return _$loadHistoryRecordAsyncAction
        .run(() => super.loadHistoryRecord(fromDate: fromDate, toDate: toDate));
  }

  late final _$loadBusinessDetailAsyncAction =
      AsyncAction('BusinessStoreBase.loadBusinessDetail', context: context);

  @override
  Future<void> loadBusinessDetail(String id) {
    return _$loadBusinessDetailAsyncAction
        .run(() => super.loadBusinessDetail(id));
  }

  late final _$fetchVienPhiPdfBase64AsyncAction =
      AsyncAction('BusinessStoreBase.fetchVienPhiPdfBase64', context: context);

  @override
  Future<String?> fetchVienPhiPdfBase64(String maGiaoDich) {
    return _$fetchVienPhiPdfBase64AsyncAction
        .run(() => super.fetchVienPhiPdfBase64(maGiaoDich));
  }

  late final _$resetPasswordAsyncAction =
      AsyncAction('BusinessStoreBase.resetPassword', context: context);

  @override
  Future<bool> resetPassword({required String userName}) {
    return _$resetPasswordAsyncAction
        .run(() => super.resetPassword(userName: userName));
  }

  late final _$changePasswordAsyncAction =
      AsyncAction('BusinessStoreBase.changePassword', context: context);

  @override
  Future<bool> changePassword(
      {required String userName,
      required String oldPassword,
      required String newPassword}) {
    return _$changePasswordAsyncAction.run(() => super.changePassword(
        userName: userName,
        oldPassword: oldPassword,
        newPassword: newPassword));
  }

  @override
  String toString() {
    return '''
loading: ${loading},
userBusiness: ${userBusiness},
listBusiness: ${listBusiness},
businessDetail: ${businessDetail},
isLoadingDetail: ${isLoadingDetail}
    ''';
  }
}
