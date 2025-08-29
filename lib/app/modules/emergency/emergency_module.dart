import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/emergency/emergency_page.dart';
import 'package:pstb/app/modules/emergency/emergency_store.dart';

class EmergencyModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => EmergencyStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const EmergencyPage(),
    ),
  ];
}
