import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../home/home_store.dart';
import 'home_page.dart';
import 'widgets/category/detail_package_group/detail_package_store.dart';

class HomeModule extends WidgetModule {
  @override
  Widget get view => HomePage();

  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => HomeStore()),
        Bind.lazySingleton((i) => DetailPackageStore()),
      ];
}
