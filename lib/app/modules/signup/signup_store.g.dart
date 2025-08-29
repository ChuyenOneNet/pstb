// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SignupStore on SignupStoreBase, Store {
  Computed<bool>? _$isFemaleComputed;

  @override
  bool get isFemale =>
      (_$isFemaleComputed ??= Computed<bool>(() => super.isFemale,
              name: 'SignupStoreBase.isFemale'))
          .value;
  Computed<bool>? _$isMaleComputed;

  @override
  bool get isMale => (_$isMaleComputed ??=
          Computed<bool>(() => super.isMale, name: 'SignupStoreBase.isMale'))
      .value;
  Computed<bool>? _$hadBirthdayComputed;

  @override
  bool get hadBirthday =>
      (_$hadBirthdayComputed ??= Computed<bool>(() => super.hadBirthday,
              name: 'SignupStoreBase.hadBirthday'))
          .value;
  Computed<String?>? _$validateFullNameComputed;

  @override
  String? get validateFullName => (_$validateFullNameComputed ??=
          Computed<String?>(() => super.validateFullName,
              name: 'SignupStoreBase.validateFullName'))
      .value;
  Computed<String?>? _$validateBirthdayComputed;

  @override
  String? get validateBirthday => (_$validateBirthdayComputed ??=
          Computed<String?>(() => super.validateBirthday,
              name: 'SignupStoreBase.validateBirthday'))
      .value;
  Computed<String?>? _$validateEmailComputed;

  @override
  String? get validateEmail =>
      (_$validateEmailComputed ??= Computed<String?>(() => super.validateEmail,
              name: 'SignupStoreBase.validateEmail'))
          .value;
  Computed<String>? _$getGenderComputed;

  @override
  String get getGender =>
      (_$getGenderComputed ??= Computed<String>(() => super.getGender,
              name: 'SignupStoreBase.getGender'))
          .value;
  Computed<String?>? _$validatePhoneNumberComputed;

  @override
  String? get validatePhoneNumber => (_$validatePhoneNumberComputed ??=
          Computed<String?>(() => super.validatePhoneNumber,
              name: 'SignupStoreBase.validatePhoneNumber'))
      .value;
  Computed<String?>? _$validatePasswordComputed;

  @override
  String? get validatePassword => (_$validatePasswordComputed ??=
          Computed<String?>(() => super.validatePassword,
              name: 'SignupStoreBase.validatePassword'))
      .value;
  Computed<String?>? _$validateConfirmPassComputed;

  @override
  String? get validateConfirmPass => (_$validateConfirmPassComputed ??=
          Computed<String?>(() => super.validateConfirmPass,
              name: 'SignupStoreBase.validateConfirmPass'))
      .value;

  late final _$fullNameAtom =
      Atom(name: 'SignupStoreBase.fullName', context: context);

  @override
  String get fullName {
    _$fullNameAtom.reportRead();
    return super.fullName;
  }

  @override
  set fullName(String value) {
    _$fullNameAtom.reportWrite(value, super.fullName, () {
      super.fullName = value;
    });
  }

  late final _$birthdayAtom =
      Atom(name: 'SignupStoreBase.birthday', context: context);

  @override
  String get birthday {
    _$birthdayAtom.reportRead();
    return super.birthday;
  }

  @override
  set birthday(String value) {
    _$birthdayAtom.reportWrite(value, super.birthday, () {
      super.birthday = value;
    });
  }

  late final _$emailAtom =
      Atom(name: 'SignupStoreBase.email', context: context);

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  late final _$genderAtom =
      Atom(name: 'SignupStoreBase.gender', context: context);

  @override
  Gender get gender {
    _$genderAtom.reportRead();
    return super.gender;
  }

  @override
  set gender(Gender value) {
    _$genderAtom.reportWrite(value, super.gender, () {
      super.gender = value;
    });
  }

  late final _$phoneNumberAtom =
      Atom(name: 'SignupStoreBase.phoneNumber', context: context);

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
      Atom(name: 'SignupStoreBase.password', context: context);

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

  late final _$confirmPassAtom =
      Atom(name: 'SignupStoreBase.confirmPass', context: context);

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

  late final _$phoneValidResponseAtom =
      Atom(name: 'SignupStoreBase.phoneValidResponse', context: context);

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
      AsyncAction('SignupStoreBase.onCheckUnique', context: context);

  @override
  Future<void> onCheckUnique() {
    return _$onCheckUniqueAsyncAction.run(() => super.onCheckUnique());
  }

  late final _$onRegisterAsyncAction =
      AsyncAction('SignupStoreBase.onRegister', context: context);

  @override
  Future<void> onRegister() {
    return _$onRegisterAsyncAction.run(() => super.onRegister());
  }

  late final _$onRegisterV2AsyncAction =
      AsyncAction('SignupStoreBase.onRegisterV2', context: context);

  @override
  Future<void> onRegisterV2() {
    return _$onRegisterV2AsyncAction.run(() => super.onRegisterV2());
  }

  late final _$onCheckOtpAsyncAction =
      AsyncAction('SignupStoreBase.onCheckOtp', context: context);

  @override
  Future<void> onCheckOtp(String secretKey, String otp) {
    return _$onCheckOtpAsyncAction.run(() => super.onCheckOtp(secretKey, otp));
  }

  late final _$onLoginAsyncAction =
      AsyncAction('SignupStoreBase.onLogin', context: context);

  @override
  Future<void> onLogin() {
    return _$onLoginAsyncAction.run(() => super.onLogin());
  }

  late final _$onAddInfoAsyncAction =
      AsyncAction('SignupStoreBase.onAddInfo', context: context);

  @override
  Future<void> onAddInfo() {
    return _$onAddInfoAsyncAction.run(() => super.onAddInfo());
  }

  late final _$SignupStoreBaseActionController =
      ActionController(name: 'SignupStoreBase', context: context);

  @override
  void onChangeFullName(String text) {
    final _$actionInfo = _$SignupStoreBaseActionController.startAction(
        name: 'SignupStoreBase.onChangeFullName');
    try {
      return super.onChangeFullName(text);
    } finally {
      _$SignupStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onChangeBirthday(String text) {
    final _$actionInfo = _$SignupStoreBaseActionController.startAction(
        name: 'SignupStoreBase.onChangeBirthday');
    try {
      return super.onChangeBirthday(text);
    } finally {
      _$SignupStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onChangeEmail(String text) {
    final _$actionInfo = _$SignupStoreBaseActionController.startAction(
        name: 'SignupStoreBase.onChangeEmail');
    try {
      return super.onChangeEmail(text);
    } finally {
      _$SignupStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onSelectGenderFemale() {
    final _$actionInfo = _$SignupStoreBaseActionController.startAction(
        name: 'SignupStoreBase.onSelectGenderFemale');
    try {
      return super.onSelectGenderFemale();
    } finally {
      _$SignupStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onSelectGenderMale() {
    final _$actionInfo = _$SignupStoreBaseActionController.startAction(
        name: 'SignupStoreBase.onSelectGenderMale');
    try {
      return super.onSelectGenderMale();
    } finally {
      _$SignupStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changePhoneNumber(dynamic data) {
    final _$actionInfo = _$SignupStoreBaseActionController.startAction(
        name: 'SignupStoreBase.changePhoneNumber');
    try {
      return super.changePhoneNumber(data);
    } finally {
      _$SignupStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _changePhoneValidResponse(String? msg) {
    final _$actionInfo = _$SignupStoreBaseActionController.startAction(
        name: 'SignupStoreBase._changePhoneValidResponse');
    try {
      return super._changePhoneValidResponse(msg);
    } finally {
      _$SignupStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changePassword(dynamic data) {
    final _$actionInfo = _$SignupStoreBaseActionController.startAction(
        name: 'SignupStoreBase.changePassword');
    try {
      return super.changePassword(data);
    } finally {
      _$SignupStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeConfirmPass(dynamic data) {
    final _$actionInfo = _$SignupStoreBaseActionController.startAction(
        name: 'SignupStoreBase.changeConfirmPass');
    try {
      return super.changeConfirmPass(data);
    } finally {
      _$SignupStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeBuildContext(BuildContext newContext) {
    final _$actionInfo = _$SignupStoreBaseActionController.startAction(
        name: 'SignupStoreBase.changeBuildContext');
    try {
      return super.changeBuildContext(newContext);
    } finally {
      _$SignupStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
fullName: ${fullName},
birthday: ${birthday},
email: ${email},
gender: ${gender},
phoneNumber: ${phoneNumber},
password: ${password},
confirmPass: ${confirmPass},
phoneValidResponse: ${phoneValidResponse},
isFemale: ${isFemale},
isMale: ${isMale},
hadBirthday: ${hadBirthday},
validateFullName: ${validateFullName},
validateBirthday: ${validateBirthday},
validateEmail: ${validateEmail},
getGender: ${getGender},
validatePhoneNumber: ${validatePhoneNumber},
validatePassword: ${validatePassword},
validateConfirmPass: ${validateConfirmPass}
    ''';
  }
}
