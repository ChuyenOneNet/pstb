import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/medical_appointment/pages/confirm_and_payment/confirm_and_payment_page.dart';
import 'package:pstb/app/modules/medical_appointment/pages/confirm_and_payment/confirm_and_payment_store.dart';
import 'package:pstb/app/modules/medical_appointment/pages/confirm_and_payment/confirm_and_payment_success.dart';
import 'package:pstb/app/modules/medical_appointment/pages/doctor_info/doctor_info_page.dart';
import 'package:pstb/app/modules/medical_appointment/pages/doctor_info/doctor_info_store.dart';
import 'package:pstb/app/modules/medical_appointment/pages/medical_date_picker/medical_store.dart';
import 'package:pstb/app/modules/medical_appointment/pages/medical_date_picker/pages/medical_time_get_result_test.dart';
import 'package:pstb/app/modules/medical_appointment/pages/medical_date_picker/pages/medical_time_visit_doctor.dart';
import 'package:pstb/app/modules/medical_appointment/pages/medical_package/medical_package_store.dart';
import 'package:pstb/app/modules/medical_appointment/pages/medical_package_detail/medical_package_detail_store.dart';
import 'package:pstb/app/modules/medical_appointment/pages/medical_package_detail/package_detail.dart';
import 'package:pstb/app/modules/medical_appointment/pages/search_doctor/result_search_doctor_page.dart';
import 'package:pstb/app/modules/medical_appointment/pages/search_medical_package/result_search_package_page.dart';
import 'package:pstb/app/modules/medical_appointment/pages/search_medical_package/search_medical_package.dart';
import 'package:pstb/app/modules/medical_appointment/pages/select_doctor/select_doctor_page.dart';
import 'package:pstb/app/modules/medical_appointment/pages/select_doctor/select_doctor_store.dart';
import 'package:pstb/app/modules/medical_appointment/pages/search_doctor/search_doctor_page.dart';
import 'package:pstb/utils/routes.dart';
import 'medical_appointment_store.dart';
import 'pages/medical_package/pages/medical_package_page.dart';

class MedicalAppointmentModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.singleton((i) => MedicalAppointmentStore()),
    Bind.singleton((i) => MedicalPackageStore()),
    Bind.singleton((i) => MedicalPackageDetailStore()),
    Bind.lazySingleton((i) => ConfirmAndPaymentStore()),
    Bind.singleton((i) => SelectDoctorStore()),
    Bind.singleton((i) => MedicalStore()),
    Bind.singleton((i) => DoctorInfoStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    // ChildRoute(
    //   Modular.initialRoute,
    //   child: (_, __) => PackageCategoryMenuPage(),
    // ),
    // ChildRoute(
    //   AppRoutes.medicalAppointmentTemPage,
    //   child: (_, args) => MedicalPackagePage(),
    // ),
    // ChildRoute(
    //   AppRoutes.newMedicalPackagePage,
    //   child: (_, args) => const NewMedicalPackagePage(),
    // ),
    ChildRoute(
      AppRoutes.medicalPackagePage,
      child: (_, args) => const MedicalPackagePage(),
    ),
    ChildRoute(
      AppRoutes.medicalPackageDetailPage,
      child: (_, args) => PackageDetailPage(),
    ),
    ChildRoute(
      AppRoutes.selectDoctorPage,
      child: (_, __) => SelectDoctor(),
    ),
    ChildRoute(
      AppRoutes.searchDoctorPage,
      child: (_, __) => SearchDoctorPage(),
    ),
    ChildRoute(
      AppRoutes.searchMedicalPackage,
      child: (_, __) => SearchMedicalPackage(),
    ),
    ChildRoute(
      AppRoutes.packageSearchPage,
      child: (_, __) => const ResultSearchPackagePage(),
    ),
    ChildRoute(
      AppRoutes.doctorSearchPage,
      child: (_, __) => const ResultSearchDoctorPage(),
    ),
    ChildRoute(
      AppRoutes.doctorInfoPage,
      child: (_, args) => DoctorInfoPage(id: args.data),
    ),
    ChildRoute(
      AppRoutes.medicalTimeVisitDoctorPage,
      child: (_, args) => MedicalTimeVisitDoctor(
        doctorId: args.data['doctorId'],
        booking: args.data['booking'],
      ),
    ),
    ChildRoute(
      AppRoutes.medicalTimeGetResultTestPage,
      child: (_, args) => MedicalTimeGetSample(
          booking: args.data == null ? null : args.data['booking']),
    ),
    ChildRoute(
      AppRoutes.confirmAndPaymentPage,
      child: (_, __) => const ConfirmAndPaymentPage(),
    ),
    ChildRoute(
      AppRoutes.confirmAndPaymentSuccessPage,
      child: (_, args) => ConfirmAndPaymentSuccess(
        code: args.data['code'],
        qrCode: args.data['qrCode'],
      ),
    ),
  ];
}
