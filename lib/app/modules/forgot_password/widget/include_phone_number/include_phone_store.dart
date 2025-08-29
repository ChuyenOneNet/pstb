import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:pstb/app/models/unique_phone_responsitory.dart'
    as unique;
import 'package:pstb/services/api_base_helper.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/app_snack_bar.dart';

part 'include_phone_store.g.dart';

class IncludePhoneStore = IncludePhoneStoreBase with _$IncludePhoneStore;

abstract class IncludePhoneStoreBase with Store {
  late BuildContext mContext;
  final ApiBaseHelper _apiBaseHelper = ApiBaseHelper();
  @observable
  String phoneNumber = "";
  @observable
  String routeName = "";
  @observable
  String? phoneValidResponse;

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

  @action
  void changePhoneNumber(String data) {
    // clean valid phone msg response if it not empty
    _cleanPhoneValidResponse();
    phoneNumber = data;
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
  Future<void> onCheckUnique() async {
    EasyLoading.show();
    try {
      unique.UniquePhoneModel body = unique.UniquePhoneModel(phone: phoneNumber);
      final response = await _apiBaseHelper.get(
        ApiUrl.isExistAccount,
        body.toJson(),
      );
      if (response) {
        Modular.to
            .pushNamed(routeName, arguments: {"phoneNumber": phoneNumber});
      } else {
        _changePhoneValidResponse(l10n(mContext)!.validate_phone);
      }
    } catch (e) {
      AppSnackBar.show(
          mContext, AppSnackBarType.Error, l10n(mContext)!.wrong_when_try!);
    }
    EasyLoading.dismiss();
  }

  @action
  void changeRouteName(String value) {
    routeName = value;
  }

  @action
  void changeBuildContext(BuildContext newContext) {
    mContext = newContext;
  }
}
