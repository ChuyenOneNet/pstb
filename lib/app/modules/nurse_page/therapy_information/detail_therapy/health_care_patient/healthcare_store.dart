import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/models/nurse_model.dart';
import 'package:pstb/services/api_base_helper.dart';
import 'package:pstb/utils/api_url.dart';
import 'package:mobx/mobx.dart';

part 'healthcare_store.g.dart';

class HealthCareStore = _HealthCareStoreBase with _$HealthCareStore;

abstract class _HealthCareStoreBase with Store {
  @observable
  NurseModel? nurseModel;
  final _callApi = Modular.get<ApiBaseHelper>();
  String? id;

  Future<void> getDetailHealthCare() async {
    // id = Modular.args?.data["id"];
    final response = await _callApi.get(ApiUrl.getHealthCare, {
      "id": id,
    });
    if (response != null) {
      nurseModel = NurseModel.fromJson(response);
    }
  }
}
