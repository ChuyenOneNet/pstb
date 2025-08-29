import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/doctor_appointment/doctor_appointment_page.dart';
import 'package:pstb/app/modules/doctor_appointment/doctor_appointment_store.dart';

class DoctorAppointmentModule extends WidgetModule {
  DoctorAppointmentModule({Key? key}) : super(key: key);


  @override
  // TODO: implement binds
  final List<Bind> binds = [
    Bind.lazySingleton((i) => DoctorAppointmentStore()),
  ];
  @override
  // TODO: implement view
  Widget get view => const DoctorAppointmentPage();

  @override
  List<ModularRoute> get routes => [
    ChildRoute(Modular.initialRoute,
        child: (_, args) => const DoctorAppointmentPage()),
  ];

}