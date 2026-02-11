import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/business/page/business_detail_screen.dart';
import 'package:pstb/app/modules/business/page/business_login_page.dart';
import 'package:pstb/app/modules/business/page/change_password_business_page.dart';
import 'package:pstb/app/modules/business/page/reset_password_page.dart';
import 'package:pstb/app/modules/business/page/web_view_screen.dart';
import 'package:pstb/utils/main.dart';

import '../attach_document_his/medical_record_lookup_for_his_page.dart';
import '../attach_document_his/upload_medical_document_page.dart';
import '../business_for_his/business_detail_for_his_screen.dart';
import '../business_for_his/business_login_for_his_page.dart';
import '../business_for_his/business_page_for_his.dart';
import 'business_page.dart';
import 'business_store.dart';

class BusinessModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => BusinessStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, __) => const BusinessLoginPage(),
    ),
    ChildRoute(
      AppRoutes.businessPage,
      child: (_, args) => BusinessPage(),
    ),
    ChildRoute(
      AppRoutes.businessLoginForHisPage,
      child: (_, __) => const BusinessLoginForHisPage(),
    ),
    ChildRoute(
      AppRoutes.businessPageForHis,
      child: (_, args) => BusinessPageForHis(),
    ),
    ChildRoute(
      AppRoutes.detailBusinessPage,
      child: (_, args) => BusinessDetailScreen(
        idBusiness: args.data['idBusiness'],
      ),
    ),
    ChildRoute(
      AppRoutes.detailBusinessPageForHis,
      child: (_, args) => BusinessDetailScreenForHis(
        idBusiness: args.data['idBusiness'],
      ),
    ),
    ChildRoute(
      AppRoutes.medicalRecordLookupForHis,
      child: (_, __) => const MedicalRecordLookupForHisPage(),
    ),
    ChildRoute(
      AppRoutes.uploadMedicalDocument,
      child: (_, args) => UploadMedicalDocumentPage(
        dangKyId: args.data['dangKyId'],
        benhNhanId: args.data['benhNhanId'],
      ),
    ),

    ChildRoute(AppRoutes.businessWebViewPdf, child: (_, args) {
      final url = args.data['url'];
      final title = args.data['title'];
      return RadWebViewScreen(url: url, title: title);
    }),
    ChildRoute(
      AppRoutes.resetPasswordBusiness,
      child: (_, args) => ResetPasswordScreen(),
    ),
    ChildRoute(
      AppRoutes.changePasswordBusiness,
      child: (_, args) => ChangePasswordBusinessScreen(),
    ),
    // ChildRoute(
    //   AppRoutes.BusinessResult,
    //   child: (_, args) => BusinessResultDetails(examination: args.data),
    // ),
    // ChildRoute(
    //   AppRoutes.pdfIndication,
    //   child: (_, args) => PDFIndicationPage(
    //     documentModel: args.data['documentModel'],
    //   ),
    // ),
    // ChildRoute(
    //   AppRoutes.otpSignaturePatient,
    //   child: (_, args) => OtpSignaturePatient(
    //     transactionId: args.data['transactionId'],
    //     documentModel: args.data['documentModel'],
    //   ),
    // ),
  ];
}
