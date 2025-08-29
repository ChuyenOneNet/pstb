import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/models/paging_model.dart';
import 'package:pstb/services/api_exception.dart';
import 'package:mobx/mobx.dart';
import 'package:pstb/app/models/booking_list_model.dart';
import 'package:pstb/services/api_base_helper.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';
import 'package:diacritic/diacritic.dart';

part 'schedule_store.g.dart';

class ScheduleStore = _ScheduleStoreBase with _$ScheduleStore;

abstract class _ScheduleStoreBase with Store {
  final ApiBaseHelper _apiBaseHelper = Modular.get<ApiBaseHelper>();
  late BuildContext mContext;
  @observable
  int page = 0;

  @observable
  String status = '';

  @observable
  var allBooking = ObservableList<BookingItem>.of([]);

  @observable
  String searchText = '';

  @observable
  bool isLoadMoreComplete = true;

  @observable
  bool isLoadingMore = false;

  @observable
  int pageIndexUpcoming = 0;

  @observable
  int pageIndexComplete = 0;

  @action
  onChangeStatus(String value) {
    status = value;
  }

  @action
  onChangeSearchText(String value) {
    searchText = value;
  }

  @computed
  bool get loading => isLoadingMore;

  @computed
  ObservableList<BookingItem> get getSearchUpComing {
    ObservableList<BookingItem> resultSearch =
        ObservableList<BookingItem>.of([]);
    String valueDiacritics = removeDiacritics(searchText).toUpperCase();
    for (var element in upcoming) {
      if (removeDiacritics(element.packageName ?? '')
          .toUpperCase()
          .contains(valueDiacritics)) {
        resultSearch.add(element);
      }
    }
    return resultSearch;
  }

  @computed
  ObservableList<BookingItem> get getSearchCompleted {
    ObservableList<BookingItem> resultSearch =
        ObservableList<BookingItem>.of([]);
    String valueDiacritics = removeDiacritics(searchText).toUpperCase();
    for (var element in completed) {
      if (removeDiacritics(element.packageName ?? '')
          .toUpperCase()
          .contains(valueDiacritics)) {
        resultSearch.add(element);
      }
    }
    return resultSearch;
  }

  @action
  void onPageChange(int current) {
    searchText = '';
    page = current;
  }

  @action
  void navigateToDetail(
      {required bool completed, required dynamic maHoSo, required int id}) {
    Modular.to.pushNamed(AppRoutes.scheduleDetail, arguments: {
      "isCompleted": completed,
      "mahoso": maHoSo,
      "id": id,
    }).then((_) => {getAllBooking()});
  }

  @observable
  ObservableList<BookingItem> completed = ObservableList<BookingItem>.of([]);

  @observable
  ObservableList<BookingItem> upcoming = ObservableList<BookingItem>.of([]);

  @action
  void onCancel(int id) {
    var booking = upcoming.where((element) => element.id == id).first;
    upcoming.remove(booking);
    booking.status = 3;
    completed.add(booking);
  }

  @action
  Future<void> getAllBooking() async {
    EasyLoading.show();
    pageIndexUpcoming = 0;
    pageIndexComplete = 0;
    isLoadingMore = true;
    isLoadMoreComplete = true;

    /// [get complete]
    try {
      final response = await _apiBaseHelper.get(ApiUrl.userAppointment, {
        "status": 3,
      });
      final paging = Paging<BookingItem>.fromJson(
          response, (e) => BookingItem.fromJson(e));
      if (paging.items != null) {
        completed.clear();
        completed.addAll(paging.items!.map((e) => e));
        completed
          ..forEach((element) {})
          ..removeWhere((element) => element.timeSeeDoctor == null)
          ..sort((a, b) => DateTime.parse(b.timeSeeDoctor.toString())
              .compareTo(DateTime.parse(a.timeSeeDoctor.toString())));
      }
    } on AppException catch (e) {
      AppSnackBar.show(mContext, AppSnackBarType.Error, e.toString());
    } catch (e) {
      AppSnackBar.show(
          mContext, AppSnackBarType.Error, l10n(mContext)!.wrong_when_try);
    }

    /// [get booking upcoming]
    try {
      final response = await _apiBaseHelper.get(ApiUrl.userAppointment, {
        "status": 1,
      });
      final paging = Paging<BookingItem>.fromJson(
          response, (e) => BookingItem.fromJson(e));
      pageIndexUpcoming = paging.pageIndex! + 1;
      if (paging.items != null) {
        upcoming.clear();
        upcoming.addAll(paging.items!.map((e) => e));
        upcoming
          ..forEach((element) {})
          ..removeWhere((element) => element.timeSeeDoctor == null)
          ..sort((a, b) => DateTime.parse(b.timeSeeDoctor.toString())
              .compareTo(DateTime.parse(a.timeSeeDoctor.toString())));
      }
    } on AppException catch (e) {
      AppSnackBar.show(mContext, AppSnackBarType.Error, e.getMessage());
    } catch (e) {
      AppSnackBar.show(
          mContext, AppSnackBarType.Error, l10n(mContext)!.wrong_when_try);
    }
    isLoadingMore = false;
    isLoadMoreComplete = false;
    EasyLoading.dismiss();
  }

