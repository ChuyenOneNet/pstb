import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:pstb/app/models/declaration_form_info.dart';
import 'package:pstb/app/models/patient_model.dart';
import 'package:pstb/app/models/qr_code_model.dart';
import 'package:pstb/app/modules/medical_appointment/pages/medical_date_picker/medical_store.dart';
import 'package:pstb/services/api_exception.dart';
import 'package:pstb/utils/gender_utils.dart';
import 'package:mobx/mobx.dart';
import 'package:pstb/services/api_base_helper.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';

import '../../../home/home_store.dart';
import '../medical_package_detail/medical_package_detail_store.dart';
import 'models/discount_code.dart';
import 'models/booking_info.dart';

part 'confirm_and_payment_store.g.dart';

class ConfirmAndPaymentStore = ConfirmAndPaymentStoreBase
    with _$ConfirmAndPaymentStore;

abstract class ConfirmAndPaymentStoreBase with Store {
  late BuildContext mContext;
  late final ApiBaseHelper _apiBaseHelper = ApiBaseHelper();
  final MedicalPackageDetailStore _medicalPackageDetailStore =
      Modular.get<MedicalPackageDetailStore>();
  final _homeStore = Modular.get<HomeStore>();
  final _medicalStore = Modular.get<MedicalStore>();
  @observable
  BookingInfo bookingInfo = BookingInfo(
    doctorId: 1,
    packageName: 'Gói khám sức khoẻ cơ bản',
    doctorName: 'Bs. Nguyễn Văn Toàn',
    timeSeeDoctor: DateTime.now(),
    address: 'Tầng 6 số 22 Thành Công, Ba Đì...',
    timeGetSample: DateTime.now(),
    idCost: "300000.00",
    cost: 300000,
    discount: 20000,
    packageId: 1,
  );

  @observable
  List<DiscountCode> listDiscountCode = [];
  @observable
  QrCodeModel qrCodeModel = QrCodeModel();
  List<DiscountCode> listDiscountCodeData = [];

  @observable
  bool isInvoice = true;

  @observable
  DiscountCode discountApplies = DiscountCode("", DateTime.now(), '', 0);

  @observable
  String discountDialogId = "";

  @computed
  int get realPrice => bookingInfo.cost - discountApplies.discount;

  @computed
  List<DiscountCode> get getListDiscountCodeActive => listDiscountCode
      .where((element) =>
          DateTime.now().difference(element.expiryDate).inDays <= 0)
      .toList();

  @computed
  List<DiscountCode> get getListDiscountCodeInActive => listDiscountCode
      .where(
          (element) => DateTime.now().difference(element.expiryDate).inDays > 0)
      .toList();

  @action
  void onChangePaymentInfo(BookingInfo value) {
    bookingInfo = value;
  }

  @action
  void navigateTo(String route) {
    Modular.to.pushNamed(route);
  }

  @action
  void onCheckInvoice() {
    isInvoice = !isInvoice;
  }

  @action
  void onSaveListDiscount(List<DiscountCode> list) {
    listDiscountCode = list;
  }

  @action
  void onApplyDiscount() {
    discountApplies = listDiscountCode.firstWhere((item) {
      debugPrint("discountDialogId" + item.title);
      return item.uid == discountDialogId;
    });
  }

  @action
  void onSaveDiscordDialogId(String id) {
    discountDialogId = id;
  }

//Bill
  @observable
  String nameCompany = "";

  @action
  void changeNameCompany(String value) {
    nameCompany = value;
  }

  @observable
  String locationCompany = "";

  @action
  void changeLocationCompany(String value) {
    locationCompany = value;
  }

  @observable
  String taxCode = "";

  @action
  void changeTaxCode(String value) {
    taxCode = value;
  }

  @action
  void onSearch(String text) {
    if (text == '') {
      listDiscountCode = listDiscountCodeData;
    } else {
      listDiscountCode = listDiscountCodeData
          .where((element) => element.title.contains(text))
          .toList();
    }
  }

  String _getInfoExam() {
    DeclarationFormInfo info = DeclarationFormInfo();
    info.name = _medicalPackageDetailStore.textNameController.text;
    info.dob = _medicalPackageDetailStore.textDOBController.text;
    info.phone = _medicalPackageDetailStore.textPhoneController.text;
    info.relative = _medicalPackageDetailStore.relation == Relation.relative
        ? 'Người thân'
        : 'Cá nhân';
    info.province = _medicalPackageDetailStore.textProvinceController.text;
    info.district = _medicalPackageDetailStore.textDistrictController.text;
    info.address = _medicalPackageDetailStore.textAddressController.text;
    info.symptom = _medicalPackageDetailStore.textSymptomController.text;
    info.gender = _medicalPackageDetailStore.gender;
    return info.toRawJson();
  }

