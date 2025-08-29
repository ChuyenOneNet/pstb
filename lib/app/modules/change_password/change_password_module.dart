import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/change_password/change_password_otp.dart';
import 'package:pstb/utils/main.dart';

import 'change_password_form.dart';
import 'change_password_store.dart';
import 'change_password_success.dart';

class ChangePasswordModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ChangePasswordStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const ChangePasswordForm(),
    ),
    ChildRoute(
      AppRoutes.changePasswordOtp,
      child: (_, args) => const ChangePasswordOtpScreen(),
    ),
    ChildRoute(
      AppRoutes.changePasswordSuccessPage,
      child: (_, args) => const ChangePasswordPageSuccess(),
    ),
  ];
}
