import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/bottom_nav/bottom_nav_store.dart';
import 'package:pstb/app/modules/home/home_store.dart';
import 'package:pstb/app/modules/medical_appointment/medical_appointment_store.dart';
import 'package:pstb/app/modules/profile/profile_store.dart';
import 'package:pstb/app/modules/notification/notification_store.dart';
import '../medical_unit/selection_hospital_store.dart';
import 'bottom_nav_page.dart';

class BottomNavBarModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => BottomNavStore()),
        Bind.lazySingleton((i) => HomeStore()),
        Bind.lazySingleton((i) => NotificationStore()),
        Bind.lazySingleton((i) => ProfileStore()),
        Bind.lazySingleton((i) => SelectionHospitalStore()),
        Bind.lazySingleton((i) => MedicalAppointmentStore()),
        //Bind.lazySingleton((i) => SearchStore()),
        // Bind.singleton((i) => AppStore()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute,
            child: (_, args) => const BottomNavPage()),
      ];
}
