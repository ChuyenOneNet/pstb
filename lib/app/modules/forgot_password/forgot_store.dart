// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter_modular/flutter_modular.dart';
// import 'package:mobx/mobx.dart';
// import 'package:pstb/app/models/reset_password_model.dart';
// import 'package:pstb/services/api_base_helper.dart';
// import 'package:pstb/utils/main.dart';
// import 'package:pstb/widgets/stateless/app_snack_bar.dart';
//
// part 'forgot_store.g.dart';
//
// class ForgotStore = ForgotStoreBase with _$ForgotStore;
//
// abstract class ForgotStoreBase with Store {
//   final ApiBaseHelper _apiBaseHelper = ApiBaseHelper();
//   late BuildContext mContext;
//   @observable
//   String otp = "";
//
//   @observable
//   String phoneNumber = "";
//
//   @observable
//   String newPass = "";
//
//   @observable
//   String confirmPass = "";
//
//   @computed
//   String? get validatePassword {
//     if (newPass.trim().length < 8) {
//       return l10n(mContext)!.validate_password;
//     }
//     //
//     // if (!Reges.regIsPassword.hasMatch(newPass)) {
//     //   return l10n(context)!.validate_password;
//     // }
//     return null;
//   }
//
//   @computed
//   String? get validateConfirmPass {
//     if (confirmPass.trim().isEmpty) {
//       return l10n(mContext)!.validate_empty;
//     }
//     if (confirmPass != newPass) {
//       return l10n(mContext)!.forgot_error_confirm_pass;
//     }
//     return null;
//   }
//
//   @action
//   void changePhoneNumber(String data) {
//     phoneNumber = data;
//   }
//
//   @action
//   void changeNewPass(String data) {
//     newPass = data;
//   }
//
//   @action
//   void changeConfirmPass(String data) {
//     confirmPass = data;
//   }
//
//   @action
//   Future<void> getOTP() async {
//     EasyLoading.show();
//     try {
//       final response =
//           await _apiBaseHelper.get("${ApiUrl.getOtp}/$phoneNumber");
//       otp = response;
//     } catch (e) {
//       AppSnackBar.show(
//           mContext, AppSnackBarType.Error, l10n(mContext)!.wrong_when_try);
//     }
//     EasyLoading.dismiss();
//   }
//
//   @action
//   Future<void> postResetPassword() async {
//     EasyLoading.show();
//     try {
//       await _apiBaseHelper.put(
//         ApiUrl.forgotPassword,
//         ForgotPasswordModel(
//                 username: phoneNumber,
//                 newPassword: newPass,
//                 confirmPassword: confirmPass,
//                 otp: otp,
//                 key: ApiConstance.changePasswordKey)
//             .toRawJson(),
//       );
//       Modular.to.pushNamed(AppRoutes.forgotSuccess);
//     } catch (e) {
//       AppSnackBar.show(
//           mContext, AppSnackBarType.Error, l10n(mContext)!.wrong_when_try);
//     }
//     EasyLoading.dismiss();
//   }
//
//   @action
//   void changeBuildContext(BuildContext newContext) {
//     mContext = newContext;
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:pstb/app/models/reset_password_model.dart';
import 'package:pstb/services/api_base_helper.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/app_snack_bar.dart';

part 'forgot_store.g.dart';

class ForgotStore = ForgotStoreBase with _$ForgotStore;

abstract class ForgotStoreBase with Store {
  final ApiBaseHelper _apiBaseHelper = ApiBaseHelper();
  late BuildContext mContext;

  @observable
  String phoneNumber = "";

  @observable
  String newPass = "";

  @observable
  String confirmPass = "";

  @computed
  String? get validatePhoneNumber {
    if (phoneNumber.trim().isEmpty) {
      return l10n(mContext)!.validate_empty;
    }
    if (!Reges.regIsPhone.hasMatch(phoneNumber)) {
      return l10n(mContext)!.validate_phone;
    }
    return null;
  }

  @computed
  String? get validatePassword {
    if (newPass.trim().isEmpty) {
      return l10n(mContext)!.validate_empty;
    }
    if (newPass.trim().length < 8) {
      return "Tối thiểu 8 ký tự";
    }
    if (!Reges.regIsPassword.hasMatch(newPass.trim())) {
      return "Cần chứa ký tự đặc biệt";
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
    }
    return null;
  }

  @action
  void changePhoneNumber(String value) {
    phoneNumber = value;
  }

  @action
  void changeNewPass(String value) {
    newPass = value;
  }

  @action
  void changeConfirmPass(String value) {
    confirmPass = value;
  }

  @action
  void changeBuildContext(BuildContext context) {
    mContext = context;
  }

  @action
  Future<void> postResetPassword() async {
    EasyLoading.show();
    try {
      final body = ForgotPasswordModel(
        username: phoneNumber,
        newPassword: newPass,
        confirmPassword: confirmPass,
        key: ApiConstance.changePasswordKey,
      ).toRawJson();

      await _apiBaseHelper.put(ApiUrl.forgotPassword, body);

      Modular.to.pushNamed(AppRoutes.forgotSuccess);
    } catch (e) {
      AppSnackBar.show(
        mContext,
        AppSnackBarType.Error,
        l10n(mContext)!.wrong_when_try,
      );
    }
    EasyLoading.dismiss();
  }
}
