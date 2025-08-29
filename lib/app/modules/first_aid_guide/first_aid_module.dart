import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/first_aid_guide/first_aid_page.dart';
import 'package:pstb/app/modules/first_aid_guide/first_aid_store.dart';

class FirstAidModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => FirstAidStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const FirstAidPage(),
    ),
  ];
}
