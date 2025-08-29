import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:pstb/app/models/notification_model.dart';
import 'package:pstb/utils/sessions/session_prefs.dart';
import 'package:mobx/mobx.dart';
import 'package:pstb/services/api_base_helper.dart';
import 'package:pstb/utils/main.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

part 'notification_store.g.dart';

class NotificationStore = NotificationStoreBase with _$NotificationStore;

abstract class NotificationStoreBase with Store {
  final ApiBaseHelper _apiBaseHelper = Modular.get<ApiBaseHelper>();
  final PageController pageController = PageController(initialPage: 0);

  List<NotificationItemModel> notiList = [
    NotificationItemModel(
      id: 1,
      title: 'Đặt lịch khám thành công',
      created: "09/08/2025 08:30",
    ),
    NotificationItemModel(
      id: 2,
      title: 'Có kết quả xét nghiệm mới',
      created: '08/08/2025 16:20',
    ),
    NotificationItemModel(
      id: 3,
      title: 'Nhắc lịch tái khám',
      created: '07/08/2025 09:00',
    ),
    NotificationItemModel(
      id: 4,
      title: 'Đơn thuốc đã sẵn sàng',
      created: "06/08/2025 14:15",
    ),
    NotificationItemModel(
      id: 5,
      title: 'Thông báo từ bác sĩ',
      created: '05/08/2025 10:45',
    ),
  ];

  @observable
  bool loadingMyNotifications = false;

  @observable
  bool loadingSysNotifications = false;

  @observable
  int indexPage = 0;

  @computed
  int get getPageUserNotification => pageUserNotification;

  @computed
  int get getPageOtherNotification => pageOtherNotification;

  @observable
  int pageUserNotification = 0;

  @observable
  int pageOtherNotification = 0;

  @observable
  bool firstLoadMyNoti = true;

  @observable
  bool firstLoadSysNoti = true;

  String urlPdfFile = "";

  @action
  void setPageUserNotification() {
    pageUserNotification++;
  }

  @action
  void setPageOtherNotification() {
    pageOtherNotification++;
  }

  @action
  Future<void> initData() async {}

  @observable
  ObservableList<NotificationItemModel> newNotifications =
      ObservableList<NotificationItemModel>.of([]);

  @observable
  ObservableList<NotificationItemModel> notification =
      ObservableList<NotificationItemModel>.of([]);

  @observable
  ObservableList<NotificationItemModel> notifiDemo =
      ObservableList<NotificationItemModel>.of([]);

  @observable
  ObservableList<NotificationItemModel> notifiToday =
      ObservableList<NotificationItemModel>.of([]);

  @observable
  ObservableList<NotificationItemModel> notifiYesterday =
      ObservableList<NotificationItemModel>.of([]);

  @observable
  ObservableList<NotificationItemModel> notifiOther =
      ObservableList<NotificationItemModel>.of([]);

  @action
  Future<void> getUserNotifications() async {
    loadingMyNotifications = true;
    newNotifications = ObservableList<NotificationItemModel>.of([]);
    pageUserNotification = 0;
    EasyLoading.show();
    try {
      final response = await _apiBaseHelper.get(ApiUrl.notifications,
          {'pageIndex': pageUserNotification, 'pageSize': '10'});

      final dataResponse = ResponseNotification.fromJson(response);

      for (var item in dataResponse.items) {
        if (item.metaData != null) {
          item.urlPdfFile = item.metaData!
              .replaceAll("{", "")
              .replaceAll("}", "")
              .replaceAll("\"", "")
              .split("link:")[1];
        }
        //newNotifications.add(item);
        newNotifications.addAll(notiList);
      }
      newNotifications.addAll(notiList);
      pageUserNotification++;
    } catch (e) {
      debugPrint(e.toString());
    }
    firstLoadMyNoti = false;
    loadingMyNotifications = false;
    EasyLoading.dismiss();
  }

  @action
  Future<void> loadMore() async {
    if (pageUserNotification == 0 || loadingMyNotifications) return;
    loadingMyNotifications = true;
    try {
      final response = await _apiBaseHelper.get(ApiUrl.notifications,
          {'pageIndex': pageUserNotification, 'pageSize': '10'});
      final dataResponse = ResponseNotification.fromJson(response);
      for (var item in dataResponse.items) {
        if (item.metaData != null) {
          item.urlPdfFile = item.metaData!
              .replaceAll("{", "")
              .replaceAll("}", "")
              .replaceAll("\"", "")
              .split("link:")[1];
        }
        newNotifications.add(item);
      }
      pageUserNotification++;
    } catch (e) {
      debugPrint(e.toString());
      // AppSnackBar.show(
      //   context,
      //   AppSnackBarType.Error,
      //   l10n(context)!.wrong_when_try!,
      // );
    }
    loadingMyNotifications = false;
  }

