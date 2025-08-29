import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/perform_medicine/perform_medicine_order/medicine_order_store.dart';
import 'package:pstb/app/modules/perform_medicine/perform_medicine_order/perform_medicine_order.dart';
import 'package:pstb/app/modules/perform_medicine/perform_medicine_page.dart';
import 'package:pstb/app/modules/perform_medicine/perform_medicine_store.dart';
import 'package:pstb/utils/routes.dart';

import '../../models/perform_medicine/medicine_usage_model.dart';
import 'medicine_usage/medicine_usage_page.dart';

class PerformMedicineModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => PerformMedicineStore()),
    Bind.lazySingleton((i) => MedicineOrderStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      AppRoutes.perFormMedicinePage,
      child: (_, args) => PerformMedicinePage(),
    ),
    ChildRoute(
      AppRoutes.perFormMedicineOrderPage,
      child: (_, args) => PerformMedicineOrdersPage(
        executionDate: args.data['executionDate'],
        patientCode: args.data['patientCode'],
        patientInfo: args.data['patientInfo'],
      ),
    ),
    ChildRoute(
      AppRoutes.performMedicineConfigPage,
      child: (_, args) => PerformMedicineConfigPage(
        executionDate: args.data['executionDate'] as String,
        patientCode: args.data['patientCode'] as String,
        patientInfo: args.data['patientInfo'] as String,
        userName: args.data['userName'] as String,
        initialData: (args.data['initialData'] as List<dynamic>)
            .cast<MedicineUsageModel>(),
      ),
    ),
  ];
}
