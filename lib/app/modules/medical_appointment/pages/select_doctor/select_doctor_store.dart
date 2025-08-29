import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/models/paging_model.dart';
import 'package:mobx/mobx.dart';
import 'package:pstb/app/modules/medical_appointment/pages/select_doctor/models/get_doctor_model.dart';
import 'package:pstb/services/api_base_helper.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';
import '../../../../../utils/sessions/session_prefs.dart';
import 'models/doctor_model.dart';

part 'select_doctor_store.g.dart';

class SelectDoctorStore = _SelectDoctorStoreBase with _$SelectDoctorStore;

abstract class _SelectDoctorStoreBase with Store {
  final ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  int pageSize = 10;
  bool isEnd = false;
  @observable
  int totals = 0;
  @observable
  List<String> keywordSearch = [];
  @observable
  String keyword = "";
  @observable
  int pageIndex = 0;
  @observable
  int idDoctor = 0;
  @observable
  int medicalUnitId = 0;
  @observable
  DoctorPagingItem doctor = DoctorPagingItem();
  @observable
  ObservableList<DoctorPagingItem> listDoctor =
      ObservableList<DoctorPagingItem>.of([]);
  @observable
  ObservableList<DoctorPagingItem> listDoctorSearch =
      ObservableList<DoctorPagingItem>.of([]);
  late BuildContext mContext;
  @action
  void createBuildContext(BuildContext newContext) {
    mContext = newContext;
  }

  @computed
  int get lengthListDoctor => listDoctor.length;

  @computed
  bool get isFinishLoadMore => listDoctor.length >= totals;

  @action
  Future<void> onGetListDoctor(String packageDoctorsName) async {
    try {
      EasyLoading.show();
      medicalUnitId = await SessionPrefs.getMedicalUnitId() ?? 0;
      await _getDoctors(pageIndex, pageSize, medicalUnitId);
    } catch (e) {
      print(e);
    } finally {
      EasyLoading.dismiss();
    }
  }

  _getDoctors(
    int pageIndex,
    int pageSize,
    int medicalUnitId,
  ) async {
    if (isEnd) return;
    SearchDoctorModel doctorModel = SearchDoctorModel(
        pageSize: pageSize, pageIndex: pageIndex, MedicalUnitId: medicalUnitId);
    Map<String, dynamic> params = {};
    params.addAll(doctorModel.toJson());
    final response = await _apiBaseHelper.get(
      ApiUrl.doctors,
      params,
    );

    final doctorPaging =
        Paging.fromJson(response, (e) => DoctorPagingItem.fromJson(e));
    if (!doctorPaging.isEnded()) {
      pageIndex = pageIndex + 1;
    } else {
      isEnd = true;
    }
    totals =
        doctorPaging.count == null ? doctorPaging.total! : doctorPaging.count!;
    for (var element in doctorPaging.items!) {
      listDoctor.add(element);
    }
  }

  @action
  Future<void> getSearchDoctor(String value) async {
    try {
      EasyLoading.show();
      if (isEnd) return;
      SearchDoctorModel doctorModel = SearchDoctorModel(
          pageSize: pageSize,
          pageIndex: pageIndex,
          MedicalUnitId: medicalUnitId);
      Map<String, dynamic> params = {};
      params.addAll(doctorModel.toJson());
      params.addAll({"keyword": value});
      final response = await _apiBaseHelper.get(
        ApiUrl.doctors,
        params,
      );
      final doctorPaging =
          Paging.fromJson(response, (e) => DoctorPagingItem.fromJson(e));
      if (!doctorPaging.isEnded()) {
        pageIndex = pageIndex + 1;
      } else {
        isEnd = true;
      }
      totals = doctorPaging.count == null
          ? doctorPaging.total!
          : doctorPaging.count!;
      for (var element in doctorPaging.items!) {
        listDoctorSearch.add(element);
      }
    } catch (e) {
      print(e);
    } finally {
      EasyLoading.dismiss();
    }
  }

  @action
  void navigateTo(String routeName, int id) {
    Modular.to.pushNamed(routeName, arguments: id);
  }

  @action
  Future<bool> onLoadMore() async {
    // await _getDoctors(pageIndex, pageSize);
    return true;
  }

  @action
  Future<void> onRefresh(String packageDoctorsName) async {
    listDoctor = ObservableList<DoctorPagingItem>.of([]);
    totals = 0;
    pageIndex = 0;
    isEnd = false;
    await onGetListDoctor(packageDoctorsName);
  }
}
