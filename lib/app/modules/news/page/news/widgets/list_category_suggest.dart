import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateful/stateful_widget.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';
import '../news_store.dart';

class ListCategorySuggest extends StatelessWidget {
  final NewsStore _newsStore = Modular.get<NewsStore>();
  ListCategorySuggest({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Text(
                l10n(context)!.new_categories!,
                style: Styles.subtitleSmallest,
              ),
              Expanded(
                child: Observer(
                  builder: (context) {
                    if (_newsStore.loadingTags) {
                      return Container(
                        child: const AppCircleLoading(),
                        alignment: Alignment.centerLeft,
                      );
                    }
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Wrap(
                        children: List.generate(
                          _newsStore.tagData!.length,
                          (index) {
                            final category = _newsStore.tagData![index].slug;
                            return TouchableOpacity(
                              onTap: () => _newsStore.setSelectedTags(
                                tagName: category!,
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: widthConvert(context, 12),
                                  vertical: widthConvert(context, 7),
                                ),
                                margin: EdgeInsets.only(
                                  right: widthConvert(context, 8),
                                ),
                                decoration: BoxDecoration(
                                  color: category == _newsStore.selectedTags
                                      ? AppColors.primary
                                      : AppColors.background,
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(
                                    color: AppColors.lightSilver,
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  category!,
                                  style: TextStyle(
                                    color: category == _newsStore.selectedTags
                                        ? AppColors.background
                                        : AppColors.black,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        TouchableOpacity(
          child: Text(
            l10n(context)!.new_category_list!,
            style: Styles.heading4.copyWith(
              color: AppColors.black,
            ),
          ),
          onTap: () {
            showModalBottomSheet<void>(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              context: context,
              builder: (BuildContext context) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: 250,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          l10n(context)!.news_category!,
                          textAlign: TextAlign.left,
                          style: Styles.bodyBold.copyWith(
                            color: AppColors.neutral900,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: _newsStore.tagData!.length,
                            itemBuilder: (context, position) {
                              final category =
                                  _newsStore.tagData![position].slug;
                              return TouchableOpacity(
                                onTap: () {
                                  _newsStore.setSelectedTags(
                                    tagName: category!,
                                  );
                                  // Navigator.pop(context);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: widthConvert(context, 12),
                                    vertical: widthConvert(context, 7),
                                  ),
                                  margin: EdgeInsets.symmetric(
                                    horizontal: widthConvert(context, 8),
                                    vertical: widthConvert(context, 4),
                                  ),
                                  decoration: BoxDecoration(
                                    color: category == _newsStore.selectedTags
                                        ? AppColors.primary
                                        : AppColors.background,
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: AppColors.lightSilver,
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    category!,
                                    style: TextStyle(
                                      color: category == _newsStore.selectedTags
                                          ? AppColors.background
                                          : AppColors.black,
                                      // AppColors.black
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
        const SizedBox(height: 8),
        const Divider(
          thickness: 1.0,
          color: AppColors.lightSilver,
        )
      ],
    );
  }
}
