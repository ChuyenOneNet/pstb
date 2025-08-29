import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/news/page/news/news_store.dart';
import 'package:pstb/app/modules/news/page/news/widgets/section_item_search.dart';
import 'package:pstb/app/user_app_store.dart';
import 'package:pstb/utils/routes.dart';
import 'package:pstb/utils/styles.dart';
import 'package:pstb/widgets/stateless/button_back.dart';

class ResultSearchNewPage extends StatefulWidget {
  const ResultSearchNewPage({Key? key}) : super(key: key);

  @override
  State<ResultSearchNewPage> createState() => _ResultSearchNewPageState();
}

class _ResultSearchNewPageState extends State<ResultSearchNewPage> {
  final NewsStore controller = Modular.get<NewsStore>();
  final UserAppStore _userAppStore = Modular.get<UserAppStore>();
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Column(
            children: [
              Text(
                'Kết quả tìm kiếm câu hỏi: ${controller.keyword}',
                style: Styles.titleItem,
              ),
              const Divider(
                color: Colors.black,
              ),
              Expanded(
                child: Observer(builder: (context) {
                  return controller.newsListSearch.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ListView.builder(
                            controller: _scrollController,
                            padding: EdgeInsets.zero,
                            itemBuilder: (_, index) {
                              final newItem = controller.newsListSearch[index];
                              return SectionItemSearch(
                                image: newItem.image,
                                title: newItem.title,
                                shortDescription: newItem.shortDescription,
                                count: newItem.count,
                                onPress: () {
                                  _userAppStore.newsItem = newItem;
                                  Modular.to.pushNamed(
                                    AppRoutes.newDetail,
                                    arguments: newItem.id,
                                  );
                                },
                              );
                            },
                            itemCount: controller.newsListSearch.length,
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/social_media.jpg'),
                            const SizedBox(
                              height: 8.0,
                            ),
                            Text(
                              'Không tìm thấy câu hỏi nào!',
                              textAlign: TextAlign.center,
                              style: Styles.content,
                            ),
                          ],
                        );
                }),
              ),
            ],
          ),
          const ButtonBackWidget(),
        ],
      ),
    );
  }
}
