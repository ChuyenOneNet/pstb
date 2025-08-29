import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';

import '../medical_store.dart';
import '../model/TimeObject.dart';
import '../widget/list_day_visit.dart';
import '../widget/list_time_visit.dart';
// import '../medical_store.dart';

class ConsultationTimeVisitDoctor extends StatefulWidget {
  const ConsultationTimeVisitDoctor({Key? key}) : super(key: key);

  @override
  _ConsultationTimeVisitDoctorState createState() =>
      _ConsultationTimeVisitDoctorState();
}

class _ConsultationTimeVisitDoctorState
    extends ModularState<ConsultationTimeVisitDoctor, MedicalStore> {
  @override
  void initState() {
    super.initState();
  }

  void refreshDataPicked() {
    controller.onChangeIdTimeVisit(null);
    controller.onChangeIdTimeGetResultTest(null);
  }

  void onClickDayVisit(idDayPicked) {
    controller.onChangeIdDayPicked(idDayPicked);
    refreshDataPicked();
    List<TimeObject> list = [
      TimeObject(
          id: 0,
          date:  DateTime(
              controller.getDayPicked.year,
              controller.getDayPicked.month,
              controller.getDayPicked.day,
              09,
              00),
          booked: false),
      TimeObject(
          id: 1,
          date:  DateTime(
              controller.getDayPicked.year,
              controller.getDayPicked.month,
              controller.getDayPicked.day,
              09,
              30),
          booked: true),
      TimeObject(
          id: 2,
          date: DateTime(
              controller.getDayPicked.year,
              controller.getDayPicked.month,
              controller.getDayPicked.day,
              10,
              00),
          booked: false),
      TimeObject(
          id: 3,
          date: DateTime(
              controller.getDayPicked.year,
              controller.getDayPicked.month,
              controller.getDayPicked.day,
              10,
              30),
          booked: false),
      TimeObject(
          id: 4,
          date: DateTime(
              controller.getDayPicked.year,
              controller.getDayPicked.month,
              controller.getDayPicked.day,
              14,
              00),
          booked: false),
      TimeObject(
          id: 5,
          date: DateTime(
              controller.getDayPicked.year,
              controller.getDayPicked.month,
              controller.getDayPicked.day,
              14,
              30),
          booked: false),
      TimeObject(
          id: 6,
          date: DateTime(
              controller.getDayPicked.year,
              controller.getDayPicked.month,
              controller.getDayPicked.day,
              15,
              00),
          booked: true),
      TimeObject(
          id: 7,
          date: DateTime(
              controller.getDayPicked.year,
              controller.getDayPicked.month,
              controller.getDayPicked.day,
              15,
              30),
          booked: false),
    ];
    controller.onChangeListTimeVisit(list);
  }

  void onContinute() {
    Modular.to.pushNamed(AppRoutes.appointmentConfirmAndPayment);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        backgroundColor: AppColors.newbg900,
        title: l10n(context)!.medical_picker_time_visit_title,
      ),
      body: Column(
        children: [
          Container(
            width: widthConvert(context, 375),
            height: 80,
            margin: const EdgeInsets.only(top: 16),
            decoration: const BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Observer(
              builder: (context) => BuildListDayVisit(
                listDayPickerLength: controller.listDayPickerLength,
                onClickDayVisit: onClickDayVisit,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Observer(
                    builder: (context) => BuildListTimeVisit(
                      listAM: controller.listTimeVisitAM,
                      listPM: controller.listTimeVisitPM,
                      onTap: controller.onChangeIdTimeVisit,
                      idTimePicked: controller.idTimeVisit,
                    ),
                  ),
                  const SizedBox(
                    height: 180,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.only(top: 15, bottom: 30, left: 16, right: 16),
        decoration: BoxDecoration(
          color: AppColors.background,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: AppButton(
          title: l10n(context)!.continute,
          onPressed: onContinute,
          iconRight: IconEnums.arrowRight,
        ),
      ),
    );
  }
}
