// lib/app/modules/signup/signup_store.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import 'package:pstb/app/modules/home/home_store.dart';

import 'package:pstb/services/api_base_helper.dart';
import 'package:pstb/services/api_exception.dart';

import 'package:pstb/utils/main.dart'; // AppRoutes, ApiUrl, Reges, Styles, l10n...
import 'package:pstb/utils/time_util.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart'; // AppSnackBar

import 'package:pstb/app/models/login_model.dart';
import 'package:pstb/app/models/register_model.dart' as Register;
import 'package:pstb/app/models/user_info_model.dart' as UserResp;
import 'package:pstb/app/models/token_model.dart';
import 'package:pstb/utils/sessions/session_prefs.dart';

// Model PATCH update info (của module signup, BẮT BUỘC có personalId)
import '../../app_store.dart';
import '../../user_app_store.dart';
import './models/user_info_model.dart';

part 'signup_store.g.dart';

enum Gender { f, m, u }

class SignupStore = SignupStoreBase with _$SignupStore;

abstract class SignupStoreBase with Store {
  // ---------------------------------------------------------------------------
  // DI & Helpers
  // ---------------------------------------------------------------------------
  late final ApiBaseHelper _apiBaseHelper = ApiBaseHelper(enableLogging: true);
  final AppStore _store = Modular.get<AppStore>();
  final HomeStore _homeStore = Modular.get<HomeStore>();
  final UserAppStore _userAppStore = Modular.get<UserAppStore>();

  final TextEditingController dobController = TextEditingController();
  late BuildContext mContext;

  // ---------------------------------------------------------------------------
  // STEP: Thông tin tài khoản + hồ sơ (gộp 1 form)
  // ---------------------------------------------------------------------------
  @observable
  String phoneNumber = "";

  @observable
  String password = "";

  @observable
  String confirmPass = "";

  @observable
  String? phoneValidResponse;

  // Hồ sơ
  @observable
  String fullName = '';

  @observable
  String birthday = '';

  @observable
  String email = '';

  @observable
  Gender gender = Gender.u;

  @observable
  String personalId = ''; // CCCD/CMND – BẮT BUỘC

  // ---------------------------------------------------------------------------
  // Computed – UI helpers
  // ---------------------------------------------------------------------------
  @computed
  bool get isFemale => gender == Gender.f;

  @computed
  bool get isMale => gender == Gender.m;

  @computed
  bool get hadBirthday => birthday.isNotEmpty;

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

