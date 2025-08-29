import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/models/user_info_model.dart' as user;
import 'package:pstb/services/api_base_helper.dart';
import 'package:pstb/services/api_exception.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/utils/time_util.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';
import 'package:mobx/mobx.dart';
import '../../../../user_app_store.dart';

part 'edit_profile_store.g.dart';

enum Gender { m, f, u }

class EditProfileStore = EditProfileStoreBase with _$EditProfileStore;

abstract class EditProfileStoreBase with Store {
  final ApiBaseHelper _apiBaseHelper = Modular.get<ApiBaseHelper>();

  final UserAppStore _userAppStore = Modular.get<UserAppStore>();
  late BuildContext mContext;
  @observable
  String fullName = '';
  @observable
  String birthday = '';
  @observable
  String email = '';
  @observable
  Gender gender = Gender.u;
  @observable
  String phoneNumber = "";
  @observable
  String avatar = "";
  @observable
  String localAvatarPath = "";
  @observable
  String address = '';
  @observable
  String personalId = '';
  @observable
  String insuranceNumber = '';
  @observable
  String codeNursing = '';

  @observable
  TextEditingController dobController = TextEditingController();

  TextEditingController addressController = TextEditingController();

  XFile? fileImg;

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
    } else {
      RegExp regExp = RegExp(
          "(0?[1-9]|[12][0-9]|3[01])/(0?[1-9]|1[012])/((?:19|20)[0-9][0-9])");
      if (!regExp.hasMatch(birthday) ||
          birthday.length != 10 ||
          !(1900 < int.parse(birthday.split('/')[2]) &&
              int.parse(birthday.split('/')[2]) < DateTime.now().year + 1)) {
        return "Sai định dạng ngày tháng năm";
      }
      // if (regExp.hasMatch(birthday)) {
      //   if (birthday.length == 10) {
      //     if (1900 < int.parse(birthday.split('/')[2]) &&
      //         int.parse(birthday.split('/')[2]) < DateTime.now().year + 1) {
      //       return null;
      //     } else {
      //       return "Sai định dạng ngày tháng năm";
      //     }
      //   } else {
      //     return null;
      //   }
      else {
        return null;
      }
    }
  }

  @computed
  String? get validateEmail {
    if (email.trim().isEmpty) {
      return l10n(mContext)!.validate_empty;
    }
    if (!Reges.regIsEmail.hasMatch(email.trim())) {
      return l10n(mContext)!.sign_up_validate_email;
    }
    return null;
  }

  @computed
  String? get validatePhoneNumber {
    if (phoneNumber.trim().isEmpty) {
      return null;
    }
    if (!Reges.regIsPhone.hasMatch(phoneNumber.trim())) {
      return l10n(mContext)!.signup_error_phone_number;
    }
    return null;
  }

  @action
  void onChangeFullName(String text) {
    fullName = text.trim();
  }

  @action
  void onChangeAddress(String text) {
    addressController.text = text;
    address = text.trim();
  }

  @action
  void onChangePersonalId(String text) {
    personalId = text.trim();
  }

  @action
  void onChangeInsuranceNumber(String text) {
    insuranceNumber = text.trim();
  }

  @action
  void onChangeInsuranceId(String text) {
    insuranceNumber = text.trim();
  }

  @action
  void onChangeBirthday(String text) {
    dobController.text = text.split(" ")[0];
    birthday = text.split(" ")[0];
  }

  @action
  void onChangeEmail(String text) {
    email = text.trim();
  }

  @action
  void onChangeAvatar(XFile file) {
    avatar = file.path.trim();
    localAvatarPath = file.path.trim();
    fileImg = file;
  }

  @action
  void onChangePhone(String text) {
    phoneNumber = text.trim();
  }

  @action
  void onChangeCodeNursing(String text) {
    codeNursing = text.trim();
  }

  @action
  void onSelectGender(Gender? genderSelected) {
    switch (genderSelected) {
      case Gender.f:
        gender = Gender.f;
        return;
      case Gender.m:
        gender = Gender.m;
        return;
      default:
        return;
    }
  }

  @action
  void onChangeBuildContext(BuildContext buildContext) {
    mContext = buildContext;
  }

  @action
  void initialValue(user.UserInfoModel dataUserInfo) {
    fullName = dataUserInfo.fullName ??
        "${dataUserInfo.firstName ?? ''} ${dataUserInfo.lastName ?? ''}";
    birthday = (dataUserInfo.dob ?? "").split(" ")[0];
    dobController.text = (dataUserInfo.dob ?? "").split(" ")[0];
    address = dataUserInfo.address ?? "";
    email = dataUserInfo.email ?? '';
    phoneNumber = dataUserInfo.phone ?? '';
    avatar = dataUserInfo.avatar ?? '';
    insuranceNumber = dataUserInfo.insuranceNumber ?? '';
    personalId = dataUserInfo.personalId ?? '';
    codeNursing = dataUserInfo.staffCode ?? '';
    if (dataUserInfo.gender == null) {
      gender = Gender.u;
    } else {
      gender = dataUserInfo.gender!.toLowerCase() == "u".toLowerCase()
          ? Gender.u
          : dataUserInfo.gender!.toLowerCase() == "m"
              ? Gender.m
              : Gender.f;
    }
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

  @action
  Future<void> onUpdateUser({String? birthday}) async {
    birthday ??= this.birthday;
    EasyLoading.show();
    Map<String, dynamic> body = {
      'email': email,
      'fullName': fullName,
      'dob': TimeUtil.convertString(birthday, TimeUtil.ViewDateFormat,
          DateTimeFormatPattern.backendTimeFormat),
      'gender': getGender,
      'address': address,
      'personalId': personalId,
      'insuranceNumber': insuranceNumber,
    };

    ///upload avatar
    // if (fileImg != null) {
    //   try {
    //     await _apiBaseHelper.uploadAvatar(
    //         ApiUrl.uploadAvatar, fileImg!, (_, __) => {}, ((error) {
    //       AppSnackBar.show(mContext, AppSnackBarType.Error,
    //           l10n(mContext).update_profile_false);
    //       EasyLoading.dismiss();
    //       return;
    //     }));
    //     EasyLoading.dismiss();
    //   } catch (e) {
    //     EasyLoading.dismiss();
    //     AppSnackBar.show(mContext, AppSnackBarType.Error,
    //         l10n(mContext)!.update_profile_false!);
    //     return;
    //   }
    // }

    // add phone number to body
    if (_userAppStore.user.phone == null && phoneNumber != '') {
      body = {
        ...body,
        'phone': phoneNumber,
      };
    }

    try {
      final response = await _apiBaseHelper.patch(
        ApiUrl.updateAccountInfo,
        jsonEncode(body),
      );

      _userAppStore.updateUserInfo(user.UserInfoModel.fromJson(response));
      _userAppStore.user.gender = gender == Gender.f ? 'f' : 'm';
      AppSnackBar.show(mContext, AppSnackBarType.Success,
          l10n(mContext)!.update_profile_success!);
      Modular.to.pop();
      EasyLoading.dismiss();
    } on AppException catch (e) {
      AppSnackBar.show(mContext, AppSnackBarType.Error, e.toString());
    } on Exception catch (e) {
      AppSnackBar.show(mContext, AppSnackBarType.Error, e.toString());
    }
    EasyLoading.dismiss();
  }
}
