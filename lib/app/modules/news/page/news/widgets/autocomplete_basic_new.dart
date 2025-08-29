import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/news/page/news/news_store.dart';

import '../../../../../../utils/colors.dart';
import '../../../../../../utils/images.dart';
import '../../../../../../utils/routes.dart';
import '../../../../../../utils/styles.dart';
import '../../../../../models/news_paging_model.dart';
import '../../../../../user_app_store.dart';

class AutocompleteBasicNew extends StatelessWidget {
  final NewsStore _newsStore = Modular.get<NewsStore>();
  final UserAppStore _userAppStore = Modular.get<UserAppStore>();

  AutocompleteBasicNew({Key? key}) : super(key: key);

  static String _displayStringForOption(NewsPagingItem newsItem) =>
      newsItem.title ?? '';

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Autocomplete<NewsPagingItem>(
        displayStringForOption: _displayStringForOption,
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text == '') {
            return const Iterable<NewsPagingItem>.empty();
          }
          return _newsStore.newsListWillShow.where((NewsPagingItem option) {
            return option.title!
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase());
          });
        },
        fieldViewBuilder: (BuildContext context,
            TextEditingController textEditingController,
            FocusNode focusNode,
            VoidCallback onFieldSubmitted) {
          return Padding(
            padding: const EdgeInsets.only(left: 32.0),
            child: CupertinoSearchTextField(
              autofocus: true,
              placeholder: 'Tìm kiếm tin tức',
              placeholderStyle:
                  Styles.heading4.copyWith(color: AppColors.lightSilver),
              controller: textEditingController,
              focusNode: focusNode,
              style: Styles.heading4.copyWith(color: AppColors.black),
            ),
          );
        },
        optionsViewBuilder: (context, onSelected, options) => Material(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(4.0)),
          ),
          child: Container(
            color: AppColors.background,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: options.length,
              shrinkWrap: false,
              itemBuilder: (BuildContext context, int index) {
                final NewsPagingItem option = options.elementAt(index);
                return InkWell(
                  onTap: () => onSelected(option),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0, right: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          child: CachedNetworkImage(
                            height: 60,
                            width: 60,
                            imageUrl: option.image ?? '',
                            placeholder: (context, url) =>
                                const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: Center(child: CircularProgressIndicator(
                                    value: 10,
                                    strokeWidth: 2.0,
                                  )),
                                ),
                            errorWidget: (context, url, error) =>
                                Image.asset(ImageEnum.avatarDefault),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                  child: Text(
                                    '${option.title}',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Styles.subtitleSmallest.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  )),
                              const SizedBox(
                                height: 4,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 140,
                                child: Text(
                                  option.shortDescription ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Styles.subtitleSmallest,
                                ),
                              )
                            ],
                          ),
                        ),
                        const Icon(Icons.keyboard_arrow_right,size: 28, color: AppColors.lightSilver,),
                        const SizedBox(
                          width: 16,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        onSelected: (NewsPagingItem selection) {
          var titleNew = _displayStringForOption(selection);
          for (var element in _newsStore.newsListWillShow) {
            if (titleNew == element.title) {
              _userAppStore.newsItem = element;
              _newsStore.idNew = element.id!;
              Modular.to.pushNamed(
                AppRoutes.newDetail,
                arguments: _newsStore.idNew,
              );
              return;
            }
          }
        },
      );
    });
  }
}
