// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProfileStore on _ProfileStoreBase, Store {
  Computed<List<Insurance.Data>?>? _$insuranceDataComputed;

  @override
  List<Insurance.Data>? get insuranceData => (_$insuranceDataComputed ??=
          Computed<List<Insurance.Data>?>(() => super.insuranceData,
              name: '_ProfileStoreBase.insuranceData'))
      .value;

  late final _$isLoginAtom =
      Atom(name: '_ProfileStoreBase.isLogin', context: context);

  @override
  UserStatus get isLogin {
    _$isLoginAtom.reportRead();
    return super.isLogin;
  }

  @override
  set isLogin(UserStatus value) {
    _$isLoginAtom.reportWrite(value, super.isLogin, () {
      super.isLogin = value;
    });
  }

  late final _$avatarAtom =
      Atom(name: '_ProfileStoreBase.avatar', context: context);

  @override
  String? get avatar {
    _$avatarAtom.reportRead();
    return super.avatar;
  }

  @override
  set avatar(String? value) {
    _$avatarAtom.reportWrite(value, super.avatar, () {
      super.avatar = value;
    });
  }

  late final _$localAvatarPathAtom =
      Atom(name: '_ProfileStoreBase.localAvatarPath', context: context);

  @override
  String? get localAvatarPath {
    _$localAvatarPathAtom.reportRead();
    return super.localAvatarPath;
  }

  @override
  set localAvatarPath(String? value) {
    _$localAvatarPathAtom.reportWrite(value, super.localAvatarPath, () {
      super.localAvatarPath = value;
    });
  }

  late final _$isDataQrCodeAtom =
      Atom(name: '_ProfileStoreBase.isDataQrCode', context: context);

  @override
  String get isDataQrCode {
    _$isDataQrCodeAtom.reportRead();
    return super.isDataQrCode;
  }

  @override
  set isDataQrCode(String value) {
    _$isDataQrCodeAtom.reportWrite(value, super.isDataQrCode, () {
      super.isDataQrCode = value;
    });
  }

  late final _$isGenerateQRCodeAtom =
      Atom(name: '_ProfileStoreBase.isGenerateQRCode', context: context);

  @override
  bool get isGenerateQRCode {
    _$isGenerateQRCodeAtom.reportRead();
    return super.isGenerateQRCode;
  }

  @override
  set isGenerateQRCode(bool value) {
    _$isGenerateQRCodeAtom.reportWrite(value, super.isGenerateQRCode, () {
      super.isGenerateQRCode = value;
    });
  }

  late final _$loadingInsuranceAtom =
      Atom(name: '_ProfileStoreBase.loadingInsurance', context: context);

  @override
  bool get loadingInsurance {
    _$loadingInsuranceAtom.reportRead();
    return super.loadingInsurance;
  }

  @override
  set loadingInsurance(bool value) {
    _$loadingInsuranceAtom.reportWrite(value, super.loadingInsurance, () {
      super.loadingInsurance = value;
    });
  }

  late final _$insuranceAtom =
      Atom(name: '_ProfileStoreBase.insurance', context: context);

  @override
  Insurance.InsuranceModel get insurance {
    _$insuranceAtom.reportRead();
    return super.insurance;
  }

  @override
  set insurance(Insurance.InsuranceModel value) {
    _$insuranceAtom.reportWrite(value, super.insurance, () {
      super.insurance = value;
    });
  }

  late final _$insuranceSelectedAtom =
      Atom(name: '_ProfileStoreBase.insuranceSelected', context: context);

  @override
  Insurance.Data? get insuranceSelected {
    _$insuranceSelectedAtom.reportRead();
    return super.insuranceSelected;
  }

  @override
  set insuranceSelected(Insurance.Data? value) {
    _$insuranceSelectedAtom.reportWrite(value, super.insuranceSelected, () {
      super.insuranceSelected = value;
    });
  }

  late final _$rateAppAsyncAction =
      AsyncAction('_ProfileStoreBase.rateApp', context: context);

  @override
  Future<void> rateApp() {
    return _$rateAppAsyncAction.run(() => super.rateApp());
  }

  late final _$getInsuranceAsyncAction =
      AsyncAction('_ProfileStoreBase.getInsurance', context: context);

  @override
  Future<void> getInsurance() {
    return _$getInsuranceAsyncAction.run(() => super.getInsurance());
  }

  late final _$onChangeAvatarAsyncAction =
      AsyncAction('_ProfileStoreBase.onChangeAvatar', context: context);

  @override
  Future<dynamic> onChangeAvatar(XFile file) {
    return _$onChangeAvatarAsyncAction.run(() => super.onChangeAvatar(file));
  }

  late final _$_ProfileStoreBaseActionController =
      ActionController(name: '_ProfileStoreBase', context: context);

  @override
  void onChangeBuildContext(BuildContext buildContext) {
    final _$actionInfo = _$_ProfileStoreBaseActionController.startAction(
        name: '_ProfileStoreBase.onChangeBuildContext');
    try {
      return super.onChangeBuildContext(buildContext);
    } finally {
      _$_ProfileStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsLogin(UserStatus loginStatus) {
    final _$actionInfo = _$_ProfileStoreBaseActionController.startAction(
        name: '_ProfileStoreBase.setIsLogin');
    try {
      return super.setIsLogin(loginStatus);
    } finally {
      _$_ProfileStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLocalAvatarPath(String? path) {
    final _$actionInfo = _$_ProfileStoreBaseActionController.startAction(
        name: '_ProfileStoreBase.setLocalAvatarPath');
    try {
      return super.setLocalAvatarPath(path);
    } finally {
      _$_ProfileStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedInsurance(Insurance.Data? value) {
    final _$actionInfo = _$_ProfileStoreBaseActionController.startAction(
        name: '_ProfileStoreBase.setSelectedInsurance');
    try {
      return super.setSelectedInsurance(value);
    } finally {
      _$_ProfileStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onPushQRCode() {
    final _$actionInfo = _$_ProfileStoreBaseActionController.startAction(
        name: '_ProfileStoreBase.onPushQRCode');
    try {
      return super.onPushQRCode();
    } finally {
      _$_ProfileStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLogin: ${isLogin},
avatar: ${avatar},
localAvatarPath: ${localAvatarPath},
isDataQrCode: ${isDataQrCode},
isGenerateQRCode: ${isGenerateQRCode},
loadingInsurance: ${loadingInsurance},
insurance: ${insurance},
insuranceSelected: ${insuranceSelected},
insuranceData: ${insuranceData}
    ''';
  }
}
