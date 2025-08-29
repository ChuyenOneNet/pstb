// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'include_phone_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$IncludePhoneStore on IncludePhoneStoreBase, Store {
  Computed<String?>? _$validatePhoneNumberComputed;

  @override
  String? get validatePhoneNumber => (_$validatePhoneNumberComputed ??=
          Computed<String?>(() => super.validatePhoneNumber,
              name: 'IncludePhoneStoreBase.validatePhoneNumber'))
      .value;

  late final _$phoneNumberAtom =
      Atom(name: 'IncludePhoneStoreBase.phoneNumber', context: context);

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

  late final _$routeNameAtom =
      Atom(name: 'IncludePhoneStoreBase.routeName', context: context);

  @override
  String get routeName {
    _$routeNameAtom.reportRead();
    return super.routeName;
  }

  @override
  set routeName(String value) {
    _$routeNameAtom.reportWrite(value, super.routeName, () {
      super.routeName = value;
    });
  }

  late final _$phoneValidResponseAtom =
      Atom(name: 'IncludePhoneStoreBase.phoneValidResponse', context: context);

  @override
  String? get phoneValidResponse {
    _$phoneValidResponseAtom.reportRead();
    return super.phoneValidResponse;
  }

  @override
  set phoneValidResponse(String? value) {
    _$phoneValidResponseAtom.reportWrite(value, super.phoneValidResponse, () {
      super.phoneValidResponse = value;
    });
  }

  late final _$onCheckUniqueAsyncAction =
      AsyncAction('IncludePhoneStoreBase.onCheckUnique', context: context);

  @override
  Future<void> onCheckUnique() {
    return _$onCheckUniqueAsyncAction.run(() => super.onCheckUnique());
  }

  late final _$IncludePhoneStoreBaseActionController =
      ActionController(name: 'IncludePhoneStoreBase', context: context);

  @override
  void changePhoneNumber(String data) {
    final _$actionInfo = _$IncludePhoneStoreBaseActionController.startAction(
        name: 'IncludePhoneStoreBase.changePhoneNumber');
    try {
      return super.changePhoneNumber(data);
    } finally {
      _$IncludePhoneStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _changePhoneValidResponse(String? msg) {
    final _$actionInfo = _$IncludePhoneStoreBaseActionController.startAction(
        name: 'IncludePhoneStoreBase._changePhoneValidResponse');
    try {
      return super._changePhoneValidResponse(msg);
    } finally {
      _$IncludePhoneStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeRouteName(String value) {
    final _$actionInfo = _$IncludePhoneStoreBaseActionController.startAction(
        name: 'IncludePhoneStoreBase.changeRouteName');
    try {
      return super.changeRouteName(value);
    } finally {
      _$IncludePhoneStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeBuildContext(BuildContext newContext) {
    final _$actionInfo = _$IncludePhoneStoreBaseActionController.startAction(
        name: 'IncludePhoneStoreBase.changeBuildContext');
    try {
      return super.changeBuildContext(newContext);
    } finally {
      _$IncludePhoneStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
phoneNumber: ${phoneNumber},
routeName: ${routeName},
phoneValidResponse: ${phoneValidResponse},
validatePhoneNumber: ${validatePhoneNumber}
    ''';
  }
}
