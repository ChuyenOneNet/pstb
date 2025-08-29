import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/about_page/about_page_screen.dart';
import 'package:pstb/app/modules/about_page/about_page_store.dart';
import 'package:pstb/utils/routes.dart';

class AboutPageModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => AboutPageStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      AppRoutes.aboutPage,
      child: (_, args) => const AboutPageScreen(),
    ),
  ];
}
