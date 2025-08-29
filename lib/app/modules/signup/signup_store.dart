import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/home/home_store.dart';
import 'package:pstb/services/api_exception.dart';
import 'package:pstb/utils/time_util.dart';
import 'package:mobx/mobx.dart';
import 'package:pstb/app/models/login_model.dart';
import 'package:pstb/utils/sessions/session_prefs.dart';
import 'package:pstb/app/models/register_model.dart' as Register;
import 'package:pstb/app/models/user_info_model.dart' as UserResp;
import 'package:pstb/services/api_base_helper.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';
import '../../../services/api_response.dart';
import '../../../utils/sessions/local_secure.dart';
import '../../models/token_model.dart';
import '../../app_store.dart';
import '../../models/token_model_v2.dart';
import '../../user_app_store.dart';
import './models/user_info_model.dart';

part 'signup_store.g.dart';

enum Gender { f, m, u }

class SignupStore = SignupStoreBase with _$SignupStore;

abstract class SignupStoreBase with Store {
  late final ApiBaseHelper _apiBaseHelper = ApiBaseHelper(enableLogging: true);
  final AppStore _store = Modular.get<AppStore>();
  final HomeStore _homeStore = Modular.get<HomeStore>();
  final UserAppStore _userAppStore = Modular.get<UserAppStore>();
  final TextEditingController dobController = TextEditingController();
  late BuildContext mContext;

  // signup information step3
  @observable
  String fullName = '';
  @observable
  String birthday = '';
  @observable
  String email = '';
  @observable
  Gender gender = Gender.u;

  @computed
  bool get isFemale => gender == Gender.f;

  @computed
  bool get isMale => gender == Gender.m;

  @computed
  bool get hadBirthday => birthday.isNotEmpty;

  @computed
  String? get validateFullName {
    if (fullName.trim().isEmpty) {
      return l10n(mContext)!.validate_empty;
    }
    return null;
  }

  @computed
  String? get validateBirthday {
    if (birthday.isEmpty) {
      return l10n(mContext)!.validate_empty;
    }
    return null;
  }

  @computed
  String? get validateEmail {
    final trimmedEmail = email.trim();

    if (trimmedEmail.isEmpty) {
      return l10n(mContext)!.validate_empty;
    }

    if (!Reges.regIsEmail.hasMatch(trimmedEmail)) {
      return l10n(mContext)!.sign_up_validate_email;
    }

    final parts = trimmedEmail.split('@');
    if (parts.length != 2) {
      return l10n(mContext)!.sign_up_validate_email;
    }

    final domain = parts[1].toLowerCase();

    // Chấp nhận nếu domain kết thúc bằng .vn
    if (domain.endsWith('.vn')) {
      return null;
    }

    // Nếu domain là .com thì phải nằm trong danh sách cho phép
    const allowedComDomains = ['gmail.com', 'yahoo.com', 'cloud.com'];

    if (allowedComDomains.contains(domain)) {
      return null;
    }

    return "Email phải thuộc gmail.com, yahoo.com, cloud.com hoặc có đuôi .vn";
  }

  @action
  void onChangeFullName(String text) {
    fullName = text.trim();
  }

  @action
  void onChangeBirthday(String text) {
    birthday = text;
    dobController.text = text;
  }

  @action
  void onChangeEmail(String text) {
    email = text.trim();
  }

  @action
  void onSelectGenderFemale() {
    if (gender == Gender.f) {
      gender = Gender.u;
      return;
    }
    gender = Gender.f;
  }

  @action
  void onSelectGenderMale() {
    if (gender == Gender.m) {
      gender = Gender.u;
      return;
    }
    gender = Gender.m;
  }

  @computed
  String get getGender {
    switch (gender) {
      case Gender.m:
        return "m";
      case Gender.f:
        return "f";
      default:
        return "u";
    }
  }

  // signup page step1
  @observable
  String phoneNumber = "";

  @observable
  String password = "";

  @observable
  String confirmPass = "";

  @observable
  String? phoneValidResponse;

  @computed
  String? get validatePhoneNumber {
    if (phoneNumber.trim().isEmpty) {
      return l10n(mContext)!.validate_empty;
    }
    if (!Reges.regIsPhone.hasMatch(phoneNumber.trim())) {
      return l10n(mContext)!.signup_error_phone_number;
    }
    return null;
  }

  @computed
  String? get validatePassword {
    if (password.isEmpty) {
      return l10n(mContext)!.validate_empty;
    }
    if (password.length < 8) {
      return "Tối thiểu 8 ký tự";
    }
    if (!Reges.regIsPassword.hasMatch(password)) {
      return "Cần chứa ký tự đặc biệt";
    }
    return null;
  }

  @computed
  String? get validateConfirmPass {
    if (confirmPass.trim().isEmpty) {
      return l10n(mContext)!.validate_empty;
    }
    if (confirmPass != password) {
      return l10n(mContext)!.forgot_error_confirm_pass;
    }
    /*if (!Reges.regIsPassword.hasMatch(confirmPass)) {
      return l10n(context)!.validate_password;
    }*/
    return null;
  }

