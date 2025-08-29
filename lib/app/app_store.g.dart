// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppStore on AppStoreBase, Store {
  Computed<String>? _$fcmTokenComputed;

  @override
  String get fcmToken => (_$fcmTokenComputed ??=
          Computed<String>(() => super.fcmToken, name: 'AppStoreBase.fcmToken'))
      .value;
  Computed<bool>? _$getGotoEHRComputed;

  @override
  bool get getGotoEHR =>
      (_$getGotoEHRComputed ??= Computed<bool>(() => super.getGotoEHR,
              name: 'AppStoreBase.getGotoEHR'))
          .value;

  late final _$reloadAtom = Atom(name: 'AppStoreBase.reload', context: context);

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

  late final _$rateAppAtom =
      Atom(name: 'AppStoreBase.rateApp', context: context);

  @override
  bool get rateApp {
    _$rateAppAtom.reportRead();
    return super.rateApp;
  }

  @override
  set rateApp(bool value) {
    _$rateAppAtom.reportWrite(value, super.rateApp, () {
      super.rateApp = value;
    });
  }

  late final _$fireBaseTokenAtom =
      Atom(name: 'AppStoreBase.fireBaseToken', context: context);

  @override
  String get fireBaseToken {
    _$fireBaseTokenAtom.reportRead();
    return super.fireBaseToken;
  }

  @override
  set fireBaseToken(String value) {
    _$fireBaseTokenAtom.reportWrite(value, super.fireBaseToken, () {
      super.fireBaseToken = value;
    });
  }

  late final _$uriAboutPageAtom =
      Atom(name: 'AppStoreBase.uriAboutPage', context: context);

  @override
  String get uriAboutPage {
    _$uriAboutPageAtom.reportRead();
    return super.uriAboutPage;
  }

  @override
  set uriAboutPage(String value) {
    _$uriAboutPageAtom.reportWrite(value, super.uriAboutPage, () {
      super.uriAboutPage = value;
    });
  }

  late final _$fanPageAtom =
      Atom(name: 'AppStoreBase.fanPage', context: context);

  @override
  String get fanPage {
    _$fanPageAtom.reportRead();
    return super.fanPage;
  }

  @override
  set fanPage(String value) {
    _$fanPageAtom.reportWrite(value, super.fanPage, () {
      super.fanPage = value;
    });
  }

  late final _$enablePromotionAtom =
      Atom(name: 'AppStoreBase.enablePromotion', context: context);

  @override
  String get enablePromotion {
    _$enablePromotionAtom.reportRead();
    return super.enablePromotion;
  }

  @override
  set enablePromotion(String value) {
    _$enablePromotionAtom.reportWrite(value, super.enablePromotion, () {
      super.enablePromotion = value;
    });
  }

  late final _$enableSignUpOTPAtom =
      Atom(name: 'AppStoreBase.enableSignUpOTP', context: context);

  @override
  bool get enableSignUpOTP {
    _$enableSignUpOTPAtom.reportRead();
    return super.enableSignUpOTP;
  }

  @override
  set enableSignUpOTP(bool value) {
    _$enableSignUpOTPAtom.reportWrite(value, super.enableSignUpOTP, () {
      super.enableSignUpOTP = value;
    });
  }

  late final _$enableForgotOTPAtom =
      Atom(name: 'AppStoreBase.enableForgotOTP', context: context);

  @override
  bool get enableForgotOTP {
    _$enableForgotOTPAtom.reportRead();
    return super.enableForgotOTP;
  }

  @override
  set enableForgotOTP(bool value) {
    _$enableForgotOTPAtom.reportWrite(value, super.enableForgotOTP, () {
      super.enableForgotOTP = value;
    });
  }

  late final _$timeStartAtom =
      Atom(name: 'AppStoreBase.timeStart', context: context);

  @override
  String get timeStart {
    _$timeStartAtom.reportRead();
    return super.timeStart;
  }

  @override
  set timeStart(String value) {
    _$timeStartAtom.reportWrite(value, super.timeStart, () {
      super.timeStart = value;
    });
  }

  late final _$timeEndAtom =
      Atom(name: 'AppStoreBase.timeEnd', context: context);

  @override
  String get timeEnd {
    _$timeEndAtom.reportRead();
    return super.timeEnd;
  }

  @override
  set timeEnd(String value) {
    _$timeEndAtom.reportWrite(value, super.timeEnd, () {
      super.timeEnd = value;
    });
  }

  late final _$landingUnitModelAtom =
      Atom(name: 'AppStoreBase.landingUnitModel', context: context);

  @override
  LandingUnitModel get landingUnitModel {
    _$landingUnitModelAtom.reportRead();
    return super.landingUnitModel;
  }

  @override
  set landingUnitModel(LandingUnitModel value) {
    _$landingUnitModelAtom.reportWrite(value, super.landingUnitModel, () {
      super.landingUnitModel = value;
    });
  }

  late final _$supportLinePhoneNumberAtom =
      Atom(name: 'AppStoreBase.supportLinePhoneNumber', context: context);

  @override
  String get supportLinePhoneNumber {
    _$supportLinePhoneNumberAtom.reportRead();
    return super.supportLinePhoneNumber;
  }

  @override
  set supportLinePhoneNumber(String value) {
    _$supportLinePhoneNumberAtom
        .reportWrite(value, super.supportLinePhoneNumber, () {
      super.supportLinePhoneNumber = value;
    });
  }

  late final _$supportMessAtom =
      Atom(name: 'AppStoreBase.supportMess', context: context);

  @override
  String get supportMess {
    _$supportMessAtom.reportRead();
    return super.supportMess;
  }

  @override
  set supportMess(String value) {
    _$supportMessAtom.reportWrite(value, super.supportMess, () {
      super.supportMess = value;
    });
  }

  late final _$progressAtom =
      Atom(name: 'AppStoreBase.progress', context: context);

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

  late final _$loadingQRAtom =
      Atom(name: 'AppStoreBase.loadingQR', context: context);

  @override
  bool get loadingQR {
    _$loadingQRAtom.reportRead();
    return super.loadingQR;
  }

  @override
  set loadingQR(bool value) {
    _$loadingQRAtom.reportWrite(value, super.loadingQR, () {
      super.loadingQR = value;
    });
  }

  late final _$qrcodeDataAtom =
      Atom(name: 'AppStoreBase.qrcodeData', context: context);

  @override
  String get qrcodeData {
    _$qrcodeDataAtom.reportRead();
    return super.qrcodeData;
  }

  @override
  set qrcodeData(String value) {
    _$qrcodeDataAtom.reportWrite(value, super.qrcodeData, () {
      super.qrcodeData = value;
    });
  }

  late final _$languageAtom =
      Atom(name: 'AppStoreBase.language', context: context);

  @override
  Locale get language {
    _$languageAtom.reportRead();
    return super.language;
  }

  @override
  set language(Locale value) {
    _$languageAtom.reportWrite(value, super.language, () {
      super.language = value;
    });
  }

  late final _$turnOnTouchIDAtom =
      Atom(name: 'AppStoreBase.turnOnTouchID', context: context);

  @override
  bool get turnOnTouchID {
    _$turnOnTouchIDAtom.reportRead();
    return super.turnOnTouchID;
  }

  @override
  set turnOnTouchID(bool value) {
    _$turnOnTouchIDAtom.reportWrite(value, super.turnOnTouchID, () {
      super.turnOnTouchID = value;
    });
  }

  late final _$remoteMessageAtom =
      Atom(name: 'AppStoreBase.remoteMessage', context: context);

  @override
  RemoteMessage? get remoteMessage {
    _$remoteMessageAtom.reportRead();
    return super.remoteMessage;
  }

  @override
  set remoteMessage(RemoteMessage? value) {
    _$remoteMessageAtom.reportWrite(value, super.remoteMessage, () {
      super.remoteMessage = value;
    });
  }

  late final _$nextNotificationDetailsAtom =
      Atom(name: 'AppStoreBase.nextNotificationDetails', context: context);

  @override
  bool get nextNotificationDetails {
    _$nextNotificationDetailsAtom.reportRead();
    return super.nextNotificationDetails;
  }

  @override
  set nextNotificationDetails(bool value) {
    _$nextNotificationDetailsAtom
        .reportWrite(value, super.nextNotificationDetails, () {
      super.nextNotificationDetails = value;
    });
  }

  late final _$gotoEHRAtom =
      Atom(name: 'AppStoreBase.gotoEHR', context: context);

  @override
  bool get gotoEHR {
    _$gotoEHRAtom.reportRead();
    return super.gotoEHR;
  }

  @override
  set gotoEHR(bool value) {
    _$gotoEHRAtom.reportWrite(value, super.gotoEHR, () {
      super.gotoEHR = value;
    });
  }

  late final _$onSelectLanguageAsyncAction =
      AsyncAction('AppStoreBase.onSelectLanguage', context: context);

  @override
  Future<void> onSelectLanguage(Locale value) {
    return _$onSelectLanguageAsyncAction
        .run(() => super.onSelectLanguage(value));
  }

  late final _$getLanguageAsyncAction =
      AsyncAction('AppStoreBase.getLanguage', context: context);

  @override
  Future<void> getLanguage() {
    return _$getLanguageAsyncAction.run(() => super.getLanguage());
  }

  late final _$loadBiometricSettingAsyncAction =
      AsyncAction('AppStoreBase.loadBiometricSetting', context: context);

  @override
  Future<void> loadBiometricSetting() {
    return _$loadBiometricSettingAsyncAction
        .run(() => super.loadBiometricSetting());
  }

  late final _$getLandingUnitAsyncAction =
      AsyncAction('AppStoreBase.getLandingUnit', context: context);

  @override
  Future<void> getLandingUnit(int id) {
    return _$getLandingUnitAsyncAction.run(() => super.getLandingUnit(id));
  }

  late final _$AppStoreBaseActionController =
      ActionController(name: 'AppStoreBase', context: context);

  @override
  void setReload(bool newReload) {
    final _$actionInfo = _$AppStoreBaseActionController.startAction(
        name: 'AppStoreBase.setReload');
    try {
      return super.setReload(newReload);
    } finally {
      _$AppStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRemoteMessage(RemoteMessage data) {
    final _$actionInfo = _$AppStoreBaseActionController.startAction(
        name: 'AppStoreBase.setRemoteMessage');
    try {
      return super.setRemoteMessage(data);
    } finally {
      _$AppStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNextNotificationDetails(bool val) {
    final _$actionInfo = _$AppStoreBaseActionController.startAction(
        name: 'AppStoreBase.setNextNotificationDetails');
    try {
      return super.setNextNotificationDetails(val);
    } finally {
      _$AppStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setGotoEHR(bool val) {
    final _$actionInfo = _$AppStoreBaseActionController.startAction(
        name: 'AppStoreBase.setGotoEHR');
    try {
      return super.setGotoEHR(val);
    } finally {
      _$AppStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
reload: ${reload},
rateApp: ${rateApp},
fireBaseToken: ${fireBaseToken},
uriAboutPage: ${uriAboutPage},
fanPage: ${fanPage},
enablePromotion: ${enablePromotion},
enableSignUpOTP: ${enableSignUpOTP},
enableForgotOTP: ${enableForgotOTP},
timeStart: ${timeStart},
timeEnd: ${timeEnd},
landingUnitModel: ${landingUnitModel},
supportLinePhoneNumber: ${supportLinePhoneNumber},
supportMess: ${supportMess},
progress: ${progress},
loadingQR: ${loadingQR},
qrcodeData: ${qrcodeData},
language: ${language},
turnOnTouchID: ${turnOnTouchID},
remoteMessage: ${remoteMessage},
nextNotificationDetails: ${nextNotificationDetails},
gotoEHR: ${gotoEHR},
fcmToken: ${fcmToken},
getGotoEHR: ${getGotoEHR}
    ''';
  }
}
