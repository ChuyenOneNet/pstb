import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:pstb/app/models/nurse_model.dart';
import 'package:pstb/app/models/staff_model.dart';
import 'package:pstb/app/modules/ehr_page/ehr_store.dart';
import 'package:pstb/services/api_base_helper.dart';
import 'package:pstb/services/api_exception.dart';
import 'package:pstb/utils/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/models/user_his_model.dart';
import '../utils/sessions/local_secure.dart';

class ProfilePersonalService {
  final ApiBaseHelper baseHelper;
  final Future<SharedPreferences> sharedPreferences;
  final _secure = FlutterSecure();
  ProfilePersonalService(
      {required this.baseHelper, required this.sharedPreferences});

  Future<bool> checkStatusCode(
      {required String code, required String password}) async {
    try {
      // final data = await baseHelper
      //     .get(ApiUrl.getAccountStaff, {'code': code, 'password': password});
      // return data != null;
      final data = await baseHelper.post(
        ApiUrl.staffReferenceAccount,
        jsonEncode(StaffModel(code, password).toJson()),
      );
      print(jsonEncode(StaffModel(code, password).toJson()));
      var nurseModel = NurseModel.fromJson(data);
      print("nurse ${nurseModel.toJson()}");
      var name = nurseModel.name;
      saveNameNursing(name: name ?? "");
      // await _secure.writeKeyStorage(
      //     key: Constants.keyUNSign, value: nurseModel.unSign ?? "");
      // await _secure.writeKeyStorage(
      //     key: Constants.keyPASign, value: nurseModel.paSign ?? "");
      // await _secure.writeKeyStorage(
      //     key: Constants.keyEMSign, value: nurseModel.emSign ?? "");
      await _secure.writeKeyStorage(key: Constants.keyUNSign, value: "");
      await _secure.writeKeyStorage(key: Constants.keyPASign, value: "");
      await _secure.writeKeyStorage(key: Constants.keyEMSign, value: "");
      return data != null;
    } on AppException catch (e) {
      Fluttertoast.showToast(
          msg: e.getMessage(),
          gravity: ToastGravity.BOTTOM,
          backgroundColor: AppColors.error500);
      return false;
    }
  }

  Future<void> saveCodeNursing({required String code}) async {
    final getShared = await sharedPreferences;
    await getShared.setString(Constants.codeNursing, code);
    final userId = await getUserHisId(code: code);
    await getShared.setInt(Constants.idNursing, userId ?? -1);
  }

  Future<void> saveNameNursing({required String name}) async {
    final getShared = await sharedPreferences;
    await getShared.setString(Constants.nameNursing, name);
  }

  Future<void> savePasswordNursing({required String code}) async {
    final getShared = await sharedPreferences;
    final codeNurse = getShared.getString(Constants.codeNursing) ?? '';
    await getShared.setString(codeNurse, code);
  }

  Future<String?> getCode() async {
    final getShared = await sharedPreferences;
    return getShared.getString(Constants.codeNursing);
  }

  Future<int?> getIdNursing() async {
    final getShared = await sharedPreferences;
    return getShared.getInt(Constants.idNursing);
  }

  Future<int?> getUserHisId({required String code}) async {
    final data =
        await baseHelper.getDocs(ApiUrl.getUserHisInfo, {"userName": code});
    var nurseModel = UserHisModel.fromJson(data);
    return nurseModel.id;
  }

  Future<void> removeCodeNursing() async {
    final getShared = await sharedPreferences;
    await getShared.remove(Constants.codeNursing);
    await _secure.deleteKeyStorage(
      key: Constants.keyUNSign,
    );
    await _secure.deleteKeyStorage(
      key: Constants.keyPASign,
    );
    await _secure.deleteKeyStorage(
      key: Constants.keyEMSign,
    );
    await _secure.deleteKeyStorage(
      key: Constants.keyPinSign,
    );
  }
}
