import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pstb/app/models/medical_unit/detail_hospital_model.dart';
import 'package:mobx/mobx.dart';

import '../../../services/api_base_helper.dart';
import '../../../utils/api_url.dart';
import '../../../utils/helpers/firebase_config.dart';
import '../../../utils/sessions/session_prefs.dart';
import '../../models/medical_unit/hospital_unit_model.dart';
import '../../models/paging_model.dart';

part 'selection_hospital_store.g.dart';

class SelectionHospitalStore = _SelectionHospitalStoreBase
    with _$SelectionHospitalStore;

abstract class _SelectionHospitalStoreBase with Store {
  final ApiBaseHelper apiBaseHelper = ApiBaseHelper();
  late final HospitalModel hospitalModel;
  // late final UnitProminentModel unitProminentModel;

  @observable
  bool isLoading = true;
  @observable
  bool isChoose = false;
  @observable
  int slideNo = 0;
  @observable
  List<HospitalModel> listHospital = ObservableList<HospitalModel>.of([]);
  @observable
  DetailHospitalModel detailHospital = DetailHospitalModel();
  @observable
  List<bool> checked = ObservableList<bool>.of([]);

  @observable
  List<HospitalModel> listUnitProminent = ObservableList<HospitalModel>.of([]);

  @action
  Future<void> getHospitals(bool forced) async {
    isLoading = true;
    EasyLoading.show();
    if (!forced) {
      if (listHospital.isNotEmpty) {
        await checkUnitChoose();
        EasyLoading.dismiss();
        isLoading = false;
        return;
      }
    }
    listHospital.clear();
    try {
      // servertest
      final response = await apiBaseHelper.get(ApiUrl.getMedicalUnit);
      final hospitalPaging = Paging<HospitalModel>.fromJson(response, (item) {
        return HospitalModel.fromJson(item);
      });
      listHospital.addAll(hospitalPaging.items!);
    } catch (e) {
      print(e);
    }
    isLoading = false;
    EasyLoading.dismiss();
  }

  @action
  Future<void> checkUnitChoose() async {
    isChoose = true;
    final id = await SessionPrefs.getMedicalUnitId();
    for (var element in listHospital) {
      if (id == element.id) {
        element.status = true;
        element.isChoose = true;
      }
    }
    // for (var element in listUnitProminent) {
    //   if (id == element.id) {
    //     element.status = true;
    //   }
    // }
    isChoose = false;
  }

  @action
  Future<void> getUnitProminent() async {
    isLoading = true;
    EasyLoading.show();
    listUnitProminent.clear();
    try {
      // servertest
      final response = await apiBaseHelper.get(ApiUrl.getUnitProminent);
      final ProminentPaging = Paging<HospitalModel>.fromJson(response, (item) {
        return HospitalModel.fromJson(item);
      });
      listUnitProminent.addAll(ProminentPaging.items!);
    } catch (e) {
      isLoading = false;
      EasyLoading.dismiss();
    }
    isLoading = false;
    EasyLoading.dismiss();
  }

  @action
  void changeNews(indexOfPage) {
    slideNo = indexOfPage;
  }
}
