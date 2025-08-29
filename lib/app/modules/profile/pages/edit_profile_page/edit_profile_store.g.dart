// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_profile_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EditProfileStore on EditProfileStoreBase, Store {
  Computed<bool>? _$isFemaleComputed;

  @override
  bool get isFemale =>
      (_$isFemaleComputed ??= Computed<bool>(() => super.isFemale,
              name: 'EditProfileStoreBase.isFemale'))
          .value;
  Computed<bool>? _$isMaleComputed;

  @override
  bool get isMale => (_$isMaleComputed ??= Computed<bool>(() => super.isMale,
          name: 'EditProfileStoreBase.isMale'))
      .value;
  Computed<bool>? _$hadBirthdayComputed;

  @override
  bool get hadBirthday =>
      (_$hadBirthdayComputed ??= Computed<bool>(() => super.hadBirthday,
              name: 'EditProfileStoreBase.hadBirthday'))
          .value;
  Computed<String?>? _$validateFullNameComputed;

  @override
  String? get validateFullName => (_$validateFullNameComputed ??=
          Computed<String?>(() => super.validateFullName,
              name: 'EditProfileStoreBase.validateFullName'))
      .value;
  Computed<String?>? _$validateBirthdayComputed;

  @override
  String? get validateBirthday => (_$validateBirthdayComputed ??=
          Computed<String?>(() => super.validateBirthday,
              name: 'EditProfileStoreBase.validateBirthday'))
      .value;
  Computed<String?>? _$validateEmailComputed;

  @override
  String? get validateEmail =>
      (_$validateEmailComputed ??= Computed<String?>(() => super.validateEmail,
              name: 'EditProfileStoreBase.validateEmail'))
          .value;
  Computed<String?>? _$validatePhoneNumberComputed;

  @override
  String? get validatePhoneNumber => (_$validatePhoneNumberComputed ??=
          Computed<String?>(() => super.validatePhoneNumber,
              name: 'EditProfileStoreBase.validatePhoneNumber'))
      .value;
  Computed<String>? _$getGenderComputed;

  @override
  String get getGender =>
      (_$getGenderComputed ??= Computed<String>(() => super.getGender,
              name: 'EditProfileStoreBase.getGender'))
          .value;

  late final _$fullNameAtom =
      Atom(name: 'EditProfileStoreBase.fullName', context: context);

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
      Atom(name: 'EditProfileStoreBase.birthday', context: context);

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
      Atom(name: 'EditProfileStoreBase.email', context: context);

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
      Atom(name: 'EditProfileStoreBase.gender', context: context);

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
      Atom(name: 'EditProfileStoreBase.phoneNumber', context: context);

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

  late final _$avatarAtom =
      Atom(name: 'EditProfileStoreBase.avatar', context: context);

  @override
  String get avatar {
    _$avatarAtom.reportRead();
    return super.avatar;
  }

  @override
  set avatar(String value) {
    _$avatarAtom.reportWrite(value, super.avatar, () {
      super.avatar = value;
    });
  }

  late final _$localAvatarPathAtom =
      Atom(name: 'EditProfileStoreBase.localAvatarPath', context: context);

  @override
  String get localAvatarPath {
    _$localAvatarPathAtom.reportRead();
    return super.localAvatarPath;
  }

  @override
  set localAvatarPath(String value) {
    _$localAvatarPathAtom.reportWrite(value, super.localAvatarPath, () {
      super.localAvatarPath = value;
    });
  }

  late final _$addressAtom =
      Atom(name: 'EditProfileStoreBase.address', context: context);

  @override
  String get address {
    _$addressAtom.reportRead();
    return super.address;
  }

  @override
  set address(String value) {
    _$addressAtom.reportWrite(value, super.address, () {
      super.address = value;
    });
  }

  late final _$personalIdAtom =
      Atom(name: 'EditProfileStoreBase.personalId', context: context);

  @override
  String get personalId {
    _$personalIdAtom.reportRead();
    return super.personalId;
  }

  @override
  set personalId(String value) {
    _$personalIdAtom.reportWrite(value, super.personalId, () {
      super.personalId = value;
    });
  }

  late final _$insuranceNumberAtom =
      Atom(name: 'EditProfileStoreBase.insuranceNumber', context: context);

  @override
  String get insuranceNumber {
    _$insuranceNumberAtom.reportRead();
    return super.insuranceNumber;
  }

  @override
  set insuranceNumber(String value) {
    _$insuranceNumberAtom.reportWrite(value, super.insuranceNumber, () {
      super.insuranceNumber = value;
    });
  }

  late final _$codeNursingAtom =
      Atom(name: 'EditProfileStoreBase.codeNursing', context: context);

  @override
  String get codeNursing {
    _$codeNursingAtom.reportRead();
    return super.codeNursing;
  }

  @override
  set codeNursing(String value) {
    _$codeNursingAtom.reportWrite(value, super.codeNursing, () {
      super.codeNursing = value;
    });
  }

  late final _$dobControllerAtom =
      Atom(name: 'EditProfileStoreBase.dobController', context: context);

  @override
  TextEditingController get dobController {
    _$dobControllerAtom.reportRead();
    return super.dobController;
  }

  @override
  set dobController(TextEditingController value) {
    _$dobControllerAtom.reportWrite(value, super.dobController, () {
      super.dobController = value;
    });
  }

  late final _$onUpdateUserAsyncAction =
      AsyncAction('EditProfileStoreBase.onUpdateUser', context: context);

  @override
  Future<void> onUpdateUser({String? birthday}) {
    return _$onUpdateUserAsyncAction
        .run(() => super.onUpdateUser(birthday: birthday));
  }

  late final _$EditProfileStoreBaseActionController =
      ActionController(name: 'EditProfileStoreBase', context: context);

  @override
  void onChangeFullName(String text) {
    final _$actionInfo = _$EditProfileStoreBaseActionController.startAction(
        name: 'EditProfileStoreBase.onChangeFullName');
    try {
      return super.onChangeFullName(text);
    } finally {
      _$EditProfileStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onChangeAddress(String text) {
    final _$actionInfo = _$EditProfileStoreBaseActionController.startAction(
        name: 'EditProfileStoreBase.onChangeAddress');
    try {
      return super.onChangeAddress(text);
    } finally {
      _$EditProfileStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onChangePersonalId(String text) {
    final _$actionInfo = _$EditProfileStoreBaseActionController.startAction(
        name: 'EditProfileStoreBase.onChangePersonalId');
    try {
      return super.onChangePersonalId(text);
    } finally {
      _$EditProfileStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onChangeInsuranceNumber(String text) {
    final _$actionInfo = _$EditProfileStoreBaseActionController.startAction(
        name: 'EditProfileStoreBase.onChangeInsuranceNumber');
    try {
      return super.onChangeInsuranceNumber(text);
    } finally {
      _$EditProfileStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onChangeInsuranceId(String text) {
    final _$actionInfo = _$EditProfileStoreBaseActionController.startAction(
        name: 'EditProfileStoreBase.onChangeInsuranceId');
    try {
      return super.onChangeInsuranceId(text);
    } finally {
      _$EditProfileStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onChangeBirthday(String text) {
    final _$actionInfo = _$EditProfileStoreBaseActionController.startAction(
        name: 'EditProfileStoreBase.onChangeBirthday');
    try {
      return super.onChangeBirthday(text);
    } finally {
      _$EditProfileStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onChangeEmail(String text) {
    final _$actionInfo = _$EditProfileStoreBaseActionController.startAction(
        name: 'EditProfileStoreBase.onChangeEmail');
    try {
      return super.onChangeEmail(text);
    } finally {
      _$EditProfileStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onChangeAvatar(XFile file) {
    final _$actionInfo = _$EditProfileStoreBaseActionController.startAction(
        name: 'EditProfileStoreBase.onChangeAvatar');
    try {
      return super.onChangeAvatar(file);
    } finally {
      _$EditProfileStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onChangePhone(String text) {
    final _$actionInfo = _$EditProfileStoreBaseActionController.startAction(
        name: 'EditProfileStoreBase.onChangePhone');
    try {
      return super.onChangePhone(text);
    } finally {
      _$EditProfileStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onChangeCodeNursing(String text) {
    final _$actionInfo = _$EditProfileStoreBaseActionController.startAction(
        name: 'EditProfileStoreBase.onChangeCodeNursing');
    try {
      return super.onChangeCodeNursing(text);
    } finally {
      _$EditProfileStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onSelectGender(Gender? genderSelected) {
    final _$actionInfo = _$EditProfileStoreBaseActionController.startAction(
        name: 'EditProfileStoreBase.onSelectGender');
    try {
      return super.onSelectGender(genderSelected);
    } finally {
      _$EditProfileStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onChangeBuildContext(BuildContext buildContext) {
    final _$actionInfo = _$EditProfileStoreBaseActionController.startAction(
        name: 'EditProfileStoreBase.onChangeBuildContext');
    try {
      return super.onChangeBuildContext(buildContext);
    } finally {
      _$EditProfileStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void initialValue(user.UserInfoModel dataUserInfo) {
    final _$actionInfo = _$EditProfileStoreBaseActionController.startAction(
        name: 'EditProfileStoreBase.initialValue');
    try {
      return super.initialValue(dataUserInfo);
    } finally {
      _$EditProfileStoreBaseActionController.endAction(_$actionInfo);
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
avatar: ${avatar},
localAvatarPath: ${localAvatarPath},
address: ${address},
personalId: ${personalId},
insuranceNumber: ${insuranceNumber},
codeNursing: ${codeNursing},
dobController: ${dobController},
isFemale: ${isFemale},
isMale: ${isMale},
hadBirthday: ${hadBirthday},
validateFullName: ${validateFullName},
validateBirthday: ${validateBirthday},
validateEmail: ${validateEmail},
validatePhoneNumber: ${validatePhoneNumber},
getGender: ${getGender}
    ''';
  }
}
