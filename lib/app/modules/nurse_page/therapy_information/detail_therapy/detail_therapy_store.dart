import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/models/command_model.dart';
import 'package:pstb/app/models/nurse_model.dart';
import 'package:pstb/app/models/patient_model.dart';
import 'package:pstb/services/api_base_helper.dart';
import 'package:pstb/utils/api_url.dart';
import 'package:pstb/utils/time_util.dart';
import 'package:mobx/mobx.dart';

part 'detail_therapy_store.g.dart';

class DetailTherapyStore = _DetailTherapyStoreBase with _$DetailTherapyStore;

abstract class _DetailTherapyStoreBase with Store {
  // PatientModel? patientModel;
  final _callApi = Modular.get<ApiBaseHelper>();

  @observable
  List<CommandModel> commandData = [];
  @observable
  PatientModel patientModel = PatientModel();
  @observable
  List<NurseModel> healthCareData = [];
  String? id;
  @observable
  DateTime dateTimeSelected = DateTime.now();
  @observable
  int currentIndex = 0;

  @action
  void onChangeIndex(int index) {
    currentIndex = index;
    dateTimeSelected = DateTime.now().subtract(Duration(days: index));
    getScheduleTreatment(id ?? "", getDate: dateTimeSelected);
  }

  Future<void> getScheduleTreatment(String id, {DateTime? getDate}) async {
    this.id = id;
    final response = await _callApi.get(ApiUrl.getTreatment, {
      "PatientCode": id,
      "DateTime": TimeUtil.toBackendString(getDate ?? DateTime.now())
    });
    if (response["medicalInstructions"] != null) {
      commandData = (response["medicalInstructions"] as List)
          .map((e) => CommandModel.fromJson(e))
          .toList();
    }
    if (response["healthCares"] != null) {
      healthCareData = (response["healthCares"] as List)
          .map((e) => NurseModel.fromJson(e))
          .toList();
    }
  }

  @action
  Future<void> onRefresh() async {
    currentIndex = 0;
    await getScheduleTreatment(id ?? "");
  }
}
