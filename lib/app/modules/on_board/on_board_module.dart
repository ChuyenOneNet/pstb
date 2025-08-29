import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/on_board/on_board_page.dart';
import 'package:pstb/app/modules/on_board/on_board_store.dart';

class OnBoardModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => OnBoardStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const OnBoardPage(),
      // transition: TransitionType.rightToLeftWithFade,
    ),
  ];
  final Widget view = const OnBoardPage();
}
