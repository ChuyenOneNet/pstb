// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bottom_nav_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BottomNavStore on _BottomNavStoreBase, Store {
  late final _$currentIndexAtom =
      Atom(name: '_BottomNavStoreBase.currentIndex', context: context);

  @override
  int get currentIndex {
    _$currentIndexAtom.reportRead();
    return super.currentIndex;
  }

  @override
  set currentIndex(int value) {
    _$currentIndexAtom.reportWrite(value, super.currentIndex, () {
      super.currentIndex = value;
    });
  }

  late final _$isMainPageAtom =
      Atom(name: '_BottomNavStoreBase.isMainPage', context: context);

  @override
  bool get isMainPage {
    _$isMainPageAtom.reportRead();
    return super.isMainPage;
  }

  @override
  set isMainPage(bool value) {
    _$isMainPageAtom.reportWrite(value, super.isMainPage, () {
      super.isMainPage = value;
    });
  }

  late final _$isLoginAtom =
      Atom(name: '_BottomNavStoreBase.isLogin', context: context);

  @override
  bool get isLogin {
    _$isLoginAtom.reportRead();
    return super.isLogin;
  }

  @override
  set isLogin(bool value) {
    _$isLoginAtom.reportWrite(value, super.isLogin, () {
      super.isLogin = value;
    });
  }

  late final _$checkLoginAsyncAction =
      AsyncAction('_BottomNavStoreBase.checkLogin', context: context);

  @override
  Future<void> checkLogin() {
    return _$checkLoginAsyncAction.run(() => super.checkLogin());
  }

  late final _$_BottomNavStoreBaseActionController =
      ActionController(name: '_BottomNavStoreBase', context: context);

  @override
  void updateCurrentIndex(int index) {
    final _$actionInfo = _$_BottomNavStoreBaseActionController.startAction(
        name: '_BottomNavStoreBase.updateCurrentIndex');
    try {
      return super.updateCurrentIndex(index);
    } finally {
      _$_BottomNavStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateCheckMainPage(bool value) {
    final _$actionInfo = _$_BottomNavStoreBaseActionController.startAction(
        name: '_BottomNavStoreBase.updateCheckMainPage');
    try {
      return super.updateCheckMainPage(value);
    } finally {
      _$_BottomNavStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentIndex: ${currentIndex},
isMainPage: ${isMainPage},
isLogin: ${isLogin}
    ''';
  }
}
