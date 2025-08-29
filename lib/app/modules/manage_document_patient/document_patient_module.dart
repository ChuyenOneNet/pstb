import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/manage_document_patient/document_patient_page.dart';
import 'package:pstb/app/modules/manage_document_patient/widget/otp_document_page.dart';
import 'package:pstb/app/modules/manage_document_patient/widget/pdf_document_page.dart';

import '../../../utils/routes.dart';
import 'document_patient_store.dart';

class DocumentPatientModule extends Module {

  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => DocumentPatientStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, __) => DocumentPatientPage(),
    ),

    ChildRoute(
      AppRoutes.pdfDocumentPatient,
      child: (_, args) => PdfDocumentPage(
        documentModel: args.data['documentModel'],
        index: args.data['index'],
      ),
    ),
    ChildRoute(
      AppRoutes.otpdocumentPatient,
      child: (_, args) => OtpDocumentPage(
        transactionId: args.data['transactionId'],
        documents: args.data['documents'],
      ),
    ),
  ];
}