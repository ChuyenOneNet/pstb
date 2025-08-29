import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/medical_unit/search_hospital/search_hospital_page.dart';
import 'package:pstb/app/modules/medical_unit/selection_hospital_page.dart';
import 'package:pstb/app/modules/medical_unit/selection_hospital_store.dart';

import '../../../utils/routes.dart';
import 'detail_hospital/detail_hospital_page.dart';
import 'detail_hospital/detail_hospital_store.dart';

class SelectionHospitalModule extends WidgetModule {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => SelectionHospitalStore()),
    Bind.lazySingleton((i) => DetailHospitalStore()),
  ];

  SelectionHospitalModule({Key? key}) : super(key: key);

  @override
  // TODO: implement view
  Widget get view => SelectionHospitalPage();

  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute,
            child: (_, args) => SelectionHospitalPage()),
      ];
}
