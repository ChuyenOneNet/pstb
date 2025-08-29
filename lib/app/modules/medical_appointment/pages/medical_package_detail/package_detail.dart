import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/medical_appointment/medical_appointment_store.dart';
import 'package:pstb/app/modules/medical_appointment/pages/medical_package_detail/pages/consultation_package_detail.dart';
import 'package:pstb/app/modules/medical_appointment/pages/medical_package_detail/pages/medical_package_detail_page.dart';

class PackageDetailPage extends StatelessWidget {
   PackageDetailPage({Key? key}) : super(key: key);

  final MedicalAppointmentStore _appointmentStore =
      Modular.get<MedicalAppointmentStore>();

  @override
  Widget build(BuildContext context) {
    if (_appointmentStore.consultation) {
      return const ConsultationPackageDetailPage();
    }
    return const MedicalPackageDetailPage();
  }
}
