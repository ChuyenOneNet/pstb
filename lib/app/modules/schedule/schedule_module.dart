import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'schedule_page.dart';
import 'schedule_store.dart';

class ScheduleModule extends WidgetModule {
  @override
  final List<Bind> binds = [
    Bind((i) => ScheduleStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (_, args) =>const SchedulePage(), children: []),
  ];

  @override
  Widget get view => const SchedulePage();
}
