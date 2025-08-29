import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/models/nurse_model.dart';
import 'package:pstb/app/models/staff_model.dart';
import 'package:pstb/app/models/topic_disease_model.dart';
import 'package:pstb/services/api_exception.dart';
import 'package:pstb/infrastructure/fire_base_message.dart';
import 'package:pstb/services/profile_personal_service.dart';
import 'package:pstb/utils/sessions/session_prefs.dart';
import 'package:mobx/mobx.dart';
import 'package:pstb/app/models/user_info_model.dart' as User;
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_base_helper.dart';
import '../utils/api_url.dart';
import '../utils/routes.dart';
import '../widgets/stateless/app_snack_bar.dart';
import 'models/medical_unit/hospital_unit_model.dart';
import 'models/news_paging_model.dart';
import 'models/user_business_model.dart';
import 'modules/bottom_nav/bottom_nav_store.dart';
import 'modules/community/community_page_store.dart';
import 'modules/home/home_store.dart';
import 'modules/medical_appointment/pages/medical_package_detail/models/medical_model.dart';
import 'modules/medical_appointment/pages/select_doctor/models/doctor_model.dart';
part 'user_app_store.g.dart';

class UserAppStore = UserAppStoreBase with _$UserAppStore;

enum Language { vie, eng }

abstract class UserAppStoreBase with Store {
  final ApiBaseHelper _apiBaseHelper = Modular.get<ApiBaseHelper>();
  final _profileService = ProfilePersonalService(
      baseHelper: Modular.get<ApiBaseHelper>(),
      sharedPreferences: Modular.getAsync<SharedPreferences>());
  late BuildContext mContext;
  @observable
  User.UserInfoModel user = User.UserInfoModel();
  @observable
  bool loadingUserData = true;
  @observable
  bool visibleSelectDoctor = true;
  @observable
  double progress = 0.0;
  @observable
  bool isCodeNursing = false;
  @observable
  String? codeNursing;
  @observable
  bool? isConnectedHis;
  @observable
  DoctorPagingItem doctor = DoctorPagingItem();
  @observable
  HospitalModel hospital = HospitalModel();
  @observable
  Items item = Items();
  @observable
  PackageModel medicalPackage = PackageModel();
  @observable
  NewsPagingItem newsItem = NewsPagingItem();
  @action
  Future<void> init() async {
    codeNursing = await _profileService.getCode();
    isCodeNursing = codeNursing != null && codeNursing!.isNotEmpty;
  }

  @action
  void changeBuildContext(BuildContext newContext) {
    mContext = newContext;
  }

  String? errorMessage;
  //reload widget
  @observable
  bool reload = false;

  @action
  void setReload(bool newReload) {
    reload = newReload;
  }

  @action
  void setVisibleSelectDoctor(bool val) => visibleSelectDoctor = val;

  @action
  Future<void> updateUserInfo(User.UserInfoModel? data) async {
    if (data != null) {
      final userJson = data.toJson();
      user = User.UserInfoModel.fromJson(userJson);
      // user = data;
    }
  }

  @computed
  String get getUserName => user.fullName ?? getUserPhone;

  @computed
  String get getUserProvince => user.province ?? "";

  @computed
  String get getUserDistrict => user.district ?? "";

  @computed
  String get getUserAddress => user.address ?? "";

  @computed
  String get getUserPhone => user.phone ?? "";

  @computed
  String get getUserDob => user.dob ?? "";

  @computed
  String get getUserEmail => user.email ?? "";

  @computed
  String get getUserGender => user.gender ?? "u";

  @action
  Future<void> getAccountDetail() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.remove('name');
      prefs.remove('cccd');
      prefs.remove('birthDate');
      prefs.remove('phone');
      prefs.remove('gender');
      prefs.remove('addressDetail');
      ;
      final response = await _apiBaseHelper.get(ApiUrl.getAccountInfo);
      user = User.UserInfoModel.fromJson(response);
      loadingUserData = false;
      // getQrcodeValue(phone: user.phone!);
      print(user.gender);
      print(user.dob);
      prefs.setString('name', user.fullName ?? "");
      prefs.setString('cccd', user.personalId ?? "");
      prefs.setString('birthDate', user.dob ?? "");
      prefs.setString('phone', user.phone ?? "");
      prefs.setString('gender', user.gender ?? "");
      prefs.setString('addressDetail', user.address ?? "");
    } on NetworkException {
      rethrow;
    } catch (e) {
      await logOut();
      loadingUserData = false;
      rethrow;
    }
  }

  @action
  Future<void> checkStatusNursing(
      {required String code, required String password}) async {
    EasyLoading.show();
    try {
      isCodeNursing =
          await _profileService.checkStatusCode(code: code, password: password);
      if (isCodeNursing) {
        _profileService.saveCodeNursing(code: code);
        _profileService.savePasswordNursing(code: password);
        codeNursing = code;
        isConnectedHis = true;
      } else {
        isCodeNursing = false;
        isConnectedHis = false;
        EasyLoading.dismiss();
      }
    } on AppException catch (e) {
      errorMessage = e.toString();
      EasyLoading.dismiss();
    }
    EasyLoading.dismiss();
  }

  @action
  Future<void> disconnectHIS() async {
    EasyLoading.show();
    await _profileService.removeCodeNursing();
    isCodeNursing = false;
    EasyLoading.dismiss();
  }

  @action
  Future<void> logOut() async {
    EasyLoading.show();
    await SessionPrefs.signedOut();
    await SessionPrefs.isStaff(false);
    ApiBaseHelper.removeHeader();
    FireBaseMessageSrv.instance.disable();
    await FirebaseAuth.instance.signOut();
    await _profileService.removeCodeNursing();
    isCodeNursing = false;
    EasyLoading.dismiss();
  }

  @action
  Future<void> deleteAccount() async {
    try {
      await getAccountDetail();
      final id = user.id;
      if (id != null) {
        final response =
            await _apiBaseHelper.delete(ApiUrl.deleteAccount + id, null);

        if (response == true) {
          // OTP đúng, xử lý tiếp
          EasyLoading.dismiss();
          AppSnackBar.show(
              mContext, AppSnackBarType.Success, "Xoá tài khoản thành công");
          logOut();
        } else {
          EasyLoading.dismiss();
          AppSnackBar.show(
              mContext, AppSnackBarType.Error, "Xoá tài khoản thất bại");
        }
      } else {
        AppSnackBar.show(mContext, AppSnackBarType.Error, "Lỗi id tài khoản");
      }

      // getQrcodeValue(phone: user.phone!);
    } on NetworkException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
