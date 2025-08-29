import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pstb/app/modules/home/home_store.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/shimmer_loading.dart';

import '../section_title.dart';
import 'detail_package_group/detail_package_store.dart';

class PackageCategoryWidget extends StatefulWidget {
  const PackageCategoryWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<PackageCategoryWidget> createState() => _PackageCategoryWidgetState();
}

class _PackageCategoryWidgetState extends State<PackageCategoryWidget> {
  late ScrollController _scrollController;
  final detailController = Modular.get<DetailPackageStore>();
  final homeController = Modular.get<HomeStore>();

  @override
  void initState() {
    _scrollController = ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  Future<void> _scrollListener() async {
    if (_scrollController.offset <=
            _scrollController.position.minScrollExtent &&
        !_scrollController.position.outOfRange) {
      await detailController.loadMorePackage();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      if (homeController.reload) {
        return ShimmerLoadingWidget(
          child: SizedBox(
            height: heightConvert(context, 200),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                return Container(
                  margin: const EdgeInsets.only(right: 8),
                  width: 120,
                  color: AppColors.lightSilver,
                );
              },
              itemCount: 3,
            ),
          ),
        );
      }

      return homeController.listPackageGroup.isEmpty
          ? const SizedBox()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
                  child: SectionTitle(
                    fontWeight: FontWeight.w900,
                    title: 'Gói khám nổi bật',
                    // color: AppColors.background,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  margin:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.lightSilver),
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(16.0)),
                  height: heightConvert(context, 120),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    controller: _scrollController,
                    itemBuilder: (context, index) {
                      final item = homeController.listPackageGroup[index];
                      if (index == homeController.listPackageGroup.length) {
                        return const SizedBox();
                      }
                      return InkWell(
                        onTap: () async {
                          if (item.id != null) {
                            EasyLoading.show();
                            await detailController.initDetail(item.id ?? 0,
                                name: item.name ?? '');
                            EasyLoading.dismiss();
                            Modular.to.pushNamed(AppRoutes.detailPackageGroup);
                            // if (detailController.listPackage.isNotEmpty) {
                            //   Modular.to
                            //       .pushNamed(AppRoutes.detailPackageGroup);
                            // } else {
                            //   // Modular.to.pushNamed(AppRoutes.commingSoon,
                            //   //     arguments: <String, dynamic> {
                            //   //   'title':'Sắp ra mắt',
                            //   //   'description':'Chức năng đang phát triển. Vui lòng quay lại sau!',
                            //   //   'titleButton':'Quay lại trang chủ',
                            //   //   'isBack':'true',
                            //   //     }
                            //   // );
                            //   Modular.to.pushNamed(AppRoutes.comingSoonPage);
                            // }
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: (item.image!.contains('.svg'))
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(16.0),
                                  child: SvgPicture.network(
                                    item.image ?? "",
                                    fit: BoxFit.cover,
                                    width: 80,
                                    placeholderBuilder:
                                        (BuildContext context) => const Center(
                                            child: CircularProgressIndicator()),
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(16.0),
                                  child: Image.network(
                                    item.image ?? '',
                                    fit: BoxFit.fill,
                                    errorBuilder: (_, __, ___) {
                                      return const Icon(Icons.error);
                                    },
                                  ),
                                ),
                        ),
                      );
                    },
                    itemCount: homeController.listPackageGroup.length,
                  ),
                ),
              ],
            );
    });
  }
}