  String _getInfoTest() {
    DeclarationFormInfo info = DeclarationFormInfo();
    info.name = _medicalPackageDetailStore.textNameController.text;
    info.dob = _medicalPackageDetailStore.textDOBController.text;
    info.phone = _medicalPackageDetailStore.textPhoneController.text;
    info.relative = _medicalPackageDetailStore.relation == Relation.relative
        ? 'Người thân'
        : 'Cá nhân';
    info.province = _medicalPackageDetailStore.textProvinceController.text;
    info.district = _medicalPackageDetailStore.textDistrictController.text;
    info.address = _medicalPackageDetailStore.textAddressController.text;
    info.gender = _medicalPackageDetailStore.gender;
    return info.toRawJson();
  }

  @action
  Future<void> booking() async {
    EasyLoading.show();
    try {
      var json = jsonEncode({
        "doctorId": bookingInfo.doctorId,
        "packageId": bookingInfo.packageId,
        "price": bookingInfo.cost,
        "covidDeclaration": bookingInfo.covidDeclaration,
        "address": bookingInfo.address,
        "timeSeeDoctor": bookingInfo.timeSeeDoctor != null
            ? DateFormat(DateTimeFormatPattern.backendTimeFormat)
                .format(bookingInfo.timeSeeDoctor!)
            : "",
        "timeGetSample": bookingInfo.timeGetSample != null
            ? DateFormat(DateTimeFormatPattern.backendTimeFormat)
                .format(bookingInfo.timeGetSample!)
            : "",
        "getSampleAtHomeDeclaration": _getInfoTest(),
        "getExamAtHomeDeclaration": _getInfoExam(),
        "for": Constants.selfChangeNumber[_medicalStore.personalType],
        "patient": PatientBookingModel(
                name: _medicalStore.namePersonal,
                personalId: _medicalStore.personalId,
                phone: _medicalStore.phoneNumber,
                insuranceNumber: _medicalStore.insuranceNumber,
                gender:
                    GenderUtils.parseGenderBackend(_medicalStore.genderType),
                dob: _medicalStore.dob.isNotEmpty
                    ? DateFormat(DateTimeFormatPattern.backendTimeFormat)
                        .format(DateFormat(DateTimeFormatPattern.dobddMMyyyy)
                            .parse(_medicalStore.dob))
                    : null)
            .toJson()
      });
      final data = await _apiBaseHelper.post(ApiUrl.appointment, json);
      qrCodeModel = QrCodeModel.fromJson(data);
      _homeStore.totalComingBooking++;
      _homeStore.firstTimeBooking = bookingInfo.timeSeeDoctor != null
          ? DateFormat(DateTimeFormatPattern.backendTimeFormat)
              .format(bookingInfo.timeSeeDoctor!)
          : DateFormat(DateTimeFormatPattern.backendTimeFormat)
              .format(bookingInfo.timeGetSample!);
      Modular.to.pushNamed(AppRoutes.medicalConfirmAndSuccess,
          arguments: {'code': qrCodeModel.code, "qrCode": qrCodeModel.qrCode});
      EasyLoading.dismiss();
    } on AppException catch (e) {
      if (kDebugMode) {
        print(e.getMessage());
      }
      EasyLoading.dismiss();
      AppSnackBar.show(
        mContext,
        AppSnackBarType.Error,
        e.toString(),
      );
    } catch (e) {
      EasyLoading.dismiss();
      AppSnackBar.show(
        mContext,
        AppSnackBarType.Error,
        e.toString(),
      );
    }
  }

  @observable
  bool loadingDiscount = true;

  @action
  Future<void> getDiscount() async {
    loadingDiscount = true;
    // try {
    //   final response = await _apiBaseHelper.post(
    //     ApiUrl.discout,
    //     DiscountModel(
    //       denNgay: DateTime.now(),
    //       tuNgay: DateTime.now(),
    //     ).toRawJson(),
    //   );
    //
    //   DiscountResponsitory discount = DiscountResponsitory.fromJson(response);
    //   discount.data!.forEach((element) {
    //     listDiscountCodeData.add(DiscountCode(
    //       element.maCtkm!,
    //       element.hanSuDungDen!,
    //       element.tenCtkm!,
    //       0,
    //     ));
    //   });
    //   listDiscountCode = listDiscountCodeData;
    // } catch (e) {
    //   AppSnackBar.show(
    //     context,
    //     AppSnackBarType.Error,
    //     l10n(context)!.wrong_when_try!,
    //   );
    // }
    loadingDiscount = false;
    EasyLoading.dismiss();
  }

  @action
  void changeBuildContext(BuildContext newContext) {
    mContext = newContext;
  }
}