  @action
  void changePhoneNumber(data) {
    // clean valid phone msg response if it not empty
    _cleanPhoneValidResponse();
    phoneNumber = data.trim();
  }

  @action
  void _changePhoneValidResponse(String? msg) {
    phoneValidResponse = msg;
  }

  void _cleanPhoneValidResponse() {
    if (phoneValidResponse != null && phoneValidResponse!.isNotEmpty) {
      _changePhoneValidResponse(null);
    }
  }

  @action
  void changePassword(data) {
    password = data;
  }

  @action
  void changeConfirmPass(data) {
    confirmPass = data;
  }

  @action
  void changeBuildContext(BuildContext newContext) {
    mContext = newContext;
  }

  @action
  Future<void> onCheckUnique() async {
    EasyLoading.show();
    try {
      final isExist = await _apiBaseHelper.get(
        ApiUrl.isExistAccount,
        {"username": phoneNumber},
      );
      EasyLoading.dismiss();
      if (isExist) {
        AppSnackBar.show(mContext, AppSnackBarType.Error,
            l10n(mContext)!.include_phone_dulicate!);
      } else {
        if (_store.enableSignUpOTP) {
          Modular.to.pushNamed(AppRoutes.signupOTP);
        } else {
          onRegister();
        }
        // onRegister();
      }
    } catch (e) {
      EasyLoading.dismiss();
      print(e);
    }
  }

  @action
  Future<void> onRegister() async {
    EasyLoading.show();
    try {
      Register.Data body = Register.Data(
          username: phoneNumber,
          password: password,
          phone: phoneNumber,
          fullName: fullName);
      await _apiBaseHelper.post(
        ApiUrl.regis,
        body.toRawJson(),
      );
      EasyLoading.dismiss();
      AppSnackBar.show(
          mContext, AppSnackBarType.Success, "Tạo tài khoản thành công");
      onLogin();
    } on AppException catch (e) {
      EasyLoading.dismiss();
      if (_store.enableSignUpOTP) {
        Modular.to.pushNamed(AppRoutes.signupOTP);
      }
      AppSnackBar.show(mContext, AppSnackBarType.Error, e.getMessage());
    } catch (e) {
      EasyLoading.dismiss();
      AppSnackBar.show(
          mContext, AppSnackBarType.Error, l10n(mContext)!.sign_up_failed);
    }
  }

  @action
  Future<void> onRegisterV2() async {
    EasyLoading.show();
    try {
      Map<String, String> body = {"phone": phoneNumber};
      final response =
          await _apiBaseHelper.post(ApiUrl.regisV2, jsonEncode(body));

      print(response);

      final data = response;
      if (data != null && data is Map<String, dynamic>) {
        final secretKey = data['secretKey'];
        Modular.to.pushNamed(AppRoutes.signupOTP,
            arguments: {'secretKey': secretKey});
      } else {
        // xử lý data null hoặc không phải Map
        AppSnackBar.show(
            mContext, AppSnackBarType.Error, l10n(mContext)!.sign_up_failed);
      }

      //final secretKey = "7UDWJY7YQJYBK76G4P5ZX5DCYHPKTKG7";
      EasyLoading.dismiss();
      // Modular.to
      //     .pushNamed(AppRoutes.signupOTP, arguments: {'secretKey': secretKey});
    } on AppException catch (e) {
      EasyLoading.dismiss();
      if (_store.enableSignUpOTP) {
        //Modular.to.pushNamed(AppRoutes.signupOTP);
      }
      AppSnackBar.show(mContext, AppSnackBarType.Error, e.getMessage());
    } catch (e) {
      EasyLoading.dismiss();
      // AppSnackBar.show(
      //     mContext, AppSnackBarType.Error, l10n(mContext)!.sign_up_failed);
      AppSnackBar.show(mContext, AppSnackBarType.Error, e.toString());
      print(e.toString());
    }
  }

