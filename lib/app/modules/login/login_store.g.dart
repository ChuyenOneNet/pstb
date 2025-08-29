// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginStore on LoginStoreBase, Store {
  late final _$loadingLoginAtom =
      Atom(name: 'LoginStoreBase.loadingLogin', context: context);

  @override
  bool get loadingLogin {
    _$loadingLoginAtom.reportRead();
    return super.loadingLogin;
  }

  @override
  set loadingLogin(bool value) {
    _$loadingLoginAtom.reportWrite(value, super.loadingLogin, () {
      super.loadingLogin = value;
    });
  }

  late final _$phoneNumberCacheAtom =
      Atom(name: 'LoginStoreBase.phoneNumberCache', context: context);

  @override
  String get phoneNumberCache {
    _$phoneNumberCacheAtom.reportRead();
    return super.phoneNumberCache;
  }

  @override
  set phoneNumberCache(String value) {
    _$phoneNumberCacheAtom.reportWrite(value, super.phoneNumberCache, () {
      super.phoneNumberCache = value;
    });
  }

  late final _$phoneNumberAtom =
      Atom(name: 'LoginStoreBase.phoneNumber', context: context);

  @override
  String get phoneNumber {
    _$phoneNumberAtom.reportRead();
    return super.phoneNumber;
  }

  @override
  set phoneNumber(String value) {
    _$phoneNumberAtom.reportWrite(value, super.phoneNumber, () {
      super.phoneNumber = value;
    });
  }

  late final _$passwordAtom =
      Atom(name: 'LoginStoreBase.password', context: context);

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

  late final _$getInformationNumberAsyncAction =
      AsyncAction('LoginStoreBase.getInformationNumber', context: context);

  @override
  Future<dynamic> getInformationNumber() {
    return _$getInformationNumberAsyncAction
        .run(() => super.getInformationNumber());
  }

  late final _$biometricAuthAsyncAction =
      AsyncAction('LoginStoreBase.biometricAuth', context: context);

  @override
  Future<void> biometricAuth(BuildContext context) {
    return _$biometricAuthAsyncAction.run(() => super.biometricAuth(context));
  }

  late final _$checkLoginAsyncAction =
      AsyncAction('LoginStoreBase.checkLogin', context: context);

  @override
  Future<void> checkLogin() {
    return _$checkLoginAsyncAction.run(() => super.checkLogin());
  }

  late final _$clearCacheAsyncAction =
      AsyncAction('LoginStoreBase.clearCache', context: context);

  @override
  Future<void> clearCache() {
    return _$clearCacheAsyncAction.run(() => super.clearCache());
  }

  late final _$loginFacebookAsyncAction =
      AsyncAction('LoginStoreBase.loginFacebook', context: context);

  @override
  Future<void> loginFacebook() {
    return _$loginFacebookAsyncAction.run(() => super.loginFacebook());
  }

  late final _$loginAppleAsyncAction =
      AsyncAction('LoginStoreBase.loginApple', context: context);

  @override
  Future<void> loginApple() {
    return _$loginAppleAsyncAction.run(() => super.loginApple());
  }

  late final _$onLoginAsyncAction =
      AsyncAction('LoginStoreBase.onLogin', context: context);

  @override
  Future<void> onLogin() {
    return _$onLoginAsyncAction.run(() => super.onLogin());
  }

  late final _$LoginStoreBaseActionController =
      ActionController(name: 'LoginStoreBase', context: context);

  @override
  void onPhoneNumberCache(String text) {
    final _$actionInfo = _$LoginStoreBaseActionController.startAction(
        name: 'LoginStoreBase.onPhoneNumberCache');
    try {
      return super.onPhoneNumberCache(text);
    } finally {
      _$LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onChangePhoneNumber(String text) {
    final _$actionInfo = _$LoginStoreBaseActionController.startAction(
        name: 'LoginStoreBase.onChangePhoneNumber');
    try {
      return super.onChangePhoneNumber(text);
    } finally {
      _$LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onChangePassword(String text) {
    final _$actionInfo = _$LoginStoreBaseActionController.startAction(
        name: 'LoginStoreBase.onChangePassword');
    try {
      return super.onChangePassword(text);
    } finally {
      _$LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeBuildContext(BuildContext newContext) {
    final _$actionInfo = _$LoginStoreBaseActionController.startAction(
        name: 'LoginStoreBase.changeBuildContext');
    try {
      return super.changeBuildContext(newContext);
    } finally {
      _$LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loadingLogin: ${loadingLogin},
phoneNumberCache: ${phoneNumberCache},
phoneNumber: ${phoneNumber},
password: ${password}
    ''';
  }
}
