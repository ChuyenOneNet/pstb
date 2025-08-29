import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/models/change_password_model.dart';
import 'package:pstb/app/modules/home/home_store.dart';
import 'package:pstb/app/modules/profile/pages/setting/setting_store.dart';
import 'package:pstb/app/user_app_store.dart';
import 'package:pstb/services/api_base_helper.dart';
import 'package:pstb/services/api_exception.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/utils/sessions/local_secure.dart';
import 'package:pstb/utils/sessions/session_prefs.dart';
import 'package:pstb/widgets/stateless/app_snack_bar.dart';
import 'package:mobx/mobx.dart';

import '../../../repository/insurance/insurance_model.dart';

part 'change_password_store.g.dart';

class ChangePasswordStore = ChangePasswordStoreBase with _$ChangePasswordStore;

abstract class ChangePasswordStoreBase with Store {
  final ApiBaseHelper _apiBaseHelper = ApiBaseHelper(enableLogging: true);
  final _userStore = Modular.get<UserAppStore>();

  late BuildContext mContext;
  @observable
  String oldPass = "";
  @observable
  String? oldPassMsgResponse; // value of validate password response from api

  @observable
  String newPass = "";

  @observable
  String confirmPass = "";

  @computed
  String? get validateOldPassword {
    if (oldPass.trim().length < 8) {
      return l10n(mContext)!.validate_password;
    }
    return null;
  }

  @computed
  String? get validateNewPassword {
    if (newPass.trim().length < 8) {
      return l10n(mContext)!.validate_password;
    }

    if (!Reges.regIsPassword.hasMatch(newPass)) {
      return l10n(mContext)!.validate_password;
    }
    return null;
  }

  @computed
  String? get validateConfirmPass {
    if (confirmPass.trim().isEmpty) {
      return l10n(mContext)!.validate_empty;
    }
    if (confirmPass != newPass) {
      return l10n(mContext)!.forgot_error_confirm_pass;
    } else if (!Reges.regIsPassword.hasMatch(confirmPass)) {
      return l10n(mContext)!.validate_password;
    }
    return null;
  }

  @action
  void changeOldPass(String data) {
    // clean old pass msg response if it not empty
    _cleanOldPassMsgResponse();
    oldPass = data;
  }

  @action
  void changeNewPass(String data) {
    newPass = data;
  }

  @action
  void changeConfirmPass(String data) {
    confirmPass = data;
  }

  @action
  void _changeOldPassMsgResponse(String? msg) {
    oldPassMsgResponse = msg;
  }

  void _cleanOldPassMsgResponse() {
    if (oldPassMsgResponse != null && oldPassMsgResponse!.isNotEmpty) {
      _changeOldPassMsgResponse(null);
    }
  }

  // @action
  // Future<void> putChangePassword() async {
  //   EasyLoading.show();
  //   try {
  //     await _apiBaseHelper.put(
  //       ApiUrl.changePassword,
  //       ChangePasswordModel(
  //         oldPassword: oldPass,
  //         newPassword: newPass,
  //       ).toRawJson(),
  //     );
  //     AppSnackBar.show(
  //         mContext, AppSnackBarType.Success, "Đổi mật khẩu thành công!");
  //     await _updatePasswordBiometric();
  //     final phone = await SessionPrefs.getPhoneNumber();
  //     if (phone != null && phone.isNotEmpty) {
  //       await FlutterSecure().writeKeyStorage(key: phone, value: newPass);
  //     }
  //     _userStore.isCodeNursing = false;
  //     Modular.to.pop();
  //   } on AppException catch (e) {
  //     AppSnackBar.show(mContext, AppSnackBarType.Error, e.getMessage());
  //   } catch (e) {
  //     AppSnackBar.show(
  //         mContext, AppSnackBarType.Error, l10n(mContext)!.wrong_when_try!);
  //   }
  //   EasyLoading.dismiss();
  // }

  @action
  Future<void> putChangePassword() async {
    EasyLoading.show();
    try {
      await _apiBaseHelper.put(
        ApiUrl.changePassword,
        ChangePasswordModel(
          oldPassword: oldPass,
          newPassword: newPass,
        ).toRawJson(),
      );
      AppSnackBar.show(
          mContext, AppSnackBarType.Success, "Đổi mật khẩu thành công!");
      await _updatePasswordBiometric();
      final phone = await SessionPrefs.getPhoneNumber();
      if (phone != null && phone.isNotEmpty) {
        await FlutterSecure().writeKeyStorage(key: phone, value: newPass);
      }
      _userStore.isCodeNursing = false;
      Modular.to.pop();
    } on AppException catch (e) {
      AppSnackBar.show(mContext, AppSnackBarType.Error, e.getMessage());
    } catch (e) {
      AppSnackBar.show(
          mContext, AppSnackBarType.Error, l10n(mContext)!.wrong_when_try!);
    }
    EasyLoading.dismiss();
  }

  @action
  void changeBuildContext(BuildContext newContext) {
    mContext = newContext;
  }

  Future<void> _updatePasswordBiometric() async {
    final settingStore = Modular.get<SettingStore>();
    if (settingStore.isActiveFinger) {
      final secure = FlutterSecure();
      final homeStore = Modular.get<HomeStore>();
      final getKey = homeStore.phoneNumberCache;
      await secure.writeKeyStorage(
        key: getKey,
        value: newPass,
      );
    }
  }

  @action
  Future<void> onCheckOtp(String secretKey, String otp) async {
    EasyLoading.show();
    try {
      final phone = await SessionPrefs.getPhoneNumber();
      if (phone != null && phone.isNotEmpty) {
        Map<String, String> body = {
          "phone": phone,
          "secretKey": secretKey,
          "otp": otp,
        };
        final response =
            await _apiBaseHelper.post(ApiUrl.checkOtp, jsonEncode(body));
        final data = response;
        if (data != null && data is Map<String, dynamic>) {
          if (data['valid']) {
            // OTP đúng, xử lý tiếp
            EasyLoading.dismiss();
            // AppSnackBar.show(
            //     mContext, AppSnackBarType.Success, "Xác thực thành công");
            putChangePassword();
          } else {
            EasyLoading.dismiss();
            AppSnackBar.show(mContext, AppSnackBarType.Error,
                "Mã Otp chưa chính xác hoặc hết hạn");
          }
        } else {
          EasyLoading.dismiss();
          // xử lý data null hoặc không phải Map
          AppSnackBar.show(
              mContext, AppSnackBarType.Error, "Đổi mật khẩu thất bại");
        }
      }
    } on AppException catch (e) {
      EasyLoading.dismiss();
      AppSnackBar.show(mContext, AppSnackBarType.Error, e.getMessage());
    } catch (e) {
      EasyLoading.dismiss();
      AppSnackBar.show(mContext, AppSnackBarType.Error, e.toString());
    }
  }
}
