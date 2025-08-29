import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/medical_appointment/medical_appointment_store.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateful/stateful_widget.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';
import 'package:pstb/widgets/stateless/package_items/package_item.dart';
import '../medical_package_store.dart';

class MedicalPackagePage extends StatefulWidget {
  const MedicalPackagePage({Key? key}) : super(key: key);

  @override
  _MedicalPackagePageState createState() => _MedicalPackagePageState();
}

class _MedicalPackagePageState
    extends ModularState<MedicalPackagePage, MedicalPackageStore> {
  final MedicalAppointmentStore _appointmentStore =
      Modular.get<MedicalAppointmentStore>();
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_loadMoreItems);
    controller.createBuildContext(context);
    _appointmentStore.setConsultation(false);
    controller.setOtherPackage(true);
    controller.setPackageGroup(false);
    controller.getPackages();

    // controller.getListCategory();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.removeListener(_loadMoreItems);
    super.dispose();
  }

  Future<void> _loadMoreItems() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      await controller.loadMorePackage();
    }
  }

  void onSubmitSearch(String value) {
    controller.onChangeSearchText(value);
    controller.searchPackages();
  }

  void onSubmitFilter(FilterObject? valueSortBy, FilterObject? valueCategory,
      FilterObject? valueTime, FilterObject? valuePrice) {
    controller.onChangeSearchFilter(
      categorySlug: valueCategory == null ? '' : valueCategory.value,
      priceGte: valuePrice == null ? '' : valuePrice.valueGte,
      priceLte: valuePrice == null ? '' : valuePrice.valueLte,
      ordering: valueSortBy == null ? '' : valueSortBy.value,
    );
    controller.searchPackages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isBack: true,
        title: "Danh sách gói dịch vụ",
        actionIcon: const Icon(
          Icons.search,
          color: AppColors.primary,
        ),
        actionFunc: () {
          Modular.to.pushNamed(AppRoutes.searchMedical, arguments: false);
        },
      ),
      body: RefreshIndicator(
        child: Observer(builder: (_) {
          if (controller.loadingPackage) {
            return const SizedBox();
          } else {
            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: Styles.defaultPageMargin.copyWith(top: 8),
                    child: controller.packagesList.isNotEmpty
                        ? ListView.builder(
                            controller: _scrollController,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: controller.packagesList.length,
                            itemBuilder: (_, index) {
                              return PackageItemWidget(
                                index: index,
                                onTap: () {
                                  _appointmentStore.setPackageDetail(
                                      controller.packagesList[index]);
                                  _appointmentStore.addPackageToShowed(
                                      controller.packagesList[index]);
                                  bool examAtHome = controller
                                          .packagesList[index].examAtHome ??
                                      false;
                                  bool testAtHome = controller
                                          .packagesList[index].testAtHome ??
                                      false;
                                  _appointmentStore.setExamAtHome(examAtHome);
                                  _appointmentStore.setTestAtHome(testAtHome);
                                  controller.navigateTo(
                                      AppRoutes.medicalPackageDetail);
                                },
                                data: controller.packagesList[index],
                                isLastItem:
                                    controller.packagesList.length == index,
                              );
                            },
                          )
                        : Center(
                            child: Text(
                              'Hiện tại chưa có gói khám nào.',
                              textAlign: TextAlign.center,
                              style: Styles.content,
                            ),
                          ),
                  ),
                )
              ],
            );
          }
        }),
        onRefresh: () async {
          controller.refreshList();
        },
      ),
    );
  }
}