  @action
  Future<void> onCheckOtp(String secretKey, String otp) async {
    EasyLoading.show();
    try {
      Map<String, String> body = {
        "phone": phoneNumber,
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
          Register.Data body = Register.Data(
              username: phoneNumber,
              password: password,
              phone: phoneNumber,
              fullName: fullName);
          await _apiBaseHelper.post(
            ApiUrl.regis,
            body.toRawJson(),
          );
          EasyLoading.dismiss();
          AppSnackBar.show(
              mContext, AppSnackBarType.Success, "Tạo tài khoản thành công");
          onLogin();
        } else {
          AppSnackBar.show(mContext, AppSnackBarType.Error,
              "Mã Otp chưa chính xác hoặc hết hạn");
        }
      } else {
        // xử lý data null hoặc không phải Map
        AppSnackBar.show(
            mContext, AppSnackBarType.Error, l10n(mContext)!.sign_up_failed);
      }
    } on AppException catch (e) {
      EasyLoading.dismiss();
      if (_store.enableSignUpOTP) {
        //Modular.to.pushNamed(AppRoutes.signupOTP);
      }
      AppSnackBar.show(mContext, AppSnackBarType.Error, e.getMessage());
    } catch (e) {
      EasyLoading.dismiss();
      // AppSnackBar.show(
      //     mContext, AppSnackBarType.Error, l10n(mContext)!.sign_up_failed);
      AppSnackBar.show(mContext, AppSnackBarType.Error, e.toString());
    }
  }

  @action
  Future<void> onLogin() async {
    EasyLoading.show();
    try {
      final response = await _apiBaseHelper.post(
        ApiUrl.token,
        LoginModel(password: password, username: phoneNumber).toRawJson(),
      );
      final authenticationResult = AuthenticationResult.fromJson(response);
      SessionPrefs.signedIn(authenticationResult);
      String user = json.encode(authenticationResult);
      await _logInSuccess(authenticationResult);
      ApiBaseHelper.setHeader(user);
      EasyLoading.dismiss();
      Modular.to.pushNamed(AppRoutes.signupInfo);
    } on AppException catch (e) {
      EasyLoading.dismiss();
      AppSnackBar.show(mContext, AppSnackBarType.Error, e.toString());
    } catch (e) {
      EasyLoading.dismiss();
      AppSnackBar.show(mContext, AppSnackBarType.Error, e.toString());
    }
  }

  Future<void> _logInSuccess(AuthenticationResult tokenData) async {
    await SessionPrefs.signedIn(tokenData);
    String user = json.encode(tokenData);
    ApiBaseHelper.setHeader(user);
    EasyLoading.dismiss();
    final isSignedIn = await SessionPrefs.isSignedIn();
    if (isSignedIn) {
      _homeStore.isLogin = isSignedIn;
    }
    await _store.loadBiometricSetting();
    _store.setReload(!_store.reload);
    await _userAppStore.getAccountDetail();
  }

  // @action
  // Future<void> onLogin() async {
  //   EasyLoading.show();
  //   try {
  //     final response = await _apiBaseHelper.post(
  //       ApiUrl.tokenV2,
  //       LoginModel(password: password, username: phoneNumber).toRawJson(),
  //     );
  //     final authenticationResult = AuthenticationResultV2.fromJson(response);
  //     SessionPrefs.signedIn(authenticationResult);
  //     String user = json.encode(authenticationResult);
  //     await _logInSuccess(authenticationResult);
  //     ApiBaseHelper.setHeader(user);
  //     EasyLoading.dismiss();
  //     Modular.to.pushNamed(AppRoutes.signupInfo);
  //   } on AppException catch (e) {
  //     EasyLoading.dismiss();
  //     AppSnackBar.show(mContext, AppSnackBarType.Error, e.toString());
  //   } catch (e) {
  //     EasyLoading.dismiss();
  //     AppSnackBar.show(mContext, AppSnackBarType.Error, e.toString());
  //   }
  // }
  //
  // Future<void> _logInSuccess(AuthenticationResultV2 tokenData) async {
  //   await SessionPrefs.signedIn(tokenData);
  //   final secure = FlutterSecure();
  //   await secure.writeKeyStorage(
  //     key: "secretKey",
  //     value: tokenData.secretKey,
  //   );
  //   String user = json.encode(tokenData);
  //   ApiBaseHelper.setHeader(user);
  //   EasyLoading.dismiss();
  //   final isSignedIn = await SessionPrefs.isSignedIn();
  //   if (isSignedIn) {
  //     _homeStore.isLogin = isSignedIn;
  //   }
  //   await _store.loadBiometricSetting();
  //   _store.setReload(!_store.reload);
  //   await _userAppStore.getAccountDetail();
  // }

  @action
  Future<void> onAddInfo() async {
    EasyLoading.show();
    try {
      await _apiBaseHelper.patch(
        ApiUrl.updateAccountInfo,
        UserInfoModel(
          dob: dobController.text + " 00:00",
          email: email,
          gender: getGender,
          name: fullName.trim(),
        ).toRawJson(),
      );
      Map<String, dynamic> body = {
        'email': email,
        'fullName': fullName,
        'phone': phoneNumber,
        'dob': TimeUtil.convertString(dobController.text,
            TimeUtil.ViewDateFormat, DateTimeFormatPattern.backendTimeFormat),
        'gender': getGender,
        'address': null,
        'personalId': null,
        'insuranceNumber': null,
      };
      _userAppStore.updateUserInfo(UserResp.UserInfoModel.fromJson(body));
      Modular.to.pushNamed(AppRoutes.signupSuccess);
      EasyLoading.dismiss();
    } on AppException catch (e) {
      EasyLoading.dismiss();
      AppSnackBar.show(mContext, AppSnackBarType.Error, e.toString());
    } on Exception catch (e) {
      EasyLoading.dismiss();
      AppSnackBar.show(mContext, AppSnackBarType.Error, e.toString());
    }
  }
}
