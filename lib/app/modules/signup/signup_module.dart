import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/signup/signup_info.dart';
import 'package:pstb/app/modules/signup/signup_otp.dart';
import 'package:pstb/app/modules/signup/signup_store.dart';
import 'package:pstb/utils/main.dart';
import 'sigup_success.dart';
import 'signup_form_register.dart';

class SignupModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => SignupStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const SignupForm()),
    ChildRoute(AppRoutes.signupOTP, child: (_, args) => const SignupOtp()),
    ChildRoute(AppRoutes.signupInfo, child: (_, args) => const SignupInfo()),
    ChildRoute(AppRoutes.signupSuccess,
        child: (_, args) => const SignupSuccess()),
  ];
}
