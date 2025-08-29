// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ScheduleStore on _ScheduleStoreBase, Store {
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??= Computed<bool>(() => super.loading,
          name: '_ScheduleStoreBase.loading'))
      .value;
  Computed<ObservableList<BookingItem>>? _$getSearchUpComingComputed;

  @override
  ObservableList<BookingItem> get getSearchUpComing =>
      (_$getSearchUpComingComputed ??= Computed<ObservableList<BookingItem>>(
              () => super.getSearchUpComing,
              name: '_ScheduleStoreBase.getSearchUpComing'))
          .value;
  Computed<ObservableList<BookingItem>>? _$getSearchCompletedComputed;

  @override
  ObservableList<BookingItem> get getSearchCompleted =>
      (_$getSearchCompletedComputed ??= Computed<ObservableList<BookingItem>>(
              () => super.getSearchCompleted,
              name: '_ScheduleStoreBase.getSearchCompleted'))
          .value;

  late final _$pageAtom =
      Atom(name: '_ScheduleStoreBase.page', context: context);

  @override
  int get page {
    _$pageAtom.reportRead();
    return super.page;
  }

  @override
  set page(int value) {
    _$pageAtom.reportWrite(value, super.page, () {
      super.page = value;
    });
  }

  late final _$statusAtom =
      Atom(name: '_ScheduleStoreBase.status', context: context);

  @override
  String get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(String value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  late final _$allBookingAtom =
      Atom(name: '_ScheduleStoreBase.allBooking', context: context);

  @override
  ObservableList<BookingItem> get allBooking {
    _$allBookingAtom.reportRead();
    return super.allBooking;
  }

  @override
  set allBooking(ObservableList<BookingItem> value) {
    _$allBookingAtom.reportWrite(value, super.allBooking, () {
      super.allBooking = value;
    });
  }

  late final _$searchTextAtom =
      Atom(name: '_ScheduleStoreBase.searchText', context: context);

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

  late final _$isLoadMoreCompleteAtom =
      Atom(name: '_ScheduleStoreBase.isLoadMoreComplete', context: context);

  @override
  bool get isLoadMoreComplete {
    _$isLoadMoreCompleteAtom.reportRead();
    return super.isLoadMoreComplete;
  }

  @override
  set isLoadMoreComplete(bool value) {
    _$isLoadMoreCompleteAtom.reportWrite(value, super.isLoadMoreComplete, () {
      super.isLoadMoreComplete = value;
    });
  }

  late final _$isLoadingMoreAtom =
      Atom(name: '_ScheduleStoreBase.isLoadingMore', context: context);

  @override
  bool get isLoadingMore {
    _$isLoadingMoreAtom.reportRead();
    return super.isLoadingMore;
  }

  @override
  set isLoadingMore(bool value) {
    _$isLoadingMoreAtom.reportWrite(value, super.isLoadingMore, () {
      super.isLoadingMore = value;
    });
  }

  late final _$pageIndexUpcomingAtom =
      Atom(name: '_ScheduleStoreBase.pageIndexUpcoming', context: context);

  @override
  int get pageIndexUpcoming {
    _$pageIndexUpcomingAtom.reportRead();
    return super.pageIndexUpcoming;
  }

  @override
  set pageIndexUpcoming(int value) {
    _$pageIndexUpcomingAtom.reportWrite(value, super.pageIndexUpcoming, () {
      super.pageIndexUpcoming = value;
    });
  }

  late final _$pageIndexCompleteAtom =
      Atom(name: '_ScheduleStoreBase.pageIndexComplete', context: context);

  @override
  int get pageIndexComplete {
    _$pageIndexCompleteAtom.reportRead();
    return super.pageIndexComplete;
  }

  @override
  set pageIndexComplete(int value) {
    _$pageIndexCompleteAtom.reportWrite(value, super.pageIndexComplete, () {
      super.pageIndexComplete = value;
    });
  }

  late final _$completedAtom =
      Atom(name: '_ScheduleStoreBase.completed', context: context);

  @override
  ObservableList<BookingItem> get completed {
    _$completedAtom.reportRead();
    return super.completed;
  }

  @override
  set completed(ObservableList<BookingItem> value) {
    _$completedAtom.reportWrite(value, super.completed, () {
      super.completed = value;
    });
  }

  late final _$upcomingAtom =
      Atom(name: '_ScheduleStoreBase.upcoming', context: context);

  @override
  ObservableList<BookingItem> get upcoming {
    _$upcomingAtom.reportRead();
    return super.upcoming;
  }

  @override
  set upcoming(ObservableList<BookingItem> value) {
    _$upcomingAtom.reportWrite(value, super.upcoming, () {
      super.upcoming = value;
    });
  }

  late final _$isLoginAtom =
      Atom(name: '_ScheduleStoreBase.isLogin', context: context);

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

  late final _$getAllBookingAsyncAction =
      AsyncAction('_ScheduleStoreBase.getAllBooking', context: context);

  @override
  Future<void> getAllBooking() {
    return _$getAllBookingAsyncAction.run(() => super.getAllBooking());
  }

  late final _$loadMoreUpcomingAsyncAction =
      AsyncAction('_ScheduleStoreBase.loadMoreUpcoming', context: context);

  @override
  Future<void> loadMoreUpcoming() {
    return _$loadMoreUpcomingAsyncAction.run(() => super.loadMoreUpcoming());
  }

  late final _$loadMoreCompleteAsyncAction =
      AsyncAction('_ScheduleStoreBase.loadMoreComplete', context: context);

  @override
  Future<void> loadMoreComplete() {
    return _$loadMoreCompleteAsyncAction.run(() => super.loadMoreComplete());
  }

  late final _$refreshUpcomingAsyncAction =
      AsyncAction('_ScheduleStoreBase.refreshUpcoming', context: context);

  @override
  Future<void> refreshUpcoming() {
    return _$refreshUpcomingAsyncAction.run(() => super.refreshUpcoming());
  }

  late final _$refreshCompletedAsyncAction =
      AsyncAction('_ScheduleStoreBase.refreshCompleted', context: context);

  @override
  Future<void> refreshCompleted() {
    return _$refreshCompletedAsyncAction.run(() => super.refreshCompleted());
  }

  late final _$_ScheduleStoreBaseActionController =
      ActionController(name: '_ScheduleStoreBase', context: context);

  @override
  dynamic onChangeStatus(String value) {
    final _$actionInfo = _$_ScheduleStoreBaseActionController.startAction(
        name: '_ScheduleStoreBase.onChangeStatus');
    try {
      return super.onChangeStatus(value);
    } finally {
      _$_ScheduleStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic onChangeSearchText(String value) {
    final _$actionInfo = _$_ScheduleStoreBaseActionController.startAction(
        name: '_ScheduleStoreBase.onChangeSearchText');
    try {
      return super.onChangeSearchText(value);
    } finally {
      _$_ScheduleStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onPageChange(int current) {
    final _$actionInfo = _$_ScheduleStoreBaseActionController.startAction(
        name: '_ScheduleStoreBase.onPageChange');
    try {
      return super.onPageChange(current);
    } finally {
      _$_ScheduleStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void navigateToDetail(
      {required bool completed, required dynamic maHoSo, required int id}) {
    final _$actionInfo = _$_ScheduleStoreBaseActionController.startAction(
        name: '_ScheduleStoreBase.navigateToDetail');
    try {
      return super
          .navigateToDetail(completed: completed, maHoSo: maHoSo, id: id);
    } finally {
      _$_ScheduleStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onCancel(int id) {
    final _$actionInfo = _$_ScheduleStoreBaseActionController.startAction(
        name: '_ScheduleStoreBase.onCancel');
    try {
      return super.onCancel(id);
    } finally {
      _$_ScheduleStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsLogin(UserStatus loginStatus) {
    final _$actionInfo = _$_ScheduleStoreBaseActionController.startAction(
        name: '_ScheduleStoreBase.setIsLogin');
    try {
      return super.setIsLogin(loginStatus);
    } finally {
      _$_ScheduleStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setContext(BuildContext newContext) {
    final _$actionInfo = _$_ScheduleStoreBaseActionController.startAction(
        name: '_ScheduleStoreBase.setContext');
    try {
      return super.setContext(newContext);
    } finally {
      _$_ScheduleStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
page: ${page},
status: ${status},
allBooking: ${allBooking},
searchText: ${searchText},
isLoadMoreComplete: ${isLoadMoreComplete},
isLoadingMore: ${isLoadingMore},
pageIndexUpcoming: ${pageIndexUpcoming},
pageIndexComplete: ${pageIndexComplete},
completed: ${completed},
upcoming: ${upcoming},
isLogin: ${isLogin},
loading: ${loading},
getSearchUpComing: ${getSearchUpComing},
getSearchCompleted: ${getSearchCompleted}
    ''';
  }
}
