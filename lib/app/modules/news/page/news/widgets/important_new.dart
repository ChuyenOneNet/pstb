import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pstb/app/models/news_paging_model.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateful/stateful_widget.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';

import '../news_store.dart';

class ImportantNews extends StatelessWidget {
  final NewsStore _newsStore = Modular.get<NewsStore>();
  ImportantNews({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        final NewsPagingItem? importantNew = _newsStore.importantNew;
        if (importantNew!.id == null) {
          return const SizedBox();
        }
        return TouchableOpacity(
          onTap: () => Modular.to.pushNamed(
            AppRoutes.newDetail,
            arguments: importantNew.id,
          ),
          child: Column(
            children: [
              SizedBox(
                height: widthConvert(context, 180),
                width: widthConvert(context, 351),
                child: AppImageNetwork(
                  borderRadius: 4,
                  imageUri: importantNew.image,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        (importantNew.categories!.isNotEmpty
                            ? importantNew.categories![0].name
                            : importantNew.tags!)!,
                        style: Styles.heading4.copyWith(color: AppColors.black),
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: importantNew.title,
                            style: Styles.heading4.copyWith(
                              color: AppColors.black.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${importantNew.shortDescription ?? importantNew.description}",
                            style: Styles.subtitleSmallest,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(IconEnums.eye),
                              Text(
                                '${importantNew.count != null ? formatCurrency(importantNew.count.toString()).toString() : 0} lượt xem',
                                style: Styles.descriptionNoti.copyWith(
                                  color: AppColors.grayLight,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(height: 1, color: AppColors.lightSilver),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
