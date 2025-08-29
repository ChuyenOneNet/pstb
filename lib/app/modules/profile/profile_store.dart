import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:pstb/app/user_app_store.dart';
import 'package:pstb/utils/gender_utils.dart';
import 'package:pstb/utils/time_util.dart';
import 'package:pstb/widgets/stateless/app_snack_bar.dart';
import 'package:mobx/mobx.dart';
import 'package:pstb/repository/insurance/insurance_model.dart' as Insurance;
import 'package:pstb/app/models/user_info_model.dart' as User;
import 'package:pstb/services/api_base_helper.dart';
import 'package:pstb/utils/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app_store.dart';

part 'profile_store.g.dart';

class ProfileStore = _ProfileStoreBase with _$ProfileStore;

abstract class _ProfileStoreBase with Store {
  final ApiBaseHelper _apiBaseHelper = Modular.get<ApiBaseHelper>();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final AppStore _appStore = Modular.get<AppStore>();
  final _userAppStore = Modular.get<UserAppStore>();
  late BuildContext mContext;

  @observable
  UserStatus isLogin = UserStatus.Checking;

  XFile? fileImg;
  @observable
  String? avatar;
  @observable
  String? localAvatarPath;
  @observable
  String isDataQrCode = '';
  @observable
  bool isGenerateQRCode = false;

  @action
  void onChangeBuildContext(BuildContext buildContext) {
    mContext = buildContext;
  }

  @action
  void setIsLogin(UserStatus loginStatus) => isLogin = loginStatus;

  @action
  void setLocalAvatarPath(String? path) => localAvatarPath = path;

  @action
  Future<void> rateApp() async {
    final InAppReview inAppReview = InAppReview.instance;
    final SharedPreferences prefs = await _prefs;

    if (await inAppReview.isAvailable()) {
      inAppReview.openStoreListing(appStoreId: "1622549993").whenComplete(
          () => {prefs.setBool('rated', false), _appStore.rateApp = false});
    }
  }

  @observable
  bool loadingInsurance = true;

  @observable
  Insurance.InsuranceModel insurance = Insurance.InsuranceModel();

  @computed
  List<Insurance.Data>? get insuranceData {
    if (insurance.code == 200) {
      return [insurance.data!];
    }
    return [];
  }

  @action
  Future<void> getInsurance() async {
    loadingInsurance = true;
    // try {
    //   final response = await _apiBaseHelper.get(ApiUrl.insurance);
    //   insurance = Insurance.InsuranceModel.fromJson(response);
    // } catch (e) {
    //   print(e);
    // }
    loadingInsurance = false;
  }

  @observable
  Insurance.Data? insuranceSelected;

  @action
  void setSelectedInsurance(Insurance.Data? value) {
    if (value != null) {
      insuranceSelected = value;
    } else {
      insuranceSelected = null;
    }
  }

  @action
  void onPushQRCode() {
    isGenerateQRCode = _userAppStore.getUserName.isNotEmpty &&
        _userAppStore.getUserDob.isNotEmpty &&
        _userAppStore.getUserPhone.isNotEmpty;
    if (isGenerateQRCode) {
      isDataQrCode = '''
              Họ và tên: ${_userAppStore.getUserName},
              Giới tính: ${GenderUtils.parseGenderString(_userAppStore.getUserGender)},
              Số điện thoại: ${_userAppStore.getUserPhone},
              Sinh nhật: ${_userAppStore.getUserDob},
            ''';
      return;
    }
  }

  @action
  Future onChangeAvatar(XFile file) async {
    await EasyLoading.show();
    fileImg = file;
    if (fileImg != null) {
      try {
        var response = await _apiBaseHelper.uploadAvatar(
          ApiUrl.uploadAvatar,
          fileImg!,
          (_, __) => {},
          ((error) async {
            AppSnackBar.show(mContext, AppSnackBarType.Error,
                'Cập nhật ảnh đại diện không thành công');
            await EasyLoading.dismiss();
            return;
          }),
        );
        print('response $response');
        if (response) {
          avatar = file.path.trim();
          localAvatarPath = file.path.trim();
          Map<String, dynamic> body = {
            'email': _userAppStore.user.email,
            'phone': _userAppStore.user.phone,
            'fullName': _userAppStore.user.fullName,
            'dob': TimeUtil.convertString(
                _userAppStore.user.dob!,
                TimeUtil.ViewDateFormat,
                DateTimeFormatPattern.backendTimeFormat),
            'gender': _userAppStore.user.gender,
            'address': _userAppStore.user.address,
            'personalId': _userAppStore.user.personalId,
            'insuranceNumber': _userAppStore.user.insuranceNumber,
          };
          final response = await _apiBaseHelper.patch(
            ApiUrl.updateAccountInfo,
            jsonEncode(body),
          );
          _userAppStore.updateUserInfo(User.UserInfoModel.fromJson(response));
          // AppSnackBar.show(mContext, AppSnackBarType.Success,
          //     'Cập nhật ảnh đại diện thành công');
          Fluttertoast.showToast(
              msg: 'Cập nhật ảnh đại diện thành công',
              gravity: ToastGravity.BOTTOM,
              backgroundColor: AppColors.success);
        } else {
          avatar = _userAppStore.user.avatar;
        }
      } catch (e) {
        avatar = _userAppStore.user.avatar;
        // AppSnackBar.show(mContext, AppSnackBarType.Error,
        //     'Cập nhật ảnh đại diện không thành công');
        Fluttertoast.showToast(
            msg: 'Cập nhật ảnh đại diện không thành công',
            gravity: ToastGravity.BOTTOM,
            backgroundColor: AppColors.error500);
        await EasyLoading.dismiss();
        return;
      }
    }
    EasyLoading.dismiss();
  }
}
