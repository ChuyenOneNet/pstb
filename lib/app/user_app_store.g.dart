// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_app_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserAppStore on UserAppStoreBase, Store {
  Computed<String>? _$getUserNameComputed;

  @override
  String get getUserName =>
      (_$getUserNameComputed ??= Computed<String>(() => super.getUserName,
              name: 'UserAppStoreBase.getUserName'))
          .value;
  Computed<String>? _$getUserProvinceComputed;

  @override
  String get getUserProvince => (_$getUserProvinceComputed ??= Computed<String>(
          () => super.getUserProvince,
          name: 'UserAppStoreBase.getUserProvince'))
      .value;
  Computed<String>? _$getUserDistrictComputed;

  @override
  String get getUserDistrict => (_$getUserDistrictComputed ??= Computed<String>(
          () => super.getUserDistrict,
          name: 'UserAppStoreBase.getUserDistrict'))
      .value;
  Computed<String>? _$getUserAddressComputed;

  @override
  String get getUserAddress =>
      (_$getUserAddressComputed ??= Computed<String>(() => super.getUserAddress,
              name: 'UserAppStoreBase.getUserAddress'))
          .value;
  Computed<String>? _$getUserPhoneComputed;

  @override
  String get getUserPhone =>
      (_$getUserPhoneComputed ??= Computed<String>(() => super.getUserPhone,
              name: 'UserAppStoreBase.getUserPhone'))
          .value;
  Computed<String>? _$getUserDobComputed;

  @override
  String get getUserDob =>
      (_$getUserDobComputed ??= Computed<String>(() => super.getUserDob,
              name: 'UserAppStoreBase.getUserDob'))
          .value;
  Computed<String>? _$getUserEmailComputed;

  @override
  String get getUserEmail =>
      (_$getUserEmailComputed ??= Computed<String>(() => super.getUserEmail,
              name: 'UserAppStoreBase.getUserEmail'))
          .value;
  Computed<String>? _$getUserGenderComputed;

  @override
  String get getUserGender =>
      (_$getUserGenderComputed ??= Computed<String>(() => super.getUserGender,
              name: 'UserAppStoreBase.getUserGender'))
          .value;

  late final _$userAtom = Atom(name: 'UserAppStoreBase.user', context: context);

  @override
  User.UserInfoModel get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(User.UserInfoModel value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  late final _$loadingUserDataAtom =
      Atom(name: 'UserAppStoreBase.loadingUserData', context: context);

  @override
  bool get loadingUserData {
    _$loadingUserDataAtom.reportRead();
    return super.loadingUserData;
  }

  @override
  set loadingUserData(bool value) {
    _$loadingUserDataAtom.reportWrite(value, super.loadingUserData, () {
      super.loadingUserData = value;
    });
  }

  late final _$visibleSelectDoctorAtom =
      Atom(name: 'UserAppStoreBase.visibleSelectDoctor', context: context);

  @override
  bool get visibleSelectDoctor {
    _$visibleSelectDoctorAtom.reportRead();
    return super.visibleSelectDoctor;
  }

  @override
  set visibleSelectDoctor(bool value) {
    _$visibleSelectDoctorAtom.reportWrite(value, super.visibleSelectDoctor, () {
      super.visibleSelectDoctor = value;
    });
  }

  late final _$progressAtom =
      Atom(name: 'UserAppStoreBase.progress', context: context);

  @override
  double get progress {
    _$progressAtom.reportRead();
    return super.progress;
  }

  @override
  set progress(double value) {
    _$progressAtom.reportWrite(value, super.progress, () {
      super.progress = value;
    });
  }

  late final _$isCodeNursingAtom =
      Atom(name: 'UserAppStoreBase.isCodeNursing', context: context);

  @override
  bool get isCodeNursing {
    _$isCodeNursingAtom.reportRead();
    return super.isCodeNursing;
  }

  @override
  set isCodeNursing(bool value) {
    _$isCodeNursingAtom.reportWrite(value, super.isCodeNursing, () {
      super.isCodeNursing = value;
    });
  }

  late final _$codeNursingAtom =
      Atom(name: 'UserAppStoreBase.codeNursing', context: context);

  @override
  String? get codeNursing {
    _$codeNursingAtom.reportRead();
    return super.codeNursing;
  }

  @override
  set codeNursing(String? value) {
    _$codeNursingAtom.reportWrite(value, super.codeNursing, () {
      super.codeNursing = value;
    });
  }

  late final _$isConnectedHisAtom =
      Atom(name: 'UserAppStoreBase.isConnectedHis', context: context);

  @override
  bool? get isConnectedHis {
    _$isConnectedHisAtom.reportRead();
    return super.isConnectedHis;
  }

  @override
  set isConnectedHis(bool? value) {
    _$isConnectedHisAtom.reportWrite(value, super.isConnectedHis, () {
      super.isConnectedHis = value;
    });
  }

  late final _$doctorAtom =
      Atom(name: 'UserAppStoreBase.doctor', context: context);

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

  late final _$hospitalAtom =
      Atom(name: 'UserAppStoreBase.hospital', context: context);

  @override
  HospitalModel get hospital {
    _$hospitalAtom.reportRead();
    return super.hospital;
  }

  @override
  set hospital(HospitalModel value) {
    _$hospitalAtom.reportWrite(value, super.hospital, () {
      super.hospital = value;
    });
  }

  late final _$itemAtom = Atom(name: 'UserAppStoreBase.item', context: context);

  @override
  Items get item {
    _$itemAtom.reportRead();
    return super.item;
  }

  @override
  set item(Items value) {
    _$itemAtom.reportWrite(value, super.item, () {
      super.item = value;
    });
  }

  late final _$medicalPackageAtom =
      Atom(name: 'UserAppStoreBase.medicalPackage', context: context);

  @override
  PackageModel get medicalPackage {
    _$medicalPackageAtom.reportRead();
    return super.medicalPackage;
  }

  @override
  set medicalPackage(PackageModel value) {
    _$medicalPackageAtom.reportWrite(value, super.medicalPackage, () {
      super.medicalPackage = value;
    });
  }

  late final _$newsItemAtom =
      Atom(name: 'UserAppStoreBase.newsItem', context: context);

  @override
  NewsPagingItem get newsItem {
    _$newsItemAtom.reportRead();
    return super.newsItem;
  }

  @override
  set newsItem(NewsPagingItem value) {
    _$newsItemAtom.reportWrite(value, super.newsItem, () {
      super.newsItem = value;
    });
  }

  late final _$reloadAtom =
      Atom(name: 'UserAppStoreBase.reload', context: context);

  @override
  bool get reload {
    _$reloadAtom.reportRead();
    return super.reload;
  }

  @override
  set reload(bool value) {
    _$reloadAtom.reportWrite(value, super.reload, () {
      super.reload = value;
    });
  }

  late final _$initAsyncAction =
      AsyncAction('UserAppStoreBase.init', context: context);

  @override
  Future<void> init() {
    return _$initAsyncAction.run(() => super.init());
  }

  late final _$updateUserInfoAsyncAction =
      AsyncAction('UserAppStoreBase.updateUserInfo', context: context);

  @override
  Future<void> updateUserInfo(User.UserInfoModel? data) {
    return _$updateUserInfoAsyncAction.run(() => super.updateUserInfo(data));
  }

  late final _$getAccountDetailAsyncAction =
      AsyncAction('UserAppStoreBase.getAccountDetail', context: context);

  @override
  Future<void> getAccountDetail() {
    return _$getAccountDetailAsyncAction.run(() => super.getAccountDetail());
  }

  late final _$checkStatusNursingAsyncAction =
      AsyncAction('UserAppStoreBase.checkStatusNursing', context: context);

  @override
  Future<void> checkStatusNursing(
      {required String code, required String password}) {
    return _$checkStatusNursingAsyncAction
        .run(() => super.checkStatusNursing(code: code, password: password));
  }

  late final _$disconnectHISAsyncAction =
      AsyncAction('UserAppStoreBase.disconnectHIS', context: context);

  @override
  Future<void> disconnectHIS() {
    return _$disconnectHISAsyncAction.run(() => super.disconnectHIS());
  }

  late final _$logOutAsyncAction =
      AsyncAction('UserAppStoreBase.logOut', context: context);

  @override
  Future<void> logOut() {
    return _$logOutAsyncAction.run(() => super.logOut());
  }

  late final _$deleteAccountAsyncAction =
      AsyncAction('UserAppStoreBase.deleteAccount', context: context);

  @override
  Future<void> deleteAccount() {
    return _$deleteAccountAsyncAction.run(() => super.deleteAccount());
  }

  late final _$UserAppStoreBaseActionController =
      ActionController(name: 'UserAppStoreBase', context: context);

  @override
  void changeBuildContext(BuildContext newContext) {
    final _$actionInfo = _$UserAppStoreBaseActionController.startAction(
        name: 'UserAppStoreBase.changeBuildContext');
    try {
      return super.changeBuildContext(newContext);
    } finally {
      _$UserAppStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setReload(bool newReload) {
    final _$actionInfo = _$UserAppStoreBaseActionController.startAction(
        name: 'UserAppStoreBase.setReload');
    try {
      return super.setReload(newReload);
    } finally {
      _$UserAppStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setVisibleSelectDoctor(bool val) {
    final _$actionInfo = _$UserAppStoreBaseActionController.startAction(
        name: 'UserAppStoreBase.setVisibleSelectDoctor');
    try {
      return super.setVisibleSelectDoctor(val);
    } finally {
      _$UserAppStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
user: ${user},
loadingUserData: ${loadingUserData},
visibleSelectDoctor: ${visibleSelectDoctor},
progress: ${progress},
isCodeNursing: ${isCodeNursing},
codeNursing: ${codeNursing},
isConnectedHis: ${isConnectedHis},
doctor: ${doctor},
hospital: ${hospital},
item: ${item},
medicalPackage: ${medicalPackage},
newsItem: ${newsItem},
reload: ${reload},
getUserName: ${getUserName},
getUserProvince: ${getUserProvince},
getUserDistrict: ${getUserDistrict},
getUserAddress: ${getUserAddress},
getUserPhone: ${getUserPhone},
getUserDob: ${getUserDob},
getUserEmail: ${getUserEmail},
getUserGender: ${getUserGender}
    ''';
  }
}
