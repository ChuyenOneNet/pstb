import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/community/community_page.dart';
import 'package:pstb/app/modules/community/community_page_store.dart';
import 'package:pstb/app/modules/community/question_page/question_store.dart';

class CommunityPageModule extends WidgetModule {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => CommunityPageStore()),
    Bind.lazySingleton((i) => QuestionStore()),
  ];

  CommunityPageModule({Key? key}) : super(key: key);

  @override
  Widget get view => const CommunityPage();
}
