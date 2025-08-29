import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/community/group_diseases_page/category_diseases_page.dart';
import 'package:pstb/app/modules/community/group_diseases_page/category_diseases_store.dart';
import 'package:pstb/utils/main.dart';
import 'detail_answer_disease/detail_answer_disease_page.dart';
import 'detail_answer_disease/detail_answer_disease_store.dart';

class CategoryDiseasesModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => CategoryDiseasesStore()),
    Bind.lazySingleton((i) => DetailAnswerDiseaseStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      AppRoutes.diseases,
      child: (_, __) => const CategoryDiseasesPage(),
    ),
    ChildRoute(AppRoutes.detailAnswer,
        child: (_, __) => const DetailAnswerDiseasePage()),
  ];
}
