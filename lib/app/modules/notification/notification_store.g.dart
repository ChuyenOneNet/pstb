// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$NotificationStore on NotificationStoreBase, Store {
  Computed<int>? _$getPageUserNotificationComputed;

  @override
  int get getPageUserNotification => (_$getPageUserNotificationComputed ??=
          Computed<int>(() => super.getPageUserNotification,
              name: 'NotificationStoreBase.getPageUserNotification'))
      .value;
  Computed<int>? _$getPageOtherNotificationComputed;

  @override
  int get getPageOtherNotification => (_$getPageOtherNotificationComputed ??=
          Computed<int>(() => super.getPageOtherNotification,
              name: 'NotificationStoreBase.getPageOtherNotification'))
      .value;
  Computed<int>? _$getCurrentIndexPageComputed;

  @override
  int get getCurrentIndexPage => (_$getCurrentIndexPageComputed ??=
          Computed<int>(() => super.getCurrentIndexPage,
              name: 'NotificationStoreBase.getCurrentIndexPage'))
      .value;

  late final _$loadingMyNotificationsAtom = Atom(
      name: 'NotificationStoreBase.loadingMyNotifications', context: context);

  @override
  bool get loadingMyNotifications {
    _$loadingMyNotificationsAtom.reportRead();
    return super.loadingMyNotifications;
  }

  @override
  set loadingMyNotifications(bool value) {
    _$loadingMyNotificationsAtom
        .reportWrite(value, super.loadingMyNotifications, () {
      super.loadingMyNotifications = value;
    });
  }

  late final _$loadingSysNotificationsAtom = Atom(
      name: 'NotificationStoreBase.loadingSysNotifications', context: context);

  @override
  bool get loadingSysNotifications {
    _$loadingSysNotificationsAtom.reportRead();
    return super.loadingSysNotifications;
  }

  @override
  set loadingSysNotifications(bool value) {
    _$loadingSysNotificationsAtom
        .reportWrite(value, super.loadingSysNotifications, () {
      super.loadingSysNotifications = value;
    });
  }

  late final _$indexPageAtom =
      Atom(name: 'NotificationStoreBase.indexPage', context: context);

  @override
  int get indexPage {
    _$indexPageAtom.reportRead();
    return super.indexPage;
  }

  @override
  set indexPage(int value) {
    _$indexPageAtom.reportWrite(value, super.indexPage, () {
      super.indexPage = value;
    });
  }

  late final _$pageUserNotificationAtom = Atom(
      name: 'NotificationStoreBase.pageUserNotification', context: context);

  @override
  int get pageUserNotification {
    _$pageUserNotificationAtom.reportRead();
    return super.pageUserNotification;
  }

  @override
  set pageUserNotification(int value) {
    _$pageUserNotificationAtom.reportWrite(value, super.pageUserNotification,
        () {
      super.pageUserNotification = value;
    });
  }

  late final _$pageOtherNotificationAtom = Atom(
      name: 'NotificationStoreBase.pageOtherNotification', context: context);

  @override
  int get pageOtherNotification {
    _$pageOtherNotificationAtom.reportRead();
    return super.pageOtherNotification;
  }

  @override
  set pageOtherNotification(int value) {
    _$pageOtherNotificationAtom.reportWrite(value, super.pageOtherNotification,
        () {
      super.pageOtherNotification = value;
    });
  }

  late final _$firstLoadMyNotiAtom =
      Atom(name: 'NotificationStoreBase.firstLoadMyNoti', context: context);

  @override
  bool get firstLoadMyNoti {
    _$firstLoadMyNotiAtom.reportRead();
    return super.firstLoadMyNoti;
  }

  @override
  set firstLoadMyNoti(bool value) {
    _$firstLoadMyNotiAtom.reportWrite(value, super.firstLoadMyNoti, () {
      super.firstLoadMyNoti = value;
    });
  }

  late final _$firstLoadSysNotiAtom =
      Atom(name: 'NotificationStoreBase.firstLoadSysNoti', context: context);

  @override
  bool get firstLoadSysNoti {
    _$firstLoadSysNotiAtom.reportRead();
    return super.firstLoadSysNoti;
  }

  @override
  set firstLoadSysNoti(bool value) {
    _$firstLoadSysNotiAtom.reportWrite(value, super.firstLoadSysNoti, () {
      super.firstLoadSysNoti = value;
    });
  }

  late final _$newNotificationsAtom =
      Atom(name: 'NotificationStoreBase.newNotifications', context: context);

  @override
  ObservableList<NotificationItemModel> get newNotifications {
    _$newNotificationsAtom.reportRead();
    return super.newNotifications;
  }

  @override
  set newNotifications(ObservableList<NotificationItemModel> value) {
    _$newNotificationsAtom.reportWrite(value, super.newNotifications, () {
      super.newNotifications = value;
    });
  }

  late final _$notificationAtom =
      Atom(name: 'NotificationStoreBase.notification', context: context);

  @override
  ObservableList<NotificationItemModel> get notification {
    _$notificationAtom.reportRead();
    return super.notification;
  }

  @override
  set notification(ObservableList<NotificationItemModel> value) {
    _$notificationAtom.reportWrite(value, super.notification, () {
      super.notification = value;
    });
  }

  late final _$notifiDemoAtom =
      Atom(name: 'NotificationStoreBase.notifiDemo', context: context);

  @override
  ObservableList<NotificationItemModel> get notifiDemo {
    _$notifiDemoAtom.reportRead();
    return super.notifiDemo;
  }

  @override
  set notifiDemo(ObservableList<NotificationItemModel> value) {
    _$notifiDemoAtom.reportWrite(value, super.notifiDemo, () {
      super.notifiDemo = value;
    });
  }

  late final _$notifiTodayAtom =
      Atom(name: 'NotificationStoreBase.notifiToday', context: context);

  @override
  ObservableList<NotificationItemModel> get notifiToday {
    _$notifiTodayAtom.reportRead();
    return super.notifiToday;
  }

  @override
  set notifiToday(ObservableList<NotificationItemModel> value) {
    _$notifiTodayAtom.reportWrite(value, super.notifiToday, () {
      super.notifiToday = value;
    });
  }

  late final _$notifiYesterdayAtom =
      Atom(name: 'NotificationStoreBase.notifiYesterday', context: context);

  @override
  ObservableList<NotificationItemModel> get notifiYesterday {
    _$notifiYesterdayAtom.reportRead();
    return super.notifiYesterday;
  }

  @override
  set notifiYesterday(ObservableList<NotificationItemModel> value) {
    _$notifiYesterdayAtom.reportWrite(value, super.notifiYesterday, () {
      super.notifiYesterday = value;
    });
  }

  late final _$notifiOtherAtom =
      Atom(name: 'NotificationStoreBase.notifiOther', context: context);

  @override
  ObservableList<NotificationItemModel> get notifiOther {
    _$notifiOtherAtom.reportRead();
    return super.notifiOther;
  }

  @override
  set notifiOther(ObservableList<NotificationItemModel> value) {
    _$notifiOtherAtom.reportWrite(value, super.notifiOther, () {
      super.notifiOther = value;
    });
  }

  late final _$searchTextAtom =
      Atom(name: 'NotificationStoreBase.searchText', context: context);

  @override
  String get searchText {
    _$searchTextAtom.reportRead();
    return super.searchText;
  }

  @override
  set searchText(String value) {
    _$searchTextAtom.reportWrite(value, super.searchText, () {
      super.searchText = value;
    });
  }

  late final _$isLoginAtom =
      Atom(name: 'NotificationStoreBase.isLogin', context: context);

  @override
  UserStatus get isLogin {
    _$isLoginAtom.reportRead();
    return super.isLogin;
  }

  @override
  set isLogin(UserStatus value) {
    _$isLoginAtom.reportWrite(value, super.isLogin, () {
      super.isLogin = value;
    });
  }

  late final _$initDataAsyncAction =
      AsyncAction('NotificationStoreBase.initData', context: context);

  @override
  Future<void> initData() {
    return _$initDataAsyncAction.run(() => super.initData());
  }

  late final _$getUserNotificationsAsyncAction = AsyncAction(
      'NotificationStoreBase.getUserNotifications',
      context: context);

  @override
  Future<void> getUserNotifications() {
    return _$getUserNotificationsAsyncAction
        .run(() => super.getUserNotifications());
  }

  late final _$loadMoreAsyncAction =
      AsyncAction('NotificationStoreBase.loadMore', context: context);

  @override
  Future<void> loadMore() {
    return _$loadMoreAsyncAction.run(() => super.loadMore());
  }

  late final _$getOtherNotificationAsyncAction = AsyncAction(
      'NotificationStoreBase.getOtherNotification',
      context: context);

  @override
  Future<void> getOtherNotification() {
    return _$getOtherNotificationAsyncAction
        .run(() => super.getOtherNotification());
  }

  late final _$loadMoreOtherAsyncAction =
      AsyncAction('NotificationStoreBase.loadMoreOther', context: context);

  @override
  Future<void> loadMoreOther() {
    return _$loadMoreOtherAsyncAction.run(() => super.loadMoreOther());
  }

  late final _$checkNotificationAsyncAction =
      AsyncAction('NotificationStoreBase.checkNotification', context: context);

  @override
  Future<void> checkNotification() {
    return _$checkNotificationAsyncAction.run(() => super.checkNotification());
  }

  late final _$NotificationStoreBaseActionController =
      ActionController(name: 'NotificationStoreBase', context: context);

  @override
  void setPageUserNotification() {
    final _$actionInfo = _$NotificationStoreBaseActionController.startAction(
        name: 'NotificationStoreBase.setPageUserNotification');
    try {
      return super.setPageUserNotification();
    } finally {
      _$NotificationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPageOtherNotification() {
    final _$actionInfo = _$NotificationStoreBaseActionController.startAction(
        name: 'NotificationStoreBase.setPageOtherNotification');
    try {
      return super.setPageOtherNotification();
    } finally {
      _$NotificationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic onChangeSearchText(String value) {
    final _$actionInfo = _$NotificationStoreBaseActionController.startAction(
        name: 'NotificationStoreBase.onChangeSearchText');
    try {
      return super.onChangeSearchText(value);
    } finally {
      _$NotificationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsLogin(UserStatus loginStatus) {
    final _$actionInfo = _$NotificationStoreBaseActionController.startAction(
        name: 'NotificationStoreBase.setIsLogin');
    try {
      return super.setIsLogin(loginStatus);
    } finally {
      _$NotificationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeIndexPage(int index) {
    final _$actionInfo = _$NotificationStoreBaseActionController.startAction(
        name: 'NotificationStoreBase.changeIndexPage');
    try {
      return super.changeIndexPage(index);
    } finally {
      _$NotificationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void markAllAsRead() {
    final _$actionInfo = _$NotificationStoreBaseActionController.startAction(
        name: 'NotificationStoreBase.markAllAsRead');
    try {
      return super.markAllAsRead();
    } finally {
      _$NotificationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getNotification() {
    final _$actionInfo = _$NotificationStoreBaseActionController.startAction(
        name: 'NotificationStoreBase.getNotification');
    try {
      return super.getNotification();
    } finally {
      _$NotificationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loadingMyNotifications: ${loadingMyNotifications},
loadingSysNotifications: ${loadingSysNotifications},
indexPage: ${indexPage},
pageUserNotification: ${pageUserNotification},
pageOtherNotification: ${pageOtherNotification},
firstLoadMyNoti: ${firstLoadMyNoti},
firstLoadSysNoti: ${firstLoadSysNoti},
newNotifications: ${newNotifications},
notification: ${notification},
notifiDemo: ${notifiDemo},
notifiToday: ${notifiToday},
notifiYesterday: ${notifiYesterday},
notifiOther: ${notifiOther},
searchText: ${searchText},
isLogin: ${isLogin},
getPageUserNotification: ${getPageUserNotification},
getPageOtherNotification: ${getPageOtherNotification},
getCurrentIndexPage: ${getCurrentIndexPage}
    ''';
  }
}
