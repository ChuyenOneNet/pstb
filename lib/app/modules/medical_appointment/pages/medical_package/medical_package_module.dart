import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'medical_package_store.dart';
import 'pages/medical_package_page.dart';

class MedicalPackageModule extends WidgetModule {

  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => MedicalPackageStore()),
  ];

  MedicalPackageModule({Key? key}) : super(key: key);

  @override
  Widget get view =>const MedicalPackagePage();
}
