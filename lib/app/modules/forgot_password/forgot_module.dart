import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/utils/main.dart';

import 'forgot_otp.dart';
import 'forgot_page.dart';
import 'forgot_page_success.dart';
import 'forgot_store.dart';

class ForgotModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ForgotStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (_, args) => ForgotOtp(data: args.data)),
    ChildRoute(AppRoutes.forgotPage, child: (_, args) => const ForgotPage()),
    ChildRoute(AppRoutes.forgotSuccess,
        child: (_, args) => ForgotPageSuccess()),
  ];
}
