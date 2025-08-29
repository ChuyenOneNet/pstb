// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SettingStore on _SettingStoreBase, Store {
  late final _$passwordAtom =
      Atom(name: '_SettingStoreBase.password', context: context);

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  late final _$isActiveFingerAtom =
      Atom(name: '_SettingStoreBase.isActiveFinger', context: context);

  @override
  bool get isActiveFinger {
    _$isActiveFingerAtom.reportRead();
    return super.isActiveFinger;
  }

  @override
  set isActiveFinger(bool value) {
    _$isActiveFingerAtom.reportWrite(value, super.isActiveFinger, () {
      super.isActiveFinger = value;
    });
  }

  late final _$isLoginSuccessAtom =
      Atom(name: '_SettingStoreBase.isLoginSuccess', context: context);

  @override
  bool get isLoginSuccess {
    _$isLoginSuccessAtom.reportRead();
    return super.isLoginSuccess;
  }

  @override
  set isLoginSuccess(bool value) {
    _$isLoginSuccessAtom.reportWrite(value, super.isLoginSuccess, () {
      super.isLoginSuccess = value;
    });
  }

  late final _$notAvailableBiometricAtom =
      Atom(name: '_SettingStoreBase.notAvailableBiometric', context: context);

  @override
  bool get notAvailableBiometric {
    _$notAvailableBiometricAtom.reportRead();
    return super.notAvailableBiometric;
  }

  @override
  set notAvailableBiometric(bool value) {
    _$notAvailableBiometricAtom.reportWrite(value, super.notAvailableBiometric,
        () {
      super.notAvailableBiometric = value;
    });
  }

  late final _$isNotificationAtom =
      Atom(name: '_SettingStoreBase.isNotification', context: context);

  @override
  bool get isNotification {
    _$isNotificationAtom.reportRead();
    return super.isNotification;
  }

  @override
  set isNotification(bool value) {
    _$isNotificationAtom.reportWrite(value, super.isNotification, () {
      super.isNotification = value;
    });
  }

  late final _$isShowAlertNotificationAtom =
      Atom(name: '_SettingStoreBase.isShowAlertNotification', context: context);

  @override
  bool get isShowAlertNotification {
    _$isShowAlertNotificationAtom.reportRead();
    return super.isShowAlertNotification;
  }

  @override
  set isShowAlertNotification(bool value) {
    _$isShowAlertNotificationAtom
        .reportWrite(value, super.isShowAlertNotification, () {
      super.isShowAlertNotification = value;
    });
  }

  late final _$permissionsAtom =
      Atom(name: '_SettingStoreBase.permissions', context: context);

  @override
  PermissionStatus get permissions {
    _$permissionsAtom.reportRead();
    return super.permissions;
  }

  @override
  set permissions(PermissionStatus value) {
    _$permissionsAtom.reportWrite(value, super.permissions, () {
      super.permissions = value;
    });
  }

  late final _$initStateAsyncAction =
      AsyncAction('_SettingStoreBase.initState', context: context);

  @override
  Future<void> initState() {
    return _$initStateAsyncAction.run(() => super.initState());
  }

  late final _$actionSwitchAsyncAction =
      AsyncAction('_SettingStoreBase.actionSwitch', context: context);

  @override
  Future<void> actionSwitch(dynamic value) {
    return _$actionSwitchAsyncAction.run(() => super.actionSwitch(value));
  }

  late final _$activeFingerPrintAsyncAction =
      AsyncAction('_SettingStoreBase.activeFingerPrint', context: context);

  @override
  Future<void> activeFingerPrint() {
    return _$activeFingerPrintAsyncAction.run(() => super.activeFingerPrint());
  }

  late final _$activeNotificationAsyncAction =
      AsyncAction('_SettingStoreBase.activeNotification', context: context);

  @override
  Future<void> activeNotification() {
    return _$activeNotificationAsyncAction
        .run(() => super.activeNotification());
  }

  late final _$changeStateSettingAsyncAction =
      AsyncAction('_SettingStoreBase.changeStateSetting', context: context);

  @override
  Future<void> changeStateSetting() {
    return _$changeStateSettingAsyncAction
        .run(() => super.changeStateSetting());
  }

  late final _$requestNotificationAsyncAction =
      AsyncAction('_SettingStoreBase.requestNotification', context: context);

  @override
  Future<void> requestNotification() {
    return _$requestNotificationAsyncAction
        .run(() => super.requestNotification());
  }

  late final _$authenticateWithBiometricsAsyncAction = AsyncAction(
      '_SettingStoreBase.authenticateWithBiometrics',
      context: context);

  @override
  Future<void> authenticateWithBiometrics(String message,
      {AndroidAuthMessages androidAuthMessages = const AndroidAuthMessages()}) {
    return _$authenticateWithBiometricsAsyncAction.run(() => super
        .authenticateWithBiometrics(message,
            androidAuthMessages: androidAuthMessages));
  }

  late final _$_SettingStoreBaseActionController =
      ActionController(name: '_SettingStoreBase', context: context);

  @override
  void setPassword(String value) {
    final _$actionInfo = _$_SettingStoreBaseActionController.startAction(
        name: '_SettingStoreBase.setPassword');
    try {
      return super.setPassword(value);
    } finally {
      _$_SettingStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
password: ${password},
isActiveFinger: ${isActiveFinger},
isLoginSuccess: ${isLoginSuccess},
notAvailableBiometric: ${notAvailableBiometric},
isNotification: ${isNotification},
isShowAlertNotification: ${isShowAlertNotification},
permissions: ${permissions}
    ''';
  }
}
