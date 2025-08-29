// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on HomeStoreBase, Store {
  Computed<int>? _$slideComputed;

  @override
  int get slide => (_$slideComputed ??=
          Computed<int>(() => super.slide, name: 'HomeStoreBase.slide'))
      .value;
  Computed<List<PromotionNewsModel>>? _$homeSliderDataComputed;

  @override
  List<PromotionNewsModel> get homeSliderData => (_$homeSliderDataComputed ??=
          Computed<List<PromotionNewsModel>>(() => super.homeSliderData,
              name: 'HomeStoreBase.homeSliderData'))
      .value;

  late final _$totalComingBookingAtom =
      Atom(name: 'HomeStoreBase.totalComingBooking', context: context);

  @override
  int get totalComingBooking {
    _$totalComingBookingAtom.reportRead();
    return super.totalComingBooking;
  }

  @override
  set totalComingBooking(int value) {
    _$totalComingBookingAtom.reportWrite(value, super.totalComingBooking, () {
      super.totalComingBooking = value;
    });
  }

  late final _$firstTimeBookingAtom =
      Atom(name: 'HomeStoreBase.firstTimeBooking', context: context);

  @override
  String get firstTimeBooking {
    _$firstTimeBookingAtom.reportRead();
    return super.firstTimeBooking;
  }

  @override
  set firstTimeBooking(String value) {
    _$firstTimeBookingAtom.reportWrite(value, super.firstTimeBooking, () {
      super.firstTimeBooking = value;
    });
  }

  late final _$counterAtom =
      Atom(name: 'HomeStoreBase.counter', context: context);

  @override
  int get counter {
    _$counterAtom.reportRead();
    return super.counter;
  }

  @override
  set counter(int value) {
    _$counterAtom.reportWrite(value, super.counter, () {
      super.counter = value;
    });
  }

  late final _$passwordAtom =
      Atom(name: 'HomeStoreBase.password', context: context);

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

  late final _$phoneNumberCacheAtom =
      Atom(name: 'HomeStoreBase.phoneNumberCache', context: context);

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

  late final _$isLoginAtom =
      Atom(name: 'HomeStoreBase.isLogin', context: context);

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

  late final _$isStaffAtom =
      Atom(name: 'HomeStoreBase.isStaff', context: context);

  @override
  bool get isStaff {
    _$isStaffAtom.reportRead();
    return super.isStaff;
  }

  @override
  set isStaff(bool value) {
    _$isStaffAtom.reportWrite(value, super.isStaff, () {
      super.isStaff = value;
    });
  }

  late final _$isActiveAtom =
      Atom(name: 'HomeStoreBase.isActive', context: context);

  @override
  bool get isActive {
    _$isActiveAtom.reportRead();
    return super.isActive;
  }

  @override
  set isActive(bool value) {
    _$isActiveAtom.reportWrite(value, super.isActive, () {
      super.isActive = value;
    });
  }

  late final _$loadingUserAtom =
      Atom(name: 'HomeStoreBase.loadingUser', context: context);

  @override
  bool get loadingUser {
    _$loadingUserAtom.reportRead();
    return super.loadingUser;
  }

  @override
  set loadingUser(bool value) {
    _$loadingUserAtom.reportWrite(value, super.loadingUser, () {
      super.loadingUser = value;
    });
  }

  late final _$slideNoAtom =
      Atom(name: 'HomeStoreBase.slideNo', context: context);

  @override
  int get slideNo {
    _$slideNoAtom.reportRead();
    return super.slideNo;
  }

  @override
  set slideNo(int value) {
    _$slideNoAtom.reportWrite(value, super.slideNo, () {
      super.slideNo = value;
    });
  }

  late final _$indexPromotionAtom =
      Atom(name: 'HomeStoreBase.indexPromotion', context: context);

  @override
  int get indexPromotion {
    _$indexPromotionAtom.reportRead();
    return super.indexPromotion;
  }

  @override
  set indexPromotion(int value) {
    _$indexPromotionAtom.reportWrite(value, super.indexPromotion, () {
      super.indexPromotion = value;
    });
  }

  late final _$idUnitAtom =
      Atom(name: 'HomeStoreBase.idUnit', context: context);

  @override
  int? get idUnit {
    _$idUnitAtom.reportRead();
    return super.idUnit;
  }

  @override
  set idUnit(int? value) {
    _$idUnitAtom.reportWrite(value, super.idUnit, () {
      super.idUnit = value;
    });
  }

  late final _$avatarUnitAtom =
      Atom(name: 'HomeStoreBase.avatarUnit', context: context);

  @override
  String? get avatarUnit {
    _$avatarUnitAtom.reportRead();
    return super.avatarUnit;
  }

  @override
  set avatarUnit(String? value) {
    _$avatarUnitAtom.reportWrite(value, super.avatarUnit, () {
      super.avatarUnit = value;
    });
  }

  late final _$nameUnitAtom =
      Atom(name: 'HomeStoreBase.nameUnit', context: context);

  @override
  String? get nameUnit {
    _$nameUnitAtom.reportRead();
    return super.nameUnit;
  }

  @override
  set nameUnit(String? value) {
    _$nameUnitAtom.reportWrite(value, super.nameUnit, () {
      super.nameUnit = value;
    });
  }

  late final _$addressUnitAtom =
      Atom(name: 'HomeStoreBase.addressUnit', context: context);

  @override
  String? get addressUnit {
    _$addressUnitAtom.reportRead();
    return super.addressUnit;
  }

  @override
  set addressUnit(String? value) {
    _$addressUnitAtom.reportWrite(value, super.addressUnit, () {
      super.addressUnit = value;
    });
  }

  late final _$isActivePaperAtom =
      Atom(name: 'HomeStoreBase.isActivePaper', context: context);

  @override
  bool get isActivePaper {
    _$isActivePaperAtom.reportRead();
    return super.isActivePaper;
  }

  @override
  set isActivePaper(bool value) {
    _$isActivePaperAtom.reportWrite(value, super.isActivePaper, () {
      super.isActivePaper = value;
    });
  }

  late final _$isActiveInputHealthCareAtom =
      Atom(name: 'HomeStoreBase.isActiveInputHealthCare', context: context);

  @override
  bool get isActiveInputHealthCare {
    _$isActiveInputHealthCareAtom.reportRead();
    return super.isActiveInputHealthCare;
  }

  @override
  set isActiveInputHealthCare(bool value) {
    _$isActiveInputHealthCareAtom
        .reportWrite(value, super.isActiveInputHealthCare, () {
      super.isActiveInputHealthCare = value;
    });
  }

  late final _$listPackageGroupAtom =
      Atom(name: 'HomeStoreBase.listPackageGroup', context: context);

  @override
  List<PackageGroupModel> get listPackageGroup {
    _$listPackageGroupAtom.reportRead();
    return super.listPackageGroup;
  }

  @override
  set listPackageGroup(List<PackageGroupModel> value) {
    _$listPackageGroupAtom.reportWrite(value, super.listPackageGroup, () {
      super.listPackageGroup = value;
    });
  }

  late final _$homeSliderAtom =
      Atom(name: 'HomeStoreBase.homeSlider', context: context);

  @override
  ObservableList<PromotionNewsModel> get homeSlider {
    _$homeSliderAtom.reportRead();
    return super.homeSlider;
  }

  @override
  set homeSlider(ObservableList<PromotionNewsModel> value) {
    _$homeSliderAtom.reportWrite(value, super.homeSlider, () {
      super.homeSlider = value;
    });
  }

  late final _$loadingBannerAtom =
      Atom(name: 'HomeStoreBase.loadingBanner', context: context);

  @override
  bool get loadingBanner {
    _$loadingBannerAtom.reportRead();
    return super.loadingBanner;
  }

  @override
  set loadingBanner(bool value) {
    _$loadingBannerAtom.reportWrite(value, super.loadingBanner, () {
      super.loadingBanner = value;
    });
  }

  late final _$isOfflineAtom =
      Atom(name: 'HomeStoreBase.isOffline', context: context);

  @override
  bool get isOffline {
    _$isOfflineAtom.reportRead();
    return super.isOffline;
  }

  @override
  set isOffline(bool value) {
    _$isOfflineAtom.reportWrite(value, super.isOffline, () {
      super.isOffline = value;
    });
  }

  late final _$statusesAtom =
      Atom(name: 'HomeStoreBase.statuses', context: context);

  @override
  Map<Permission, PermissionStatus> get statuses {
    _$statusesAtom.reportRead();
    return super.statuses;
  }

  @override
  set statuses(Map<Permission, PermissionStatus> value) {
    _$statusesAtom.reportWrite(value, super.statuses, () {
      super.statuses = value;
    });
  }

  late final _$medicalUnitIdAtom =
      Atom(name: 'HomeStoreBase.medicalUnitId', context: context);

  @override
  int get medicalUnitId {
    _$medicalUnitIdAtom.reportRead();
    return super.medicalUnitId;
  }

  @override
  set medicalUnitId(int value) {
    _$medicalUnitIdAtom.reportWrite(value, super.medicalUnitId, () {
      super.medicalUnitId = value;
    });
  }

  late final _$uriAboutPageAtom =
      Atom(name: 'HomeStoreBase.uriAboutPage', context: context);

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
      Atom(name: 'HomeStoreBase.fanPage', context: context);

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
      Atom(name: 'HomeStoreBase.enablePromotion', context: context);

  @override
  bool get enablePromotion {
    _$enablePromotionAtom.reportRead();
    return super.enablePromotion;
  }

  @override
  set enablePromotion(bool value) {
    _$enablePromotionAtom.reportWrite(value, super.enablePromotion, () {
      super.enablePromotion = value;
    });
  }

  late final _$timeStartAtom =
      Atom(name: 'HomeStoreBase.timeStart', context: context);

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
      Atom(name: 'HomeStoreBase.timeEnd', context: context);

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

  late final _$listProminentDoctorAtom =
      Atom(name: 'HomeStoreBase.listProminentDoctor', context: context);

  @override
  ObservableList<DoctorPagingItem> get listProminentDoctor {
    _$listProminentDoctorAtom.reportRead();
    return super.listProminentDoctor;
  }

  @override
  set listProminentDoctor(ObservableList<DoctorPagingItem> value) {
    _$listProminentDoctorAtom.reportWrite(value, super.listProminentDoctor, () {
      super.listProminentDoctor = value;
    });
  }

  late final _$healthNewsAtom =
      Atom(name: 'HomeStoreBase.healthNews', context: context);

  @override
  ObservableList<NewsPagingItem> get healthNews {
    _$healthNewsAtom.reportRead();
    return super.healthNews;
  }

  @override
  set healthNews(ObservableList<NewsPagingItem> value) {
    _$healthNewsAtom.reportWrite(value, super.healthNews, () {
      super.healthNews = value;
    });
  }

  late final _$loadingNewAtom =
      Atom(name: 'HomeStoreBase.loadingNew', context: context);

  @override
  bool get loadingNew {
    _$loadingNewAtom.reportRead();
    return super.loadingNew;
  }

  @override
  set loadingNew(bool value) {
    _$loadingNewAtom.reportWrite(value, super.loadingNew, () {
      super.loadingNew = value;
    });
  }

  late final _$promotionNewsAtom =
      Atom(name: 'HomeStoreBase.promotionNews', context: context);

  @override
  ObservableList<PromotionNewsModel> get promotionNews {
    _$promotionNewsAtom.reportRead();
    return super.promotionNews;
  }

  @override
  set promotionNews(ObservableList<PromotionNewsModel> value) {
    _$promotionNewsAtom.reportWrite(value, super.promotionNews, () {
      super.promotionNews = value;
    });
  }

  late final _$loadingPromotionAtom =
      Atom(name: 'HomeStoreBase.loadingPromotion', context: context);

  @override
  bool get loadingPromotion {
    _$loadingPromotionAtom.reportRead();
    return super.loadingPromotion;
  }

  @override
  set loadingPromotion(bool value) {
    _$loadingPromotionAtom.reportWrite(value, super.loadingPromotion, () {
      super.loadingPromotion = value;
    });
  }

  late final _$bookingsAtom =
      Atom(name: 'HomeStoreBase.bookings', context: context);

  @override
  ObservableList<BookingItem> get bookings {
    _$bookingsAtom.reportRead();
    return super.bookings;
  }

  @override
  set bookings(ObservableList<BookingItem> value) {
    _$bookingsAtom.reportWrite(value, super.bookings, () {
      super.bookings = value;
    });
  }

  late final _$loadingBookingAtom =
      Atom(name: 'HomeStoreBase.loadingBooking', context: context);

  @override
  bool get loadingBooking {
    _$loadingBookingAtom.reportRead();
    return super.loadingBooking;
  }

  @override
  set loadingBooking(bool value) {
    _$loadingBookingAtom.reportWrite(value, super.loadingBooking, () {
      super.loadingBooking = value;
    });
  }

  late final _$reloadAtom =
      Atom(name: 'HomeStoreBase.reload', context: context);

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

  late final _$incrementAsyncAction =
      AsyncAction('HomeStoreBase.increment', context: context);

  @override
  Future<void> increment() {
    return _$incrementAsyncAction.run(() => super.increment());
  }

  late final _$onErrorAsyncAction =
      AsyncAction('HomeStoreBase.onError', context: context);

  @override
  Future<void> onError(BuildContext context) {
    return _$onErrorAsyncAction.run(() => super.onError(context));
  }

  late final _$getInfoUnitAsyncAction =
      AsyncAction('HomeStoreBase.getInfoUnit', context: context);

  @override
  Future<void> getInfoUnit() {
    return _$getInfoUnitAsyncAction.run(() => super.getInfoUnit());
  }

  late final _$getPhoneNumberCacheAsyncAction =
      AsyncAction('HomeStoreBase.getPhoneNumberCache', context: context);

  @override
  Future<void> getPhoneNumberCache() {
    return _$getPhoneNumberCacheAsyncAction
        .run(() => super.getPhoneNumberCache());
  }

  late final _$checkConnectionAsyncAction =
      AsyncAction('HomeStoreBase.checkConnection', context: context);

  @override
  Future<void> checkConnection() {
    return _$checkConnectionAsyncAction.run(() => super.checkConnection());
  }

  late final _$initHomeStoreAsyncAction =
      AsyncAction('HomeStoreBase.initHomeStore', context: context);

  @override
  Future<void> initHomeStore() {
    return _$initHomeStoreAsyncAction.run(() => super.initHomeStore());
  }

  late final _$checkRoleAsyncAction =
      AsyncAction('HomeStoreBase.checkRole', context: context);

  @override
  Future<void> checkRole() {
    return _$checkRoleAsyncAction.run(() => super.checkRole());
  }

  late final _$refreshTokenAsyncAction =
      AsyncAction('HomeStoreBase.refreshToken', context: context);

  @override
  Future<void> refreshToken() {
    return _$refreshTokenAsyncAction.run(() => super.refreshToken());
  }

  late final _$loadConfigMedicalUnitAsyncAction =
      AsyncAction('HomeStoreBase.loadConfigMedicalUnit', context: context);

  @override
  Future<void> loadConfigMedicalUnit() {
    return _$loadConfigMedicalUnitAsyncAction
        .run(() => super.loadConfigMedicalUnit());
  }

  late final _$getBannerAsyncAction =
      AsyncAction('HomeStoreBase.getBanner', context: context);

  @override
  Future<void> getBanner() {
    return _$getBannerAsyncAction.run(() => super.getBanner());
  }

  late final _$getNewsAsyncAction =
      AsyncAction('HomeStoreBase.getNews', context: context);

  @override
  Future<void> getNews({required int page}) {
    return _$getNewsAsyncAction.run(() => super.getNews(page: page));
  }

  late final _$getBookmarksAsyncAction =
      AsyncAction('HomeStoreBase.getBookmarks', context: context);

  @override
  Future<void> getBookmarks() {
    return _$getBookmarksAsyncAction.run(() => super.getBookmarks());
  }

  late final _$getPromotionNewsAsyncAction =
      AsyncAction('HomeStoreBase.getPromotionNews', context: context);

  @override
  Future<void> getPromotionNews() {
    return _$getPromotionNewsAsyncAction.run(() => super.getPromotionNews());
  }

  late final _$getBookingsAsyncAction =
      AsyncAction('HomeStoreBase.getBookings', context: context);

  @override
  Future<void> getBookings() {
    return _$getBookingsAsyncAction.run(() => super.getBookings());
  }

  late final _$getPacketGroupAsyncAction =
      AsyncAction('HomeStoreBase.getPacketGroup', context: context);

  @override
  Future<void> getPacketGroup() {
    return _$getPacketGroupAsyncAction.run(() => super.getPacketGroup());
  }

  late final _$loadMorePacketGroupAsyncAction =
      AsyncAction('HomeStoreBase.loadMorePacketGroup', context: context);

  @override
  Future<void> loadMorePacketGroup() {
    return _$loadMorePacketGroupAsyncAction
        .run(() => super.loadMorePacketGroup());
  }

  late final _$getListProminentDoctorAsyncAction =
      AsyncAction('HomeStoreBase.getListProminentDoctor', context: context);

  @override
  Future<void> getListProminentDoctor() {
    return _$getListProminentDoctorAsyncAction
        .run(() => super.getListProminentDoctor());
  }

  late final _$getDetailProminentDoctorAsyncAction =
      AsyncAction('HomeStoreBase.getDetailProminentDoctor', context: context);

  @override
  Future<void> getDetailProminentDoctor(int id) {
    return _$getDetailProminentDoctorAsyncAction
        .run(() => super.getDetailProminentDoctor(id));
  }

  late final _$HomeStoreBaseActionController =
      ActionController(name: 'HomeStoreBase', context: context);

  @override
  dynamic setLogin(bool signed) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.setLogin');
    try {
      return super.setLogin(signed);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeBuildContext(BuildContext newContext) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.changeBuildContext');
    try {
      return super.changeBuildContext(newContext);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getPass(String data) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.getPass');
    try {
      return super.getPass(data);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void navigateTo(String route, dynamic args) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.navigateTo');
    try {
      return super.navigateTo(route, args);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void pushToMyQrCode() {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.pushToMyQrCode');
    try {
      return super.pushToMyQrCode();
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeNews(dynamic indexOfPage) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.changeNews');
    try {
      return super.changeNews(indexOfPage);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changePromotion(dynamic indexOfPage) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.changePromotion');
    try {
      return super.changePromotion(indexOfPage);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setReload(bool newReload) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.setReload');
    try {
      return super.setReload(newReload);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
totalComingBooking: ${totalComingBooking},
firstTimeBooking: ${firstTimeBooking},
counter: ${counter},
password: ${password},
phoneNumberCache: ${phoneNumberCache},
isLogin: ${isLogin},
isStaff: ${isStaff},
isActive: ${isActive},
loadingUser: ${loadingUser},
slideNo: ${slideNo},
indexPromotion: ${indexPromotion},
idUnit: ${idUnit},
avatarUnit: ${avatarUnit},
nameUnit: ${nameUnit},
addressUnit: ${addressUnit},
isActivePaper: ${isActivePaper},
isActiveInputHealthCare: ${isActiveInputHealthCare},
listPackageGroup: ${listPackageGroup},
homeSlider: ${homeSlider},
loadingBanner: ${loadingBanner},
isOffline: ${isOffline},
statuses: ${statuses},
medicalUnitId: ${medicalUnitId},
uriAboutPage: ${uriAboutPage},
fanPage: ${fanPage},
enablePromotion: ${enablePromotion},
timeStart: ${timeStart},
timeEnd: ${timeEnd},
listProminentDoctor: ${listProminentDoctor},
healthNews: ${healthNews},
loadingNew: ${loadingNew},
promotionNews: ${promotionNews},
loadingPromotion: ${loadingPromotion},
bookings: ${bookings},
loadingBooking: ${loadingBooking},
reload: ${reload},
slide: ${slide},
homeSliderData: ${homeSliderData}
    ''';
  }
}