  @action
  Future<void> getOtherNotification() async {
    loadingMyNotifications = true;
    EasyLoading.show();
    notification = ObservableList<NotificationItemModel>.of([]);
    pageOtherNotification = 0;
    try {
      final response = await _apiBaseHelper.get(ApiUrl.systemNotifications,
          {'pageIndex': pageOtherNotification, 'pageSize': '10'});
      final dataResponse = ResponseNotification.fromJson(response);
      for (var item in dataResponse.items) {
        notification.add(item);
      }
      pageOtherNotification++;
    } catch (e) {
      debugPrint(e.toString());
      // debugPrint.show(
      //   context,
      //   AppSnackBarType.Error,
      //   l10n(context)!.wrong_when_try!,
      // );
    }
    firstLoadSysNoti = false;
    loadingMyNotifications = false;
    EasyLoading.dismiss();
  }

  @action
  Future<void> loadMoreOther() async {
    debugPrint('load More $pageOtherNotification');
    if (pageOtherNotification == 0 || loadingSysNotifications) return;
    loadingSysNotifications = true;
    try {
      final response = await _apiBaseHelper.get(ApiUrl.systemNotifications,
          {'pageIndex': pageOtherNotification, 'pageSize': '10'});
      final dataResponse = ResponseNotification.fromJson(response);
      for (var item in dataResponse.items) {
        notification.add(item);
      }
      debugPrint(notification.length.toString());
      pageOtherNotification++;
    } catch (e) {
      debugPrint(e.toString());
      // AppSnackBar.show(
      //   context,
      //   AppSnackBarType.Error,
      //   l10n(context)!.wrong_when_try!,
      // );
    }
    loadingSysNotifications = false;
  }

  @observable
  String searchText = '';

  @action
  onChangeSearchText(String value) {
    searchText = value;
  }

  // @computed
  // List<NotificationSummary> get notificationWillShow {
  //   // if (searchText != '') {
  //   //   List<NotificationSummary> resultSearch = List<NotificationSummary>.of([]);
  //   //   String valueDiacritics = removeDiacritics(searchText).toUpperCase();
  //   //   notification.forEach((element) {
  //   //     if (removeDiacritics(element.content ?? '')
  //   //         .toUpperCase()
  //   //         .contains(valueDiacritics)) {
  //   //       resultSearch.add(element);
  //   //     }
  //   //   });
  //   //   return resultSearch;
  //   // } else
  //   //   return notification;
  //   return false;
  // }

  @observable
  UserStatus isLogin = UserStatus.Checking;

  @action
  void setIsLogin(UserStatus loginStatus) => isLogin = loginStatus;

  @action
  void changeIndexPage(int index) {
    indexPage = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInToLinear,
    );
  }

  @computed
  int get getCurrentIndexPage => indexPage;

  TextStyle getStyleByIndex(bool bool) {
    if (bool) {
      return Styles.subtitleSmallest.copyWith(
        color: AppColors.background,
      );
    } else {
      return Styles.subtitleSmallest.copyWith(
        color: AppColors.primary,
      );
    }
  }

  @action
  void markAllAsRead() {
    for (var item in notifiToday) {
      item.mark();
    }
    for (var item in notifiYesterday) {
      item.mark();
    }
    for (var item in notifiOther) {
      item.mark();
    }
  }

  @action
  void getNotification() {
    notifiDemo.clear();
    notifiToday.clear();
    notifiYesterday.clear();
    notifiOther.clear();

    notifiDemo.addAll(notification);

    final DateFormat dateFormat = DateFormat("dd/MM/yyyy hh:mm");
    final DateTime today = DateTime.now();
    final DateTime yesterday = today.subtract(const Duration(days: 1));

    for (final noti in notifiDemo) {
      final createdString = noti.created?.toString();

      if (createdString == null || createdString.isEmpty) {
        // Nếu không có ngày tạo => xếp vào Other
        notifiOther.add(noti);
        continue;
      }

      DateTime? createdDateTime;
      try {
        createdDateTime = dateFormat.parseStrict(createdString);
      } catch (e) {
        // Nếu lỗi định dạng ngày => cũng xếp vào Other
        notifiOther.add(noti);
        continue;
      }

      if (_isSameDay(createdDateTime, today)) {
        notifiToday.add(noti);
      } else if (_isSameDay(createdDateTime, yesterday)) {
        notifiYesterday.add(noti);
      } else {
        notifiOther.add(noti);
      }
    }
  }

  bool _isSameDay(DateTime d1, DateTime d2) {
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }

  @action
  Future<void> checkNotification() async {
    final id = await SessionPrefs.getMedicalUnitId();
    for (var element in notifiDemo) {
      if (id == element.id) {
        element.status = true;
      }
    }
  }
}