  // ---------------------------------------------------------------------------
  // Validators
  // ---------------------------------------------------------------------------
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
    return null;
  }

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

    // Cho phép domain .vn
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

  @computed
  String? get validatePersonalId {
    final id = personalId.trim();
    if (id.isEmpty) return l10n(mContext)!.validate_empty;
    // Cho phép 12 số (CCCD) hoặc 9 số (CMND). Nếu chỉ nhận CCCD: dùng r'^\d{12}$'
    if (!RegExp(r'^\d{9}$|^\d{12}$').hasMatch(id)) {
      return "CCCD/CMND phải gồm 12 số (hoặc 9 số cũ)";
    }
    return null;
  }

  // ---------------------------------------------------------------------------
  // Actions – onChange
  // ---------------------------------------------------------------------------
  @action
  void changeBuildContext(BuildContext newContext) {
    mContext = newContext;
  }

  @action
  void changePhoneNumber(dynamic data) {
    _cleanPhoneValidResponse();
    phoneNumber = (data ?? '').toString().trim();
  }

  @action
  void changePassword(dynamic data) {
    password = (data ?? '').toString();
  }

  @action
  void changeConfirmPass(dynamic data) {
    confirmPass = (data ?? '').toString();
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
  void onChangePersonalId(String text) {
    personalId = text.trim();
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

  @action
  void _changePhoneValidResponse(String? msg) {
    phoneValidResponse = msg;
  }

  void _cleanPhoneValidResponse() {
    if (phoneValidResponse != null && phoneValidResponse!.isNotEmpty) {
      _changePhoneValidResponse(null);
    }
  }

  // ---------------------------------------------------------------------------
  // FLOW 1 BƯỚC: Đăng ký → Đăng nhập → Update Info (có personalId)
  // ---------------------------------------------------------------------------
  @action
  Future<void> registerAndUpdateAll() async {
    EasyLoading.show();
    try {
      // 0) Kiểm tra trùng SĐT
      final isExist = await _checkPhoneDuplicated();
      if (isExist) {
        EasyLoading.dismiss();
        AppSnackBar.show(
          mContext,
          AppSnackBarType.Error,
          l10n(mContext)!.include_phone_dulicate!,
        );
        return;
      }

      // 1) Đăng ký
      await _register();

      // 2) Đăng nhập để có token
      await _login(); // sẽ set header + session

      // 3) Cập nhật thông tin hồ sơ (kèm personalId)
      await _patchUpdateInfo();

      EasyLoading.dismiss();
      Modular.to.pushNamed(AppRoutes.signupSuccess);
    } on AppException catch (e) {
      EasyLoading.dismiss();
      AppSnackBar.show(mContext, AppSnackBarType.Error, e.getMessage());
    } catch (e) {
      EasyLoading.dismiss();
      AppSnackBar.show(mContext, AppSnackBarType.Error, e.toString());
    }
  }

  // ---------------------------------------------------------------------------
  // Legacy/Compatibility methods (vẫn giữ để nơi khác dùng không lỗi)
  // ---------------------------------------------------------------------------
  /// Dùng ở UI cũ: chỉ check trùng và (trước đây) điều hướng OTP/đăng ký.
  /// Giờ sẽ gọi thẳng flow 1 bước nếu không trùng.
  @action
  Future<void> onCheckUnique() async {
    EasyLoading.show();
    try {
      final isExist = await _checkPhoneDuplicated();
      EasyLoading.dismiss();
      if (isExist) {
        AppSnackBar.show(
          mContext,
          AppSnackBarType.Error,
          l10n(mContext)!.include_phone_dulicate!,
        );
      } else {
        // Chạy flow đầy đủ
        await registerAndUpdateAll();
      }
    } catch (e) {
      EasyLoading.dismiss();
      AppSnackBar.show(mContext, AppSnackBarType.Error, e.toString());
    }
  }

  /// Đăng ký kiểu cũ (không update info). Nên dùng registerAndUpdateAll().
  @action
  Future<void> onRegister() async {
    EasyLoading.show();
    try {
      await _register();
      EasyLoading.dismiss();
      AppSnackBar.show(
          mContext, AppSnackBarType.Success, "Tạo tài khoản thành công");
      await onLogin(); // Điều hướng sang signupInfo theo logic cũ
    } on AppException catch (e) {
      EasyLoading.dismiss();
      AppSnackBar.show(mContext, AppSnackBarType.Error, e.getMessage());
    } catch (e) {
      EasyLoading.dismiss();
      AppSnackBar.show(
          mContext, AppSnackBarType.Error, l10n(mContext)!.sign_up_failed);
    }
  }

  /// OTP flow – nếu bạn còn dùng OTP: sau khi check otp thành công, thực hiện đăng ký → đăng nhập → update info
  @action
  Future<void> onRegisterV2() async {
    EasyLoading.show();
    try {
      final body = {"phone": phoneNumber};
      final response =
          await _apiBaseHelper.post(ApiUrl.regisV2, jsonEncode(body));
      final data = response;
      if (data != null && data is Map<String, dynamic>) {
        final secretKey = data['secretKey'];
        EasyLoading.dismiss();
        Modular.to.pushNamed(AppRoutes.signupOTP,
            arguments: {'secretKey': secretKey});
      } else {
        EasyLoading.dismiss();
        AppSnackBar.show(
            mContext, AppSnackBarType.Error, l10n(mContext)!.sign_up_failed);
      }
    } on AppException catch (e) {
      EasyLoading.dismiss();
      AppSnackBar.show(mContext, AppSnackBarType.Error, e.getMessage());
    } catch (e) {
      EasyLoading.dismiss();
      AppSnackBar.show(mContext, AppSnackBarType.Error, e.toString());
    }
  }

  @action
  Future<void> onCheckOtp(String secretKey, String otp) async {
    EasyLoading.show();
    try {
      final body = {"phone": phoneNumber, "secretKey": secretKey, "otp": otp};
      final response =
          await _apiBaseHelper.post(ApiUrl.checkOtp, jsonEncode(body));
      final data = response;

      if (data != null &&
          data is Map<String, dynamic> &&
          data['valid'] == true) {
        // OTP đúng → chạy flow đầy đủ
        await _register();
        await _login();
        await _patchUpdateInfo();

        EasyLoading.dismiss();
        AppSnackBar.show(
            mContext, AppSnackBarType.Success, "Tạo tài khoản thành công");
        Modular.to.pushNamed(AppRoutes.signupSuccess);
      } else {
        EasyLoading.dismiss();
        AppSnackBar.show(mContext, AppSnackBarType.Error,
            "Mã Otp chưa chính xác hoặc hết hạn");
      }
    } on AppException catch (e) {
      EasyLoading.dismiss();
      AppSnackBar.show(mContext, AppSnackBarType.Error, e.getMessage());
    } catch (e) {
      EasyLoading.dismiss();
      AppSnackBar.show(mContext, AppSnackBarType.Error, e.toString());
    }
  }

  /// Đăng nhập kiểu cũ (chỉ login xong điều hướng sang signupInfo)
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

  /// Cập nhật info kiểu cũ – ĐÃ BỔ SUNG personalId là bắt buộc
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
          personalId: personalId, // BẮT BUỘC
        ).toRawJson(),
      );

      final body = {
        'email': email,
        'fullName': fullName,
        'phone': phoneNumber,
        'dob': TimeUtil.convertString(
          dobController.text,
          TimeUtil.ViewDateFormat,
          DateTimeFormatPattern.backendTimeFormat,
        ),
        'gender': getGender,
        'address': null,
        'personalId': personalId,
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

  // ---------------------------------------------------------------------------
  // Private helpers
  // ---------------------------------------------------------------------------
  Future<bool> _checkPhoneDuplicated() async {
    final isExist = await _apiBaseHelper.get(
      ApiUrl.isExistAccount,
      {"username": phoneNumber},
    );
    return isExist == true;
  }

  Future<void> _register() async {
    final body = Register.Data(
      username: phoneNumber,
      password: password,
      phone: phoneNumber,
      fullName: fullName,
    );
    await _apiBaseHelper.post(ApiUrl.regis, body.toRawJson());
  }

  Future<void> _login() async {
    final response = await _apiBaseHelper.post(
      ApiUrl.token,
      LoginModel(password: password, username: phoneNumber).toRawJson(),
    );
    final authenticationResult = AuthenticationResult.fromJson(response);
    await _logInSuccess(authenticationResult);
    final userJson = json.encode(authenticationResult);
    ApiBaseHelper.setHeader(userJson);
  }

  Future<void> _patchUpdateInfo() async {
    await _apiBaseHelper.patch(
      ApiUrl.updateAccountInfo,
      UserInfoModel(
        dob: dobController.text + " 00:00",
        email: email,
        gender: getGender,
        name: fullName.trim(),
        personalId: personalId,
      ).toRawJson(),
    );

    // Update cache/local store để UI đồng bộ
    final mapped = {
      'email': email,
      'fullName': fullName,
      'phone': phoneNumber,
      'dob': TimeUtil.convertString(
        dobController.text,
        TimeUtil.ViewDateFormat,
        DateTimeFormatPattern.backendTimeFormat,
      ),
      'gender': getGender,
      'address': null,
      'personalId': personalId,
      'insuranceNumber': null,
    };
    _userAppStore.updateUserInfo(UserResp.UserInfoModel.fromJson(mapped));
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
}