  @action
  Future<void> loadMoreUpcoming() async {
    //ToDo chặn loadmore nhiều lần
    if (isLoadingMore) return;
    isLoadingMore = true;
    try {
      final response = await _apiBaseHelper.get(ApiUrl.userAppointment,
          {"status": 1, "pageIndex": pageIndexUpcoming});
      final paging = Paging<BookingItem>.fromJson(
          response, (e) => BookingItem.fromJson(e));
      if (paging.items == null || paging.items!.isEmpty) return;
      pageIndexUpcoming = paging.pageIndex! + 1;
      upcoming.addAll(paging.items!.map((e) => e));
      upcoming
        ..forEach((element) {})
        ..removeWhere((element) => element.timeSeeDoctor == null)
        ..sort((a, b) => DateTime.parse(b.timeSeeDoctor.toString())
            .compareTo(DateTime.parse(a.timeSeeDoctor.toString())));
    } on AppException catch (e) {
      AppSnackBar.show(mContext, AppSnackBarType.Error, e.toString());
    } catch (e) {
      AppSnackBar.show(
          mContext, AppSnackBarType.Error, l10n(mContext)!.wrong_when_try);
    }
    isLoadingMore = false;
  }

  @action
  Future<void> loadMoreComplete() async {
    if (isLoadMoreComplete) return;
    isLoadMoreComplete = true;
    try {
      final response = await _apiBaseHelper.get(ApiUrl.userAppointment,
          {"status": 3, "pageIndex": pageIndexComplete});
      final paging = Paging<BookingItem>.fromJson(
          response, (e) => BookingItem.fromJson(e));
      if (paging.items == null || paging.items!.isEmpty) return;
      pageIndexComplete = paging.pageIndex! + 1;
      completed.addAll(paging.items!.map((e) => e));
      completed
        ..forEach((element) {})
        ..removeWhere((element) => element.timeSeeDoctor == null)
        ..sort((a, b) => DateTime.parse(b.timeSeeDoctor.toString())
            .compareTo(DateTime.parse(a.timeSeeDoctor.toString())));
    } on AppException catch (e) {
      AppSnackBar.show(mContext, AppSnackBarType.Error, e.toString());
    } catch (e) {
      AppSnackBar.show(
          mContext, AppSnackBarType.Error, l10n(mContext)!.wrong_when_try);
    }
    isLoadMoreComplete = false;
  }

  @action
  Future<void> refreshUpcoming() async {
    pageIndexUpcoming = 0;
    upcoming.clear();
    try {
      final response = await _apiBaseHelper.get(ApiUrl.userAppointment,
          {"status": 1, "pageIndex": pageIndexUpcoming});
      final paging = Paging<BookingItem>.fromJson(
          response, (e) => BookingItem.fromJson(e));
      if (paging.items == null || paging.items!.isEmpty) return;
      pageIndexUpcoming = paging.pageIndex! + 1;
      upcoming.addAll(paging.items!.map((e) => e));
      upcoming
        ..forEach((element) {})
        ..removeWhere((element) => element.timeSeeDoctor == null)
        ..sort((a, b) => DateTime.parse(b.timeSeeDoctor.toString())
            .compareTo(DateTime.parse(a.timeSeeDoctor.toString())));
    } on AppException catch (e) {
      AppSnackBar.show(mContext, AppSnackBarType.Error, e.toString());
    } catch (e) {
      AppSnackBar.show(
          mContext, AppSnackBarType.Error, l10n(mContext)!.wrong_when_try);
    }
  }

  @action
  Future<void> refreshCompleted() async {
    pageIndexComplete = 0;
    completed.clear();
    try {
      final response = await _apiBaseHelper.get(ApiUrl.userAppointment,
          {"status": 3, "pageIndex": pageIndexComplete});
      final paging = Paging<BookingItem>.fromJson(
          response, (e) => BookingItem.fromJson(e));
      if (paging.items == null || paging.items!.isEmpty) return;
      pageIndexComplete = paging.pageIndex! + 1;
      completed.addAll(paging.items!.map((e) => e));
      completed
        ..forEach((element) {})
        ..removeWhere((element) => element.timeSeeDoctor == null)
        ..sort((a, b) => DateTime.parse(b.timeSeeDoctor.toString())
            .compareTo(DateTime.parse(a.timeSeeDoctor.toString())));
    } on AppException catch (e) {
      AppSnackBar.show(mContext, AppSnackBarType.Error, e.toString());
    } catch (e) {
      AppSnackBar.show(
          mContext, AppSnackBarType.Error, l10n(mContext)!.wrong_when_try);
    }
  }

  @observable
  UserStatus isLogin = UserStatus.Checking;

  @action
  void setIsLogin(UserStatus loginStatus) => isLogin = loginStatus;

  @action
  void setContext(BuildContext newContext) => mContext = newContext;
}
