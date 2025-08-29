import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/community/question_page/question_page.dart';
import 'package:pstb/app/modules/community/question_page/question_store.dart';
import 'package:pstb/utils/routes.dart';

import '../../group_diseases_page/detail_answer_disease/detail_answer_disease_store.dart';

class QuestionModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => QuestionStore()),
    Bind.lazySingleton((i) => DetailAnswerDiseaseStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(AppRoutes.setUpQuestion, child: (_, __) => const QuestionPage())
  ];
}
