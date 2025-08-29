import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/news/page/news/widgets/section_item_search.dart';
import 'package:pstb/widgets/stateless/custom_autocomplete_basic.dart';

import '../../../../../../utils/colors.dart';
import '../../../../../../utils/routes.dart';
import '../../../../../../utils/styles.dart';
import '../../../../../user_app_store.dart';
import '../news_store.dart';
import 'autocomplete_basic_new.dart';

class NewSearchPage extends StatelessWidget {
  final UserAppStore _userAppStore = Modular.get<UserAppStore>();
  final NewsStore _newsStore = Modular.get<NewsStore>();

  NewSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Stack(
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Modular.to.pop();
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Center(
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    CustomAutocompleteBasic(
                      store: _newsStore,
                      keywordSearch: _newsStore.keywordSearch,
                      onSubmitted: (value) async {
                        await _newsStore.getSearchNew(value);
                        _newsStore.keyword = value;
                        Modular.to.popAndPushNamed(AppRoutes.resultNewSearch);
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Tìm kiếm gần nhất',
                    style: Styles.heading4.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                ),
              ),
              Observer(builder: (context) {
                return _userAppStore.newsItem.title == null ||
                        _userAppStore.newsItem.title == ''
                    ? SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            'Bạn chưa tìm kiếm gần đây.',
                            style: Styles.subtitleSmallest,
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: SectionItemSearch(
                          image: _userAppStore.newsItem.image,
                          title: _userAppStore.newsItem.title,
                          shortDescription:
                              _userAppStore.newsItem.shortDescription,
                          count: _userAppStore.newsItem.count,
                          onPress: () {
                            Modular.to.pushNamed(
                              AppRoutes.newDetail,
                              arguments: _userAppStore.newsItem.id,
                            );
                          },
                        ),
                      );
              }),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Gợi ý cho bạn',
                    style: Styles.heading4.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                ),
              ),
              if (_newsStore.newsListWillShow.length >= 2)
                Observer(builder: (context) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          final newItem = _newsStore.newsListWillShow[index];
                          return SectionItemSearch(
                            image: newItem.image,
                            title: newItem.title,
                            shortDescription: newItem.shortDescription,
                            count: newItem.count,
                            onPress: () {
                              Modular.to.pushNamed(
                                AppRoutes.newDetail,
                                arguments: newItem.id,
                              );
                            },
                          );
                        },
                        itemCount: 2,
                        physics: const ClampingScrollPhysics(),
                      ),
                    ),
                  );
                })
              else
                const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
