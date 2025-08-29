import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/emergency/emergency_store.dart';
import 'package:pstb/app/modules/login/login_page.dart';
import 'login_store.dart';

class LoginModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton(
      (i) => LoginStore(),
    ),
    Bind.singleton((i) => EmergencyStore()),
  ];
  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const LoginPage()),
  ];
}
