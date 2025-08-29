// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_password_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ChangePasswordStore on ChangePasswordStoreBase, Store {
  Computed<String?>? _$validateOldPasswordComputed;

  @override
  String? get validateOldPassword => (_$validateOldPasswordComputed ??=
          Computed<String?>(() => super.validateOldPassword,
              name: 'ChangePasswordStoreBase.validateOldPassword'))
      .value;
  Computed<String?>? _$validateNewPasswordComputed;

  @override
  String? get validateNewPassword => (_$validateNewPasswordComputed ??=
          Computed<String?>(() => super.validateNewPassword,
              name: 'ChangePasswordStoreBase.validateNewPassword'))
      .value;
  Computed<String?>? _$validateConfirmPassComputed;

  @override
  String? get validateConfirmPass => (_$validateConfirmPassComputed ??=
          Computed<String?>(() => super.validateConfirmPass,
              name: 'ChangePasswordStoreBase.validateConfirmPass'))
      .value;

  late final _$oldPassAtom =
      Atom(name: 'ChangePasswordStoreBase.oldPass', context: context);

  @override
  String get oldPass {
    _$oldPassAtom.reportRead();
    return super.oldPass;
  }

  @override
  set oldPass(String value) {
    _$oldPassAtom.reportWrite(value, super.oldPass, () {
      super.oldPass = value;
    });
  }

  late final _$oldPassMsgResponseAtom = Atom(
      name: 'ChangePasswordStoreBase.oldPassMsgResponse', context: context);

  @override
  String? get oldPassMsgResponse {
    _$oldPassMsgResponseAtom.reportRead();
    return super.oldPassMsgResponse;
  }

  @override
  set oldPassMsgResponse(String? value) {
    _$oldPassMsgResponseAtom.reportWrite(value, super.oldPassMsgResponse, () {
      super.oldPassMsgResponse = value;
    });
  }

  late final _$newPassAtom =
      Atom(name: 'ChangePasswordStoreBase.newPass', context: context);

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
      Atom(name: 'ChangePasswordStoreBase.confirmPass', context: context);

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

  late final _$putChangePasswordAsyncAction = AsyncAction(
      'ChangePasswordStoreBase.putChangePassword',
      context: context);

  @override
  Future<void> putChangePassword() {
    return _$putChangePasswordAsyncAction.run(() => super.putChangePassword());
  }

  late final _$onCheckOtpAsyncAction =
      AsyncAction('ChangePasswordStoreBase.onCheckOtp', context: context);

  @override
  Future<void> onCheckOtp(String secretKey, String otp) {
    return _$onCheckOtpAsyncAction.run(() => super.onCheckOtp(secretKey, otp));
  }

  late final _$ChangePasswordStoreBaseActionController =
      ActionController(name: 'ChangePasswordStoreBase', context: context);

  @override
  void changeOldPass(String data) {
    final _$actionInfo = _$ChangePasswordStoreBaseActionController.startAction(
        name: 'ChangePasswordStoreBase.changeOldPass');
    try {
      return super.changeOldPass(data);
    } finally {
      _$ChangePasswordStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeNewPass(String data) {
    final _$actionInfo = _$ChangePasswordStoreBaseActionController.startAction(
        name: 'ChangePasswordStoreBase.changeNewPass');
    try {
      return super.changeNewPass(data);
    } finally {
      _$ChangePasswordStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeConfirmPass(String data) {
    final _$actionInfo = _$ChangePasswordStoreBaseActionController.startAction(
        name: 'ChangePasswordStoreBase.changeConfirmPass');
    try {
      return super.changeConfirmPass(data);
    } finally {
      _$ChangePasswordStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _changeOldPassMsgResponse(String? msg) {
    final _$actionInfo = _$ChangePasswordStoreBaseActionController.startAction(
        name: 'ChangePasswordStoreBase._changeOldPassMsgResponse');
    try {
      return super._changeOldPassMsgResponse(msg);
    } finally {
      _$ChangePasswordStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeBuildContext(BuildContext newContext) {
    final _$actionInfo = _$ChangePasswordStoreBaseActionController.startAction(
        name: 'ChangePasswordStoreBase.changeBuildContext');
    try {
      return super.changeBuildContext(newContext);
    } finally {
      _$ChangePasswordStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
oldPass: ${oldPass},
oldPassMsgResponse: ${oldPassMsgResponse},
newPass: ${newPass},
confirmPass: ${confirmPass},
validateOldPassword: ${validateOldPassword},
validateNewPassword: ${validateNewPassword},
validateConfirmPass: ${validateConfirmPass}
    ''';
  }
}
