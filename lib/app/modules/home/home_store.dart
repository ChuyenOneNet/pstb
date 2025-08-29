import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/medical_appointment/pages/select_doctor/models/doctor_model.dart';
import 'package:intl/intl.dart';
import 'package:pstb/Keys.dart';
import 'package:pstb/app/models/nurse_model.dart';
import 'package:pstb/app/models/package_group_model.dart';
import 'package:pstb/app/models/staff_model.dart';
import 'package:pstb/app/user_app_store.dart';
import 'package:pstb/services/api_exception.dart';
import 'package:pstb/services/profile_personal_service.dart';
import 'package:pstb/utils/sessions/session_prefs.dart';
import 'package:mobx/mobx.dart';
import 'package:pstb/app/models/offer_model.dart';
import 'package:pstb/app/models/booking_list_model.dart';
import 'package:pstb/app/models/news_paging_model.dart';
import 'package:pstb/app/models/promotion_news_model.dart';
import 'package:pstb/services/api_base_helper.dart';
import 'package:pstb/utils/main.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/helpers/config_helper.dart';
import '../../../widgets/stateless/app_snack_bar.dart';
import '../../models/paging_model.dart';
import '../../models/token_model.dart';
import '../../app_store.dart';
import '../../models/login_model.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../models/token_model_v2.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  late final ApiBaseHelper _apiBaseHelper = Modular.get<ApiBaseHelper>();
  final UserAppStore _userAppStore = Modular.get<UserAppStore>();
  final AppStore _appStore = Modular.get<AppStore>();
  AuthenticationResult? _authenticationResultLocal;
  final _profileService = ProfilePersonalService(
      baseHelper: Modular.get<ApiBaseHelper>(),
      sharedPreferences: Modular.getAsync<SharedPreferences>());
  late BuildContext mContext;

  @observable
  int totalComingBooking = 0;

  @observable
  String firstTimeBooking = '';

  @observable
  int counter = 0;
  @observable
  String password = '';
  @observable
  String phoneNumberCache = '';
  @observable
  bool isLogin = false;
  @observable
  bool isStaff = false;
  @observable
  bool isActive = false;
  @observable
  bool loadingUser = true;
  @observable
  int slideNo = 0;
  @observable
  int indexPromotion = 0;
  late final SharedPreferences prefs;
  @observable
  int? idUnit = 0;
  @observable
  String? avatarUnit = '';
  @observable
  String? nameUnit = '';
  @observable
  String? addressUnit = '';
  @observable
  bool isActivePaper = false;
  @observable
  bool isActiveInputHealthCare = false;

  // @observable
  // List<Bookmark> listBookmark = ObservableList<Bookmark>.of([]);
  @observable
  List<PackageGroupModel> listPackageGroup =
      ObservableList<PackageGroupModel>.of([]);

  @computed
  int get slide => slideNo;

  @action
  Future<void> increment() async {
    counter = counter + 1;
  }

  @action
  Future<void> onError(BuildContext context) async {
    AppSnackBar.show(context, AppSnackBarType.Error, 'Địa chỉ chưa chính xác');
  }

  @action
  setLogin(bool signed) {
    isLogin = signed;
  }

  @action
  void changeBuildContext(BuildContext newContext) {
    mContext = newContext;
  }

  @action
  Future<void> getInfoUnit() async {
    avatarUnit = await SessionPrefs.getAvatarUnit();
    nameUnit = await SessionPrefs.getNameUnit();
    addressUnit = await SessionPrefs.getAddressUnit();
  }

  @action
  Future<void> getPhoneNumberCache() async {
    final authenticationRaw = await SessionPrefs.getProfileData();
    if (authenticationRaw != null) {
      _authenticationResultLocal =
          AuthenticationResult.fromRawJson(authenticationRaw);
      phoneNumberCache = _authenticationResultLocal?.user?.phone ?? '';
    }
  }

  Future<bool> activeFingerPrint() async {
    getPhoneNumberCache();

    try {
      final response = await _apiBaseHelper.post(
        ApiUrl.token,
        LoginModel(
                username: phoneNumberCache,
                password: password,
                fireBaseToken: _appStore.fireBaseToken)
            .toRawJson(),
      );
      return response != null;
    } catch (e) {
      return false;
    }
  }
  // Future<bool> activeFingerPrint() async {
  //   getPhoneNumberCache();
  //
  //   try {
  //     final response = await _apiBaseHelper.post(
  //       ApiUrl.tokenV2,
  //       LoginModel(
  //               username: phoneNumberCache,
  //               password: password,
  //               fireBaseToken: _appStore.fireBaseToken)
  //           .toRawJson(),
  //     );
  //     return response != null;
  //   } catch (e) {
  //     return false;
  //   }
  // }

  @action
  void getPass(String data) {
    password = data;
  }

  @action
  void navigateTo(String route, dynamic args) {
    Modular.to.pushNamed(route, arguments: args);
  }

  @action
  void pushToMyQrCode() {
    Modular.to.pushNamed(AppRoutes.myQRCode);
  }

  @action
  void changeNews(indexOfPage) {
    slideNo = indexOfPage;
  }

  @action
  void changePromotion(indexOfPage) {
    indexPromotion = indexOfPage;
  }

  @observable
  var homeSlider = ObservableList<PromotionNewsModel>.of([]);

  @observable
  bool loadingBanner = true;

  @computed
  List<PromotionNewsModel> get homeSliderData => homeSlider;

  StreamSubscription? connection;
  @observable
  bool isOffline = false;
  @observable
  Map<Permission, PermissionStatus> statuses = {};

  @observable
  int medicalUnitId = 0;
  @observable
  String uriAboutPage = "";
  @observable
  String fanPage = "";
  @observable
  bool enablePromotion = false;

  //Booking time
  @observable
  String timeStart = "";
  @observable
  String timeEnd = "";
  @observable
  ObservableList<DoctorPagingItem> listProminentDoctor =
      ObservableList<DoctorPagingItem>.of([]);

  @action
  Future<void> checkConnection() async {
    connection = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> results) {
      // whenevery connection status is changed.
      if (results == ConnectivityResult.none) {
        //there is no any connection
        isOffline = true;
      } else if (results == ConnectivityResult.mobile) {
        //connection is mobile data network
        isOffline = false;
      } else if (results == ConnectivityResult.wifi) {
        //connection is from wifi
        isOffline = false;
      } else if (results == ConnectivityResult.ethernet) {
        //connection is from wired connection
        isOffline = false;
      } else if (results == ConnectivityResult.bluetooth) {
        //connection is from bluetooth threatening
        isOffline = false;
      }
    });
  }

  @action
  Future<void> initHomeStore() async {
    _requestPermissions();
    await _checkLogin();
    await checkRole();
    await loadConfigMedicalUnit();
    getBanner();
    if (enablePromotion) {
      getPromotionNews();
    }
    getNews(page: 0);
    getPacketGroup();
    getListProminentDoctor();
  }

  Future<void> _requestPermissions() async {
    statuses = await [
      //Permission.camera,
      //Permission.microphone,
      //Permission.storage,
      Permission.notification
    ].request();
    print('$statuses');
  }

  Future<void> _checkLogin() async {
    final isSignedIn = await SessionPrefs.isSignedIn();
    if (isSignedIn) {
      try {
        await _userAppStore.getAccountDetail();
        await getBookings();
        setLogin(true);
      } on NetworkException {
        rethrow;
      } catch (e) {
        return;
        // setLogin(false);
        // await _userAppStore.logOut();
      }
    } else {
      setLogin(false);
    }
    loadingUser = false;
  }

  @action
  Future<void> checkRole() async {
    isStaff = await SessionPrefs.checkStaff();
  }

  @action
  Future<void> refreshToken() async {
    EasyLoading.show();
    try {
      final response = await _apiBaseHelper.post(
        ApiUrl.refreshToken,
        RefreshTokenModel(
                username: _userAppStore.user.phone ?? "",
                fireBaseToken: _appStore.fireBaseToken)
            .toRawJson(),
      );
      final authenticationResult = AuthenticationResult.fromJson(response);
      EasyLoading.dismiss();
      await _logInSuccess(authenticationResult);
    } on AppException catch (e) {
      EasyLoading.dismiss().then((value) =>
          AppSnackBar.show(mContext, AppSnackBarType.Error, e.getMessage()));
    } catch (e) {
      EasyLoading.dismiss().then((value) =>
          AppSnackBar.show(mContext, AppSnackBarType.Error, e.toString()));
    }
  }

  Future<void> _logInSuccess(AuthenticationResult tokenData) async {
    await SessionPrefs.signedIn(tokenData);
    String user = json.encode(tokenData);
    ApiBaseHelper.setHeader(user);
    final fcmToken = Platform.isIOS
        ? await FirebaseMessaging.instance.getAPNSToken()
        : await FirebaseMessaging.instance.getToken();
    _appStore.setFCMToken(fcmToken ?? "");
  }
  // @action
  // Future<void> refreshToken() async {
  //   EasyLoading.show();
  //   try {
  //     final response = await _apiBaseHelper.post(
  //       ApiUrl.refreshToken,
  //       RefreshTokenModel(
  //               username: _userAppStore.user.phone ?? "",
  //               fireBaseToken: _appStore.fireBaseToken)
  //           .toRawJson(),
  //     );
  //     final authenticationResult = AuthenticationResultV2.fromJson(response);
  //     EasyLoading.dismiss();
  //     await _logInSuccess(authenticationResult);
  //   } on AppException catch (e) {
  //     EasyLoading.dismiss().then((value) =>
  //         AppSnackBar.show(mContext, AppSnackBarType.Error, e.getMessage()));
  //   } catch (e) {
  //     EasyLoading.dismiss().then((value) =>
  //         AppSnackBar.show(mContext, AppSnackBarType.Error, e.toString()));
  //   }
  // }
  //
  // Future<void> _logInSuccess(AuthenticationResultV2 tokenData) async {
  //   await SessionPrefs.signedIn(tokenData);
  //   String user = json.encode(tokenData);
  //   ApiBaseHelper.setHeader(user);
  //   final fcmToken = Platform.isIOS
  //       ? await FirebaseMessaging.instance.getAPNSToken()
  //       : await FirebaseMessaging.instance.getToken();
  //   _appStore.setFCMToken(fcmToken ?? "");
  // }

  @action
  Future<void> loadConfigMedicalUnit() async {
    var cfgHelper = ConfigHelper.instance;
    medicalUnitId = await SessionPrefs.getMedicalUnitId() ?? 0;
    await cfgHelper.loadData(medicalUnitId);

    /// unit-config
    uriAboutPage =
        await cfgHelper.tryGetConfigValueByCode(ConfigHelper.about, '');
    fanPage = await cfgHelper.tryGetConfigValueByCode(ConfigHelper.fanPage, '');
    timeStart = await ConfigHelper.instance
        .tryGetConfigValueByCode(ConfigHelper.timeStartBooking, "09:00");
    timeEnd = await ConfigHelper.instance
        .tryGetConfigValueByCode(ConfigHelper.timeEndBooking, "17:30");
    enablePromotion = await enableOtpByCode(ConfigHelper.enablePromotion);
  }

  Future<bool> enableOtpByCode(String code) async {
    final enable = await ConfigHelper.instance.getConfigByCode(code);
    if (enable != null) {
      return enable.value == '1';
    }
    return false;
  }

  @action
  Future<void> getBanner() async {
    loadingBanner = true;
    homeSlider = ObservableList<PromotionNewsModel>.of([]);
    try {
      final response = await _apiBaseHelper.get(
        ApiUrl.promotion,
        PromotionGetModel(priorities: "4").toJson(),
      );
      var paging =
          Paging.fromJson(response, (x) => PromotionNewsModel.fromJson(x));
      for (var element in paging.items!) {
        homeSlider.add(element);
      }
      loadingBanner = false;
    } catch (e) {
      loadingBanner = false;
    }
  }

  @observable
  var healthNews = ObservableList<NewsPagingItem>.of([]);

  @observable
  bool loadingNew = true;

  @action
  Future<void> getNews({required int page}) async {
    try {
      final response = await _apiBaseHelper.get(
        ApiUrl.news,
      );
      final newsPaging = Paging<NewsPagingItem>.fromJson(
          response, (x) => NewsPagingItem.fromJson(x));
      if (page == 0) {
        healthNews = ObservableList<NewsPagingItem>.of([]);
      }
      if (newsPaging.items != null) {
        newsPaging.items?.forEach((element) {
          // if (element.id != '4' && element.id != '7' && element.id != '15')
          healthNews.add(element);
        });
      }
      loadingNew = false;
    } catch (e) {
      loadingNew = false;
    }
  }

  @action
  Future<void> getBookmarks() async {
    // try {
    //   final response = await _apiBaseHelper.get(ApiUrl.bookmarksUser);
    //
    //   final bookmarks = UserBoookmarksResponsitory.fromJson(response);
    //
    //   if (bookmarks.data!.results != null) {
    //     for (var element in bookmarks.data!.results!) {
    //       listBookmark.add(element);
    //     }
    //   }
    // } catch (e) {
    //   print(e);
    // }
  }

  @observable
  var promotionNews = ObservableList<PromotionNewsModel>.of([]);
  @observable
  bool loadingPromotion = true;

  @action
  Future<void> getPromotionNews() async {
    loadingPromotion = true;
    promotionNews.clear();
    medicalUnitId = await SessionPrefs.getMedicalUnitId() ?? 0;
    try {
      final response = await _apiBaseHelper.get(
        ApiUrl.promotion,
        {"MedicalUnitId": medicalUnitId},
      );
      final paging = Paging<PromotionNewsModel>.fromJson(
          response, (x) => PromotionNewsModel.fromJson(x));
      paging.items?.forEach((element) {
        promotionNews.add(element);
      });
    } catch (e) {
      print(e);
    }
    loadingPromotion = false;
  }

  @observable
  var bookings = ObservableList<BookingItem>.of([]);

  @observable
  bool loadingBooking = true;

  @action
  Future<void> getBookings() async {
    try {
      bookings = ObservableList<BookingItem>.of([]);
      // get new bookings.
      final response = await _apiBaseHelper
          .get(ApiUrl.userAppointment, {"status": 1, "pageSize": ''});
      final bookingPaging =
          Paging.fromJson(response, (e) => BookingItem.fromJson(e));
      final items = bookingPaging.items;
      totalComingBooking = bookingPaging.total ?? 0;
      if (items != null && items.isNotEmpty) {
        for (var element in items) {
          bookings.add(element);
        }
      }
      var pickedTime = bookings.last.timeSeeDoctor;
      if (pickedTime == null) return;
      firstTimeBooking =
          DateFormat(DateTimeFormatPattern.hh_mm_NGAY_dd_MM).format(pickedTime);
    } on AppException catch (e) {
      print(e);
      // AppSnackBar.show(context, AppSnackBarType.Error, e.toString());
    } catch (e) {
      print(e);
      // AppSnackBar.show(
      //     context, AppSnackBarType.Error, l10n(context)!.wrong_when_try);
    }
    loadingBooking = false;
  }

  @observable
  bool reload = true;

  @action
  void setReload(bool newReload) {
    reload = newReload;
  }

  void navigateToPage({required String routerName, required Object arguments}) {
    Modular.to.pushNamed(routerName, arguments: arguments.toString());
  }

  Paging<PackageGroupModel> _pagingPackage = Paging<PackageGroupModel>();

  @action
  Future<void> getPacketGroup() async {
    try {
      reload = true;
      listPackageGroup.clear();
      medicalUnitId = await SessionPrefs.getMedicalUnitId() ?? 0;
      final response = await _apiBaseHelper.get(
        ApiUrl.packageGroup,
        {"MedicalUnitId": medicalUnitId},
      );
      _pagingPackage = Paging<PackageGroupModel>.fromJson(response, (item) {
        return PackageGroupModel.fromJson(item);
      });
      if (_pagingPackage.items != null && _pagingPackage.items!.isNotEmpty) {
        for (final item in _pagingPackage.items!) {
          listPackageGroup.add(item);
        }
      }
      reload = false;
    } catch (e) {
      reload = false;
      listPackageGroup.clear();
    }
  }

  @action
  Future<void> loadMorePacketGroup() async {
    final loadMore = (_pagingPackage.total ?? 0) -
        ((_pagingPackage.pageIndex ?? 0) + 1) * (_pagingPackage.pageSize ?? 0);
    if (loadMore > 0) {
      _pagingPackage.pageIndex = _pagingPackage.pageIndex! + 1;
      final response = await _apiBaseHelper.get(
          ApiUrl.packageGroup, {'pageIndex': '${_pagingPackage.pageIndex}'});
      final paging = Paging<PackageGroupModel>.fromJson(response, (item) {
        return PackageGroupModel.fromJson(item);
      });
      if (paging.items != null && paging.items!.isNotEmpty) {
        for (final item in paging.items!) {
          listPackageGroup.add(item);
        }
      } else {
        listPackageGroup.addAll([]);
        throw 'Không có thông tin';
      }
    }
  }

  @action
  Future<void> getListProminentDoctor() async {
    try {
      EasyLoading.show();
      listProminentDoctor.clear();
      medicalUnitId = await SessionPrefs.getMedicalUnitId() ?? 0;
      final response = await _apiBaseHelper.get(
        ApiUrl.prominentDoctor,
        {"medicalUnitId": medicalUnitId},
      );
      final doctorPaging =
          Paging.fromJson(response, (e) => DoctorPagingItem.fromJson(e));
      for (var element in doctorPaging.items!) {
        listProminentDoctor.add(element);
      }
    } catch (e) {
      print(e);
    } finally {
      EasyLoading.dismiss();
    }
  }

  @action
  Future<void> getDetailProminentDoctor(int id) async {
    try {
      EasyLoading.show();
      listProminentDoctor.clear();
      medicalUnitId = await SessionPrefs.getMedicalUnitId() ?? 0;
      final response = await _apiBaseHelper.get(
        ApiUrl.prominentDoctor,
        {"medicalUnitId": medicalUnitId},
      );
      final doctorPaging =
          Paging.fromJson(response, (e) => DoctorPagingItem.fromJson(e));
      for (var element in doctorPaging.items!) {
        listProminentDoctor.add(element);
      }
    } catch (e) {
      print(e);
    } finally {
      EasyLoading.dismiss();
    }
  }
}
