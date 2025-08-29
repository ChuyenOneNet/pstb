import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/community/group_diseases_page/detail_answer_disease/detail_answer_disease_store.dart';
import 'package:pstb/app/modules/community/group_diseases_page/detail_answer_disease/detail_answer_disease_page.dart';
import 'package:pstb/utils/main.dart';

class DetailAnswerDiseaseModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => DetailAnswerDiseaseStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(AppRoutes.detailAnswer,
        child: (_, __) => const DetailAnswerDiseasePage())
  ];
}
