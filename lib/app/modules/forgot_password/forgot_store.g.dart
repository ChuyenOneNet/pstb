// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ForgotStore on ForgotStoreBase, Store {
  Computed<String?>? _$validatePhoneNumberComputed;

  @override
  String? get validatePhoneNumber => (_$validatePhoneNumberComputed ??=
          Computed<String?>(() => super.validatePhoneNumber,
              name: 'ForgotStoreBase.validatePhoneNumber'))
      .value;
  Computed<String?>? _$validatePasswordComputed;

  @override
  String? get validatePassword => (_$validatePasswordComputed ??=
          Computed<String?>(() => super.validatePassword,
              name: 'ForgotStoreBase.validatePassword'))
      .value;
  Computed<String?>? _$validateConfirmPassComputed;

  @override
  String? get validateConfirmPass => (_$validateConfirmPassComputed ??=
          Computed<String?>(() => super.validateConfirmPass,
              name: 'ForgotStoreBase.validateConfirmPass'))
      .value;

  late final _$phoneNumberAtom =
      Atom(name: 'ForgotStoreBase.phoneNumber', context: context);

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

  late final _$newPassAtom =
      Atom(name: 'ForgotStoreBase.newPass', context: context);

  @override
  String get newPass {
    _$newPassAtom.reportRead();
    return super.newPass;
  }

  @override
  set newPass(String value) {
    _$newPassAtom.reportWrite(value, super.newPass, () {
      super.newPass = value;
    });
  }

  late final _$confirmPassAtom =
      Atom(name: 'ForgotStoreBase.confirmPass', context: context);

  @override
  String get confirmPass {
    _$confirmPassAtom.reportRead();
    return super.confirmPass;
  }

  @override
  set confirmPass(String value) {
    _$confirmPassAtom.reportWrite(value, super.confirmPass, () {
      super.confirmPass = value;
    });
  }

  late final _$postResetPasswordAsyncAction =
      AsyncAction('ForgotStoreBase.postResetPassword', context: context);

  @override
  Future<void> postResetPassword() {
    return _$postResetPasswordAsyncAction.run(() => super.postResetPassword());
  }

  late final _$ForgotStoreBaseActionController =
      ActionController(name: 'ForgotStoreBase', context: context);

  @override
  void changePhoneNumber(String value) {
    final _$actionInfo = _$ForgotStoreBaseActionController.startAction(
        name: 'ForgotStoreBase.changePhoneNumber');
    try {
      return super.changePhoneNumber(value);
    } finally {
      _$ForgotStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeNewPass(String value) {
    final _$actionInfo = _$ForgotStoreBaseActionController.startAction(
        name: 'ForgotStoreBase.changeNewPass');
    try {
      return super.changeNewPass(value);
    } finally {
      _$ForgotStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeConfirmPass(String value) {
    final _$actionInfo = _$ForgotStoreBaseActionController.startAction(
        name: 'ForgotStoreBase.changeConfirmPass');
    try {
      return super.changeConfirmPass(value);
    } finally {
      _$ForgotStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeBuildContext(BuildContext context) {
    final _$actionInfo = _$ForgotStoreBaseActionController.startAction(
        name: 'ForgotStoreBase.changeBuildContext');
    try {
      return super.changeBuildContext(context);
    } finally {
      _$ForgotStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
phoneNumber: ${phoneNumber},
newPass: ${newPass},
confirmPass: ${confirmPass},
validatePhoneNumber: ${validatePhoneNumber},
validatePassword: ${validatePassword},
validateConfirmPass: ${validateConfirmPass}
    ''';
  }
}
