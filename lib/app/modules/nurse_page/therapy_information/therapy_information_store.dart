import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/models/patient_model.dart';
import 'package:pstb/app/modules/nurse_page/therapy_information/detail_therapy/detail_therapy_store.dart';
import 'package:pstb/services/api_base_helper.dart';
import 'package:pstb/services/api_exception.dart';
import 'package:pstb/utils/main.dart';
import 'package:mobx/mobx.dart';

part 'therapy_information_store.g.dart';

class TherapyInformationStore = _TherapyInformationStoreBase
    with _$TherapyInformationStore;

abstract class _TherapyInformationStoreBase with Store {
  final _callApi = Modular.get<ApiBaseHelper>();
  final therapyStore = Modular.get<DetailTherapyStore>();
  String? errorMessage;

  Future<void> getPatient({String? patientCode}) async {
    errorMessage = null;
    try {
      final data =
          await _callApi.get(ApiUrl.staffPatient, {'patientCode': patientCode});
      if (data != null) {
        therapyStore.patientModel = PatientModel.fromJson(data);
      }
    } on AppException catch (e) {
      errorMessage = e.toString();
    }
  }
}
