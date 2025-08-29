import 'package:flutter/material.dart';
import 'package:pstb/app/modules/medical_appointment/pages/medical_date_picker/pages/consultation_time_visit_doctor.dart';

class TimeVisitDoctor extends StatelessWidget {
  const TimeVisitDoctor({Key? key}) : super(key: key);
  // final MedicalAppointmentStore _appointmentStore =
  //     Modular.get<MedicalAppointmentStore>();
  @override
  Widget build(BuildContext context) {
    // if (_appointmentStore.consultation) {
    return const ConsultationTimeVisitDoctor();
    // }
    // return MedicalTimeVisitDoctor();
  }
}
