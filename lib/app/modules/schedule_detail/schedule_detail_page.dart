import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/schedule_detail/pages/schedule_detail_completed.dart';
import 'package:pstb/app/modules/schedule_detail/pages/schedule_detail_upcoming.dart';
import 'package:pstb/app/modules/schedule_detail/schedule_detail_store.dart';
import '../medical_appointment/medical_appointment_store.dart';
import '../medical_appointment/pages/confirm_and_payment/models/booking_info.dart';

class ScheduleDetailPage extends StatefulWidget {
  final Map<String, dynamic> data;

  const ScheduleDetailPage({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  _ScheduleDetailPageState createState() => _ScheduleDetailPageState();
}

class _ScheduleDetailPageState
    extends ModularState<ScheduleDetailPage, ScheduleDetailStore> {
  final MedicalAppointmentStore _medicalAppointmentStore =
      Modular.get<MedicalAppointmentStore>();

  @override
  void initState() {
    controller.changeBuildContext(context);
    controller.getPrescriptionDetail(
        widget.data['mahoso'], widget.data["id"], widget.data['isCompleted']);
    controller.onChangePaymentInfo(
      BookingInfo(
        doctorId: null,
        doctorName: controller.doctor,
        packageId: _medicalAppointmentStore.selectedPackage.id ?? 0,
        packageName: _medicalAppointmentStore.selectedPackage.name ?? "",
        timeSeeDoctor: DateTime.now(),
        covidDeclaration: _medicalAppointmentStore.getCovidDeclaration(),
        address: "",
        timeGetSample: DateTime.now(),
        idCost: '-1',
        cost: _medicalAppointmentStore.selectedPackage.price ?? 0,
        discount: 0,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data['isCompleted']) {
      return const ScheduleDetailCompletedPage();
    }
    return const ScheduleDetailUpcomingPage();
  }
}
