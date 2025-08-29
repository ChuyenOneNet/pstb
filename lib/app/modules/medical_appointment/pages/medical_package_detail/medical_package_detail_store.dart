import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/medical_appointment/pages/medical_package_detail/models/medical_model.dart';
import 'package:pstb/app/models/packages_model.dart';
import 'package:pstb/services/api_base_helper.dart';
import 'package:pstb/services/api_exception.dart';
import 'package:pstb/utils/main.dart';
import 'package:mobx/mobx.dart';

import '../../../../models/paging_model.dart';
import '../../medical_appointment_store.dart';
import 'models/new_medical_package_details_model.dart';

part 'medical_package_detail_store.g.dart';

enum Relation { individual, relative }

class MedicalPackageDetailStore = MedicalPackageDetailStoreBase
    with _$MedicalPackageDetailStore;

abstract class MedicalPackageDetailStoreBase with Store implements Disposable {
  final _apiBaseHelper = Modular.get<ApiBaseHelper>();
  final MedicalAppointmentStore _appointmentStore =
      Modular.get<MedicalAppointmentStore>();

  @observable
  String gender = "m";

  @action
  void changeGender(String g) => gender = g;

  @observable
  Relation relation = Relation.relative;

  @action
  void changeRelation(Relation r) => relation = r;

  final TextEditingController textNameController = TextEditingController();
  final TextEditingController textDOBController = TextEditingController();
  final TextEditingController textPhoneController = TextEditingController();

  // final TextEditingController textRelationController = TextEditingController();
  final TextEditingController textProvinceController = TextEditingController();
  final TextEditingController textDistrictController = TextEditingController();
  final TextEditingController textAddressController = TextEditingController();
  final TextEditingController textSymptomController = TextEditingController();

  @override
  void dispose() {
    // scrollController.dispose();
  }

  BuildContext? mContext;
  final ScrollController scrollController = ScrollController();

  @observable
  int count = 0;

  @observable
  bool loadingOther = true;

  @observable
  Package package = Package();

  @observable
  PackageModel details = PackageModel();

  @observable
  ObservableList<NewMedicalPackageDetailModel> otherPackages =
      ObservableList<NewMedicalPackageDetailModel>.of([]);

  @observable
  bool scrollIsReached = false;

  @action
  void createBuildContext(BuildContext newContext) {
    mContext = newContext;
  }

  @action
  void scrollListener(double height) {
    if (scrollController.offset >= height && !scrollIsReached) {
      scrollIsReached = true;
    }
    if (scrollController.offset < height && scrollIsReached) {
      scrollIsReached = false;
    }
  }

  @action
  void addListener(BuildContext newContext, double height) {
    createBuildContext(newContext);
    scrollController.addListener(() => scrollListener(height));
  }

  @computed
  List<ExaminationProcedure>? get sortedProcedure {
    final procedure = package.examinationProcedure!;
    procedure.sort((a, b) => a.number!.compareTo(b.number!));
    return procedure;
  }

  @computed
  bool get isCovidPackage {
    return package.isCovidPackage();
  }

  bool get isGetSample {
    return package.isGetSample ?? false;
  }

  bool get isSeeDoctor => package.isSeeDoctor ?? false;

  @action
  void navigateTo(String routeName) {
    Modular.to.pushNamed(routeName);
  }

  @observable
  bool loadingPackageDetail = true;

  void nextPage() {
    if (_appointmentStore.selectedPackage.isChoiceDoctor ?? false) {
      Modular.to.pushNamed(AppRoutes.selectDoctor);
    } else {
      if (_appointmentStore.selectedPackage.isSeeDoctor ?? false) {
        Modular.to.pushNamed(AppRoutes.medicalTimeVisitDoctor,
            arguments: {"doctorId": null, "booking": null});
      } else if (_appointmentStore.selectedPackage.isGetSample ?? false) {
        Modular.to.pushNamed(AppRoutes.medicalTimeGetResultTest);
      }
    }
  }

  void nextPageWithPostInfo() {
    if (_appointmentStore.testAtHome) {
      Modular.to.pushNamed(AppRoutes.postInfoTestPage);
      return;
    } else {
      Modular.to.pushNamed(AppRoutes.postInfoExamPage);
      return;
    }
  }

  @action
  Future<void> getBookingAdvisory(int packageId) async {
    // EasyLoading.show();
    // final response = await _apiBaseHelper.get("${ApiUrl.advisory}$packageId");
    // final responsitory = PackagePagingItem.fromJson(response);
    // package = responsitory;
    // EasyLoading.dismiss();
    // loadingPackageDetail = false;
  }

  @action
  Future<void> getPackageDetail(int? id) async {
    EasyLoading.show();
    try {
      // final response = await _apiBaseHelper.get("${ApiUrl.packageDetail}${id}");

      loadingPackageDetail = false;
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      // AppSnackBar.show(
      //   mContext,
      //   AppSnackBarType.Error,
      //   e.toString(),
      // );
    }
  }

  @action
  void setDetailsPackage(PackageModel data) {
    details = data;
  }

  @action
  Future<void> getNewPackageDetail(int id) async {
    loadingPackageDetail = true;
    EasyLoading.show();
    try {
      final response =
          await _apiBaseHelper.get(ApiUrl.packageDetail, {'parentId': id});
      final dataRes = Paging<NewMedicalPackageDetailModel>.fromJson(
          response, (item) => NewMedicalPackageDetailModel.fromJson(item));
      if (dataRes.items!.isEmpty) {
        //Todo check lai
        final response2 =
            await _apiBaseHelper.get("${ApiUrl.packageDetail}${id}");
        final data = NewMedicalPackageDetailModel.fromJson(response2);
        otherPackages.add(data);
        count += data.count ?? 0;
      } else {
        for (var item in dataRes.items!) {
          final response =
              await _apiBaseHelper.get("${ApiUrl.packageDetail}${item.id}");
          final data = NewMedicalPackageDetailModel.fromJson(response);
          otherPackages.add(data);
          count += data.count ?? 0;
        }
      }
      loadingPackageDetail = false;
      EasyLoading.dismiss();
    } on AppException catch (e) {
      EasyLoading.dismiss();
      // AppSnackBar.show(
      //   mContext,
      //   AppSnackBarType.Error,
      //   e.toString(),
      // );
      print(e.toString());
    } catch (e) {
      EasyLoading.dismiss();
      // AppSnackBar.show(
      //   mContext,
      //   AppSnackBarType.Error,
      //   e.toString(),
      // );
      print(e.toString());
    }
  }
}
