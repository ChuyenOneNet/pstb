import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/models/paging_model.dart';
import 'package:pstb/app/modules/medical_appointment/pages/medical_package_detail/models/medical_model.dart';
import 'package:mobx/mobx.dart';
import 'package:pstb/app/modules/medical_appointment/pages/select_doctor/models/doctor_model.dart';
import 'package:pstb/services/api_base_helper.dart';
import 'package:pstb/utils/api_url.dart';

part 'doctor_info_store.g.dart';

class DoctorInfoStore = DoctorInfoStoreBase with _$DoctorInfoStore;

abstract class DoctorInfoStoreBase with Store {
  final ApiBaseHelper _apiBaseHelper = Modular.get<ApiBaseHelper>();

  // @observable
  // DoctorPagingItem? doctorData2;
  @observable
  DoctorPagingItem doctorData = DoctorPagingItem();
  @observable
  @observable
  ObservableList<PackageModel> packagesList =
      ObservableList<PackageModel>.of([]);

  @action
  Future<void> onGetDoctor(String id) async {
    try {
      EasyLoading.show();
      final response = await _apiBaseHelper.get(ApiUrl.doctors + id);
      doctorData = DoctorPagingItem.fromJson(response);
      print('${doctorData.id}');
      EasyLoading.dismiss();
    } catch (e) {
      print('e');
      EasyLoading.dismiss();
    }
  }

  @action
  Future<void> setDoctor(DoctorPagingItem doctor) async {
    doctorData = doctor;
  }

  @action
  Future<void> getMedicalService(int id) async {
    EasyLoading.show();
    packagesList.clear();
    try {
      final response =
          await _apiBaseHelper.get('${ApiUrl.medicalServiceDoctor}/$id');
      final packagePaging = Paging<PackageModel>.fromJson(response, (item) {
        return PackageModel.fromJson(item);
      });
      final packages = packagePaging.items;
      if (packages == null || packages.isEmpty) {
        EasyLoading.dismiss();
        return;
      }
      for (var item in packages) {
        packagesList.add(item);
      }
      EasyLoading.dismiss();
    } catch (e) {
      print('e');
      EasyLoading.dismiss();
    }
  }
}
