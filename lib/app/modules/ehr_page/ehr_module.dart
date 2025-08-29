import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/ehr_page/ehr_page.dart';
import 'package:pstb/app/modules/ehr_page/ehr_store.dart';
import 'package:pstb/app/modules/ehr_page/pages/ehr_result_details.dart';
import 'package:pstb/app/modules/ehr_page/pages/pdf_indication/pdf_indication_page.dart';
import 'package:pstb/app/modules/ehr_page/pages/pdf_indication/pdf_indication_store.dart';
import 'package:pstb/app/modules/ehr_page/pages/signature_patient/otp_signature.dart';
import 'package:pstb/app/modules/ehr_page/pages/patient_page.dart';
import 'package:pstb/utils/main.dart';

class EHRModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => EHRStore()),
    Bind.lazySingleton((i) => PDFIndicationStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, __) => const PatientPage(),
    ),

    ChildRoute(
      AppRoutes.ehrPage,
      child: (_, args) => EHRPage(
        patientId: args.data['patientId'],
        phone: args.data['phone'],
      ),
    ),
    ChildRoute(
      AppRoutes.ehrResult,
      child: (_, args) => EHRResultDetails(examination: args.data),
    ),
    ChildRoute(
      AppRoutes.pdfIndication,
      child: (_, args) => PDFIndicationPage(
        documentModel: args.data['documentModel'],
      ),
    ),
    ChildRoute(
      AppRoutes.otpSignaturePatient,
      child: (_, args) => OtpSignaturePatient(
        transactionId: args.data['transactionId'],
        documentModel: args.data['documentModel'],
      ),
    ),
  ];
}