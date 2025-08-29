// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_and_payment_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ConfirmAndPaymentStore on ConfirmAndPaymentStoreBase, Store {
  Computed<int>? _$realPriceComputed;

  @override
  int get realPrice =>
      (_$realPriceComputed ??= Computed<int>(() => super.realPrice,
              name: 'ConfirmAndPaymentStoreBase.realPrice'))
          .value;
  Computed<List<DiscountCode>>? _$getListDiscountCodeActiveComputed;

  @override
  List<DiscountCode> get getListDiscountCodeActive =>
      (_$getListDiscountCodeActiveComputed ??= Computed<List<DiscountCode>>(
              () => super.getListDiscountCodeActive,
              name: 'ConfirmAndPaymentStoreBase.getListDiscountCodeActive'))
          .value;
  Computed<List<DiscountCode>>? _$getListDiscountCodeInActiveComputed;

  @override
  List<DiscountCode> get getListDiscountCodeInActive =>
      (_$getListDiscountCodeInActiveComputed ??= Computed<List<DiscountCode>>(
              () => super.getListDiscountCodeInActive,
              name: 'ConfirmAndPaymentStoreBase.getListDiscountCodeInActive'))
          .value;

  late final _$bookingInfoAtom =
      Atom(name: 'ConfirmAndPaymentStoreBase.bookingInfo', context: context);

  @override
  BookingInfo get bookingInfo {
    _$bookingInfoAtom.reportRead();
    return super.bookingInfo;
  }

  @override
  set bookingInfo(BookingInfo value) {
    _$bookingInfoAtom.reportWrite(value, super.bookingInfo, () {
      super.bookingInfo = value;
    });
  }

  late final _$listDiscountCodeAtom = Atom(
      name: 'ConfirmAndPaymentStoreBase.listDiscountCode', context: context);

  @override
  List<DiscountCode> get listDiscountCode {
    _$listDiscountCodeAtom.reportRead();
    return super.listDiscountCode;
  }

  @override
  set listDiscountCode(List<DiscountCode> value) {
    _$listDiscountCodeAtom.reportWrite(value, super.listDiscountCode, () {
      super.listDiscountCode = value;
    });
  }

  late final _$qrCodeModelAtom =
      Atom(name: 'ConfirmAndPaymentStoreBase.qrCodeModel', context: context);

  @override
  QrCodeModel get qrCodeModel {
    _$qrCodeModelAtom.reportRead();
    return super.qrCodeModel;
  }

  @override
  set qrCodeModel(QrCodeModel value) {
    _$qrCodeModelAtom.reportWrite(value, super.qrCodeModel, () {
      super.qrCodeModel = value;
    });
  }

  late final _$isInvoiceAtom =
      Atom(name: 'ConfirmAndPaymentStoreBase.isInvoice', context: context);

  @override
  bool get isInvoice {
    _$isInvoiceAtom.reportRead();
    return super.isInvoice;
  }

  @override
  set isInvoice(bool value) {
    _$isInvoiceAtom.reportWrite(value, super.isInvoice, () {
      super.isInvoice = value;
    });
  }

  late final _$discountAppliesAtom = Atom(
      name: 'ConfirmAndPaymentStoreBase.discountApplies', context: context);

  @override
  DiscountCode get discountApplies {
    _$discountAppliesAtom.reportRead();
    return super.discountApplies;
  }

  @override
  set discountApplies(DiscountCode value) {
    _$discountAppliesAtom.reportWrite(value, super.discountApplies, () {
      super.discountApplies = value;
    });
  }

  late final _$discountDialogIdAtom = Atom(
      name: 'ConfirmAndPaymentStoreBase.discountDialogId', context: context);

  @override
  String get discountDialogId {
    _$discountDialogIdAtom.reportRead();
    return super.discountDialogId;
  }

  @override
  set discountDialogId(String value) {
    _$discountDialogIdAtom.reportWrite(value, super.discountDialogId, () {
      super.discountDialogId = value;
    });
  }

  late final _$nameCompanyAtom =
      Atom(name: 'ConfirmAndPaymentStoreBase.nameCompany', context: context);

  @override
  String get nameCompany {
    _$nameCompanyAtom.reportRead();
    return super.nameCompany;
  }

  @override
  set nameCompany(String value) {
    _$nameCompanyAtom.reportWrite(value, super.nameCompany, () {
      super.nameCompany = value;
    });
  }

  late final _$locationCompanyAtom = Atom(
      name: 'ConfirmAndPaymentStoreBase.locationCompany', context: context);

  @override
  String get locationCompany {
    _$locationCompanyAtom.reportRead();
    return super.locationCompany;
  }

  @override
  set locationCompany(String value) {
    _$locationCompanyAtom.reportWrite(value, super.locationCompany, () {
      super.locationCompany = value;
    });
  }

  late final _$taxCodeAtom =
      Atom(name: 'ConfirmAndPaymentStoreBase.taxCode', context: context);

  @override
  String get taxCode {
    _$taxCodeAtom.reportRead();
    return super.taxCode;
  }

  @override
  set taxCode(String value) {
    _$taxCodeAtom.reportWrite(value, super.taxCode, () {
      super.taxCode = value;
    });
  }

  late final _$loadingDiscountAtom = Atom(
      name: 'ConfirmAndPaymentStoreBase.loadingDiscount', context: context);

  @override
  bool get loadingDiscount {
    _$loadingDiscountAtom.reportRead();
    return super.loadingDiscount;
  }

  @override
  set loadingDiscount(bool value) {
    _$loadingDiscountAtom.reportWrite(value, super.loadingDiscount, () {
      super.loadingDiscount = value;
    });
  }

  late final _$bookingAsyncAction =
      AsyncAction('ConfirmAndPaymentStoreBase.booking', context: context);

  @override
  Future<void> booking() {
    return _$bookingAsyncAction.run(() => super.booking());
  }

  late final _$getDiscountAsyncAction =
      AsyncAction('ConfirmAndPaymentStoreBase.getDiscount', context: context);

  @override
  Future<void> getDiscount() {
    return _$getDiscountAsyncAction.run(() => super.getDiscount());
  }

  late final _$ConfirmAndPaymentStoreBaseActionController =
      ActionController(name: 'ConfirmAndPaymentStoreBase', context: context);

  @override
  void onChangePaymentInfo(BookingInfo value) {
    final _$actionInfo = _$ConfirmAndPaymentStoreBaseActionController
        .startAction(name: 'ConfirmAndPaymentStoreBase.onChangePaymentInfo');
    try {
      return super.onChangePaymentInfo(value);
    } finally {
      _$ConfirmAndPaymentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void navigateTo(String route) {
    final _$actionInfo = _$ConfirmAndPaymentStoreBaseActionController
        .startAction(name: 'ConfirmAndPaymentStoreBase.navigateTo');
    try {
      return super.navigateTo(route);
    } finally {
      _$ConfirmAndPaymentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onCheckInvoice() {
    final _$actionInfo = _$ConfirmAndPaymentStoreBaseActionController
        .startAction(name: 'ConfirmAndPaymentStoreBase.onCheckInvoice');
    try {
      return super.onCheckInvoice();
    } finally {
      _$ConfirmAndPaymentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onSaveListDiscount(List<DiscountCode> list) {
    final _$actionInfo = _$ConfirmAndPaymentStoreBaseActionController
        .startAction(name: 'ConfirmAndPaymentStoreBase.onSaveListDiscount');
    try {
      return super.onSaveListDiscount(list);
    } finally {
      _$ConfirmAndPaymentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onApplyDiscount() {
    final _$actionInfo = _$ConfirmAndPaymentStoreBaseActionController
        .startAction(name: 'ConfirmAndPaymentStoreBase.onApplyDiscount');
    try {
      return super.onApplyDiscount();
    } finally {
      _$ConfirmAndPaymentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onSaveDiscordDialogId(String id) {
    final _$actionInfo = _$ConfirmAndPaymentStoreBaseActionController
        .startAction(name: 'ConfirmAndPaymentStoreBase.onSaveDiscordDialogId');
    try {
      return super.onSaveDiscordDialogId(id);
    } finally {
      _$ConfirmAndPaymentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeNameCompany(String value) {
    final _$actionInfo = _$ConfirmAndPaymentStoreBaseActionController
        .startAction(name: 'ConfirmAndPaymentStoreBase.changeNameCompany');
    try {
      return super.changeNameCompany(value);
    } finally {
      _$ConfirmAndPaymentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeLocationCompany(String value) {
    final _$actionInfo = _$ConfirmAndPaymentStoreBaseActionController
        .startAction(name: 'ConfirmAndPaymentStoreBase.changeLocationCompany');
    try {
      return super.changeLocationCompany(value);
    } finally {
      _$ConfirmAndPaymentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeTaxCode(String value) {
    final _$actionInfo = _$ConfirmAndPaymentStoreBaseActionController
        .startAction(name: 'ConfirmAndPaymentStoreBase.changeTaxCode');
    try {
      return super.changeTaxCode(value);
    } finally {
      _$ConfirmAndPaymentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onSearch(String text) {
    final _$actionInfo = _$ConfirmAndPaymentStoreBaseActionController
        .startAction(name: 'ConfirmAndPaymentStoreBase.onSearch');
    try {
      return super.onSearch(text);
    } finally {
      _$ConfirmAndPaymentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeBuildContext(BuildContext newContext) {
    final _$actionInfo = _$ConfirmAndPaymentStoreBaseActionController
        .startAction(name: 'ConfirmAndPaymentStoreBase.changeBuildContext');
    try {
      return super.changeBuildContext(newContext);
    } finally {
      _$ConfirmAndPaymentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
bookingInfo: ${bookingInfo},
listDiscountCode: ${listDiscountCode},
qrCodeModel: ${qrCodeModel},
isInvoice: ${isInvoice},
discountApplies: ${discountApplies},
discountDialogId: ${discountDialogId},
nameCompany: ${nameCompany},
locationCompany: ${locationCompany},
taxCode: ${taxCode},
loadingDiscount: ${loadingDiscount},
realPrice: ${realPrice},
getListDiscountCodeActive: ${getListDiscountCodeActive},
getListDiscountCodeInActive: ${getListDiscountCodeInActive}
    ''';
  }
}
