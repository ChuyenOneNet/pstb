import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/medical_appointment/medical_appointment_store.dart';
import 'package:pstb/app/modules/medical_appointment/pages/medical_date_picker/medical_store.dart';
import 'package:pstb/app/modules/medical_appointment/pages/medical_package_detail/medical_package_detail_store.dart';
import 'package:pstb/app/modules/medical_appointment/pages/medical_package_detail/pages/medical_package_detail_page.dart';
import 'package:pstb/utils/routes.dart';

class PackageModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.singleton((i) => MedicalAppointmentStore()),
    Bind.lazySingleton((i) => MedicalPackageDetailStore()),
    Bind.lazySingleton((i) => MedicalStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      AppRoutes.medicalPackageDetail,
      child: (_, args) => const MedicalPackageDetailPage(),
    ),
  ];
}
