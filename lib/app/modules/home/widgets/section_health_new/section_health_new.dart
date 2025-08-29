import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/home/home_store.dart';
import 'package:pstb/app/modules/home/widgets/section_health_new/section_item.dart';
import 'package:pstb/app/modules/home/widgets/section_title.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/shimmer_loading.dart';

class SectionHealthNew extends StatefulWidget {
  const SectionHealthNew({
    Key? key,
  }) : super(key: key);

  @override
  State<SectionHealthNew> createState() => _SectionHealthNewState();
}

class _SectionHealthNewState extends State<SectionHealthNew> {
  final _homeStore = Modular.get<HomeStore>();

  final CarouselSliderController _controllerSlider = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
          child: SectionTitle(
            fontWeight: FontWeight.w900,
            title: l10n(context).home_section_health_title,
            color: AppColors.background,
            seeAll: 'Xem tất cả',
            onTap: () {
              Modular.to.pushNamed(AppRoutes.news);
            },
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Observer(
          builder: (context) {
            if (_homeStore.loadingNew) {
              return const ShimmerLoadingWidget();
            }
            if (_homeStore.healthNews.isEmpty) {
              return Center(
                child: Text(
                  'Hệ thống đang bảo trì.',
                  style: Styles.content,
                ),
              );
            }
            return Container(
              // padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
              decoration: BoxDecoration(
                  // color: AppColors.background,
                  borderRadius: BorderRadius.circular(16.0)),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 120,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlay: _homeStore.healthNews.length > 1,
                  aspectRatio: 2,
                  viewportFraction: 1.0,
                  enlargeCenterPage: false,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  enableInfiniteScroll: _homeStore.healthNews.length > 1,
                  onPageChanged: (index, reason) {
                    _homeStore.changeNews(index);
                  },
                ),
                carouselController: _controllerSlider,
                items: List.generate(_homeStore.healthNews.length, (index) {
                  final _healthNew = _homeStore.healthNews[index];
                  return SectionHealthItems(
                    count: _healthNew.count,
                    created: _healthNew.created,
                    image: _healthNew.id == '17'
                        ? ImageEnum.viemRuotThua
                        : _healthNew.id == '18'
                            ? ImageEnum.phuChan
                            : _healthNew.image,
                    title: _healthNew.title,
                    isFixImage: _healthNew.id == '17' || _healthNew.id == '18',
                    onPress: () => {
                      Modular.to.pushNamed(
                        AppRoutes.newDetail,
                        arguments: _healthNew.id,
                      )
                    },
                  );
                }),
              ),
            );
          },
        ),
      ],
    );
  }
}
