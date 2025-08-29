import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/business/page/business_detail_screen.dart';
import 'package:pstb/app/modules/business/page/business_login_page.dart';
import 'package:pstb/app/modules/business/page/change_password_business_page.dart';
import 'package:pstb/app/modules/business/page/reset_password_page.dart';
import 'package:pstb/app/modules/business/page/web_view_screen.dart';
import 'package:pstb/utils/main.dart';

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
      AppRoutes.detailBusinessPage,
      child: (_, args) => BusinessDetailScreen(
        idBusiness: args.data['idBusiness'],
      ),
    ),
    ChildRoute(AppRoutes.businessWebViewPdf, child: (_, args) {
      final url = args.data['url'];
      return WebViewScreen(url: url);
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
