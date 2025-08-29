import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/on_board/on_board_page.dart';

import 'schedule_detail_page.dart';
import 'schedule_detail_store.dart';

class ScheduleDetailModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ScheduleDetailStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => ScheduleDetailPage(data: args.data),
    ),
  ];
  final Widget view = OnBoardPage();
}
