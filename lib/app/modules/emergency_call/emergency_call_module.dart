import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/emergency_call/emergency_call_page.dart';
import 'package:pstb/app/modules/emergency_call/emergency_call_store.dart';

class EmergencyCallModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => EmergencyCallStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const EmergencyCallPage(),
    ),
  ];
}
