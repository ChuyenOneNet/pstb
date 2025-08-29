import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:pstb/app/modules/medical_appointment/medical_appointment_store.dart';
import 'package:pstb/app/modules/medical_appointment/pages/confirm_and_payment/models/booking_info.dart';
import 'package:pstb/app/modules/medical_appointment/pages/confirm_and_payment/widgets/card_personal_widget.dart';
import 'package:pstb/app/modules/medical_appointment/pages/confirm_and_payment/widgets/dialog_birthday_widget.dart';
import 'package:pstb/app/modules/medical_appointment/pages/confirm_and_payment/widgets/infor_unit.dart';
import 'package:pstb/app/modules/medical_appointment/pages/doctor_info/doctor_info_store.dart';
import 'package:pstb/app/modules/medical_appointment/pages/medical_date_picker/medical_store.dart';
import 'package:pstb/app/modules/medical_appointment/pages/medical_date_picker/widget/type_gender_widget.dart';
import 'package:pstb/app/user_app_store.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateful/stateful_widget.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';
import '../../../../../widgets/stateful/payment/payment_price.dart';
import 'confirm_and_payment_store.dart';
import 'widgets/header_bill_widget.dart';

class ConfirmAndPaymentPage extends StatefulWidget {
  const ConfirmAndPaymentPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ConfirmAndPaymentPageState();
  }
}

class ConfirmAndPaymentPageState extends State<ConfirmAndPaymentPage> {
  final ConfirmAndPaymentStore _store = ConfirmAndPaymentStore();
  final DoctorInfoStore _doctorInfoStore = Modular.get<DoctorInfoStore>();
  final MedicalStore _medicalStore = Modular.get<MedicalStore>();
  final _userAppStore = Modular.get<UserAppStore>();
  final MedicalAppointmentStore _medicalAppointmentStore =
      Modular.get<MedicalAppointmentStore>();

  @override
  void initState() {
    _store.changeBuildContext(context);
    _store.getDiscount();
    _store.onChangePaymentInfo(
      BookingInfo(
        doctorId: _doctorInfoStore.doctorData.id,
        doctorName: _doctorInfoStore.doctorData.name,
        packageId: _medicalAppointmentStore.selectedPackage.id ?? 0,
        packageName: _medicalAppointmentStore.selectedPackage.name ?? "",
        timeSeeDoctor: _medicalStore.getTimeSeeDoctor,
        covidDeclaration: _medicalAppointmentStore.getCovidDeclaration(),
        address: _medicalStore.aLocationPicked != null
            ? Constants.showAddress([
                _medicalStore.aLocationPicked!.address,
                _medicalStore.aLocationPicked!.district,
                _medicalStore.aLocationPicked!.province
              ])
            : "Online",
        timeGetSample: _medicalStore.getTimeGetResult,
        idCost: '-1',
        cost: _medicalAppointmentStore.selectedPackage.price ?? 0,
        discount: 0,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparent,
      appBar: CustomAppBar(
        title: 'Xác nhận đặt lịch',
        isBack: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Observer(
          builder: (_) {
            if (_store.loadingDiscount) {
              return const Center(
                child: AppCircleLoading(),
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      height: 16.0,
                    ),
                    InformationUnit(),
                    const SizedBox(
                      height: 16.0,
                    ),
                    ExaminationPackageInfo(
                      paymentInfo: _store.bookingInfo,
                    ),
                    CardPersonalWidget(
                      dob: _medicalStore.dob,
                      name: _medicalStore.namePersonal,
                      personalId: _medicalStore.personalId,
                      phoneNumber: _medicalStore.phoneNumber,
                      insuranceNumber: _medicalStore.insuranceNumber,
                      gender: _medicalStore.genderType == GenderType.f
                          ? 'Nữ'
                          : 'Nam',
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    HeaderBillWidget(
                      name: _userAppStore.getUserName,
                      date: DateFormat(DateTimeFormatPattern.formatddMMyyyy)
                          .format(
                              _medicalStore.getTimeSeeDoctor ?? DateTime.now()),
                      timer: DateFormat(DateTimeFormatPattern.formatHHmm)
                          .format(
                              _medicalStore.getTimeSeeDoctor ?? DateTime.now()),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: Styles.cardShadow.copyWith(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.all(16),
                      child: Observer(
                        builder: (context) => BuildPaymentPrice(
                          title: l10n(context)!
                              .comfirm_and_payment_make_an_appointment,
                          iconRight: IconEnums.arrowRight,
                          cost: _store.bookingInfo.cost,
                          discount: _store.discountApplies.discount,
                          isDisable: _store.realPrice <= 0,
                          realPrice: _store.realPrice,
                          iconLeft: IconEnums.calendar,
                          onPressed: () => _store.booking(),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const Spacer(
                          flex: 1,
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 12.0),
                            child: AppButton(
                              labelStyle: Styles.content.copyWith(
                                color: AppColors.background,
                              ),
                              title: 'Hoàn tất đặt lịch',
                              onPressed: () async {
                                final _userAppStore =
                                    Modular.get<UserAppStore>();
                                if (_userAppStore.getUserDob.isEmpty) {
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (_) {
                                        return AlertDialog(
                                            actions: [DialogBirthdayWidget()]);
                                      });
                                } else {
                                  await _store.booking();
                                }
                              },
                            ),
                          ),
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
