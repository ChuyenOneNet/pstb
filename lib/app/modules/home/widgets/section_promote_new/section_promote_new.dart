import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/home/home_store.dart';
import 'package:pstb/app/modules/home/widgets/section_title.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/shimmer_loading.dart';

class PromotionNewsSection extends StatelessWidget {
  final HomeStore _homeStore = Modular.get<HomeStore>();
  PromotionNewsSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      if (_homeStore.promotionNews.isEmpty) {
        return const SizedBox();
      }
      return _homeStore.promotionNews.isNotEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
                  child: SectionTitle(
                    fontWeight: FontWeight.w900,
                    title: l10n(context).home_section_new_title,
                    color: AppColors.background,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                    // padding: const EdgeInsets.all(16.0),
                    margin: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 8.0),
                    decoration: BoxDecoration(
                        // color: AppColors.background,
                        borderRadius: BorderRadius.circular(16.0)),
                    child: const PromotionNewsListWidget())
              ],
            )
          : const SizedBox();
    });
  }
}

class PromotionNewsListWidget extends StatefulWidget {
  const PromotionNewsListWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<PromotionNewsListWidget> createState() =>
      _PromotionNewsListWidgetState();
}

class _PromotionNewsListWidgetState extends State<PromotionNewsListWidget> {
  final HomeStore _homeStore = Modular.get<HomeStore>();
  final CarouselSliderController _controllerSlider = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        if (_homeStore.loadingPromotion) {
          return const ShimmerLoadingWidget();
        }
        // if (_homeStore.promotionNews.isEmpty) {
        //   return Center(
        //     child: Text(
        //       'Hệ thống đang bảo trì.',
        //       style: Styles.subtitleSmallest.copyWith(color: AppColors.black),
        //     ),
        //   );
        // }
        return Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                autoPlayInterval: const Duration(seconds: 10),
                autoPlay: _homeStore.promotionNews.length > 1,
                height: 120,
                viewportFraction: 1.0,
                aspectRatio: 2,
                enableInfiniteScroll: _homeStore.promotionNews.length > 1,
                onPageChanged: (index, reason) {
                  _homeStore.changePromotion(index);
                },
              ),
              carouselController: _controllerSlider,
              items: List.generate(_homeStore.promotionNews.length, (index) {
                final promoteNew = _homeStore.promotionNews[index];
                return ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                  child: Image.network(
                    promoteNew.image ?? '',
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    errorBuilder: (_, __, ___) {
                      return const Center(
                        child: Icon(Icons.error),
                      );
                    },
                  ),
                );
              }),
            ),
            const SizedBox(
              height: 4,
            ),
            Observer(builder: (context) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _homeStore.promotionNews.length,
                  (index) {
                    return Container(
                      width: 12.0,
                      height: 4.0,
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: index == _homeStore.indexPromotion
                            ? AppColors.accent500
                            : AppColors.accent100,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    );
                  },
                ),
              );
            })
          ],
        );
      },
    );
  }
}
