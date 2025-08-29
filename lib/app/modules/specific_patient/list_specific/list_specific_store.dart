import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/models/department_model.dart';
import 'package:pstb/app/models/paging_model.dart';
import 'package:pstb/app/models/patient_model.dart';
import 'package:pstb/app/models/registration_model.dart';
import 'package:pstb/services/api_exception.dart';
import 'package:pstb/services/registration_service.dart';
import 'package:pstb/utils/main.dart';
import 'package:mobx/mobx.dart';

part 'list_specific_store.g.dart';

class ListSpecificStore = ListSpecificStoreBase with _$ListSpecificStore;

abstract class ListSpecificStoreBase with Store {
  final _service = Modular.get<RegistrationService>();

  @observable
  bool isLoading = false;
  DepartmentModel? departmentModel;
  PatientQrModel? patientQrModel;
  @observable
  int currentIndex = 0;
  String? errorMessage;
  String registrationId = '';
  @observable
  Map<String, Paging<RegistrationModel>?> listGroupByStatus = {};

  Future<void> initState(
      {required String id,
      PatientQrModel? patientQrModel,
      DepartmentModel? departmentModel}) async {
    isLoading = true;
    registrationId = id;
    this.departmentModel = departmentModel;
    this.patientQrModel = patientQrModel;
    try {
      final firstListRegistration = await _service.getListRegistration(
          registrationId: id,
          status: Constants.listStatusSpecific[
              Constants.listStatusSpecific.keys.toList()[0]]);
      listGroupByStatus[Constants.listStatusSpecific.keys.toList()[0]] =
          firstListRegistration;
      // ..items!.removeWhere((element) => element.status == 4);
      isLoading = false;
    } on AppException catch (e) {
      isLoading = false;
      listGroupByStatus[Constants.listStatusSpecific.keys.toList()[0]] = null;
      errorMessage = e.toString();
    }
  }

  @action
  Future<void> onChangeTab(int indexSelected) async {
    isLoading = true;
    currentIndex = indexSelected;
    try {
      final filterListRegistrations = await _service.getListRegistration(
          registrationId: registrationId,
          status: Constants.listStatusSpecific[
              Constants.listStatusSpecific.keys.toList()[indexSelected]]);
      listGroupByStatus[Constants.listStatusSpecific.keys
          .toList()[indexSelected]] = filterListRegistrations;
      // ..items!.removeWhere((element) => element.status == 4);
      isLoading = false;
    } on AppException catch (e) {
      isLoading = false;
      listGroupByStatus[
          Constants.listStatusSpecific.keys.toList()[indexSelected]] = null;
      errorMessage = e.toString();
    }
  }

  @action
  Future<void> loadMore() async {
    if (listGroupByStatus[
            Constants.listStatusSpecific.keys.toList()[currentIndex]]!
        .isEnded()) return;
    listGroupByStatus[Constants.listStatusSpecific.keys.toList()[currentIndex]]!
        .pageIndex = listGroupByStatus[
                Constants.listStatusSpecific.keys.toList()[currentIndex]]!
            .pageIndex! +
        1;
    try {
      isLoading = true;
      final filterListRegistrations = await _service.getListRegistration(
          registrationId: registrationId,
          status: Constants.listStatusSpecific[
              Constants.listStatusSpecific.keys.toList()[currentIndex]],
          pageIndex: listGroupByStatus[
                  Constants.listStatusSpecific.keys.toList()[currentIndex]]!
              .pageIndex);
      listGroupByStatus[
              Constants.listStatusSpecific.keys.toList()[currentIndex]]!
          .items!
          .addAll(filterListRegistrations.items!);
      isLoading = false;
    } on AppException catch (e) {
      isLoading = false;
      listGroupByStatus[
              Constants.listStatusSpecific.keys.toList()[currentIndex]]!
          .items!
          .addAll([]);
      errorMessage = e.toString();
    }
  }
}
