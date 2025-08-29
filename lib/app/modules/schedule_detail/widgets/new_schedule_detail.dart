import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:pstb/app/modules/medical_appointment/pages/confirm_and_payment/widgets/infor_unit.dart';
import 'package:pstb/app/modules/schedule_detail/widgets/schedule_examination_package_info.dart';
import 'package:pstb/utils/colors.dart';
import 'package:pstb/utils/gender_utils.dart';
import 'package:pstb/utils/styles.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/icons.dart';
import '../../../../utils/l10n.dart';
import '../../../../widgets/stateful/payment/payment_price.dart';
import '../../../user_app_store.dart';
import '../../medical_appointment/pages/confirm_and_payment/widgets/card_personal_widget.dart';
import '../../medical_appointment/pages/confirm_and_payment/widgets/date_time_booking_widget.dart';
import '../../medical_appointment/pages/confirm_and_payment/widgets/header_bill_widget.dart';
import '../../medical_appointment/pages/confirm_and_payment/widgets/method_payment_widget.dart';
import '../../medical_appointment/pages/confirm_and_payment/widgets/qr_code_widget.dart';
import '../../schedule/schedule_store.dart';
import '../schedule_detail_store.dart';

class NewScheduleDetail extends StatelessWidget {
  NewScheduleDetail({Key? key}) : super(key: key);

  final _userAppStore = Modular.get<UserAppStore>();
  final ScheduleDetailStore controller = Modular.get<ScheduleDetailStore>();
  final ScheduleStore scheduleStore = Modular.get<ScheduleStore>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      child: Observer(
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InformationUnit(
                  imageQr:
                      base64.decode(controller.bookingDetail?.qrCode ?? ''),
                  status: scheduleStore.status,
                ),
                const SizedBox(
                  height: 16,
                ),
                ScheduleExaminationPackageInfo(),
                Column(
                  children: [
                    CardPersonalWidget(
                      patientId: controller.bookingDetail?.patientId ?? 0,
                      phoneNumber: controller.bookingDetail?.patientPhone,
                      gender: GenderUtils.parseGender(
                          controller.bookingDetail?.patientGender ?? 0),
                      dob: DateFormat(DateTimeFormatPattern.formatddMMyyyy)
                          .format(controller.bookingDetail?.patientDob ??
                              DateTime.now()),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    HeaderBillWidget(
                      codeBill: controller.bookingDetail?.code ?? '',
                      name: _userAppStore.getUserName,
                      idPatient: controller.bookingDetail?.patientId ?? 0,
                      status: scheduleStore.status,
                      date: controller.scheduleExamTimeDate,
                      timer: controller.scheduleExamTimeHour,
                      imageQr:
                          base64.decode(controller.bookingDetail?.qrCode ?? ''),
                    ),
                    const SizedBox(
                      height: 16,
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
                          cost: controller.bookingDetail?.originalPrice ?? 0,
                          discount: controller.bookingDetail?.discount ?? 0,
                          isDisable: false,
                          realPrice: controller.bookingDetail?.price ?? 0,
                          iconLeft: IconEnums.calendar,
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
