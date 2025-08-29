import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/news/page/new_detail/new_detail_page.dart';
import 'package:pstb/app/modules/news/page/new_detail/new_detail_store.dart';
import 'package:pstb/app/modules/news/page/news/news_page.dart';
import 'package:pstb/app/modules/news/page/news/news_store.dart';
import 'package:pstb/app/modules/news/page/news/page/result_search_new_page.dart';
import 'package:pstb/app/modules/news/page/news/widgets/search_new.dart';
import 'package:pstb/utils/routes.dart';

class NewsModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => NewsStore()),
    Bind.lazySingleton((i) => NewsDetailStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const NewsPage(),
    ),
    ChildRoute(
      AppRoutes.newDetailPage,
      child: (_, args) => NewDetailPage(id: args.data),
    ),
    ChildRoute(
      AppRoutes.newSearchPage,
      child: (_, args) => NewSearchPage(),
    ),
    ChildRoute(
      AppRoutes.resultSearchNew,
      child: (_, args) => const ResultSearchNewPage(),
    ),
  ];
}
