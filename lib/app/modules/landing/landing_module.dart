import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/landing/landing_page.dart';

class LandingModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const LandingPage()),
  ];
}
