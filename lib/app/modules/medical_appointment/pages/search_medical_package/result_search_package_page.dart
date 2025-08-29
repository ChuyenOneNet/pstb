import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/medical_appointment/medical_appointment_store.dart';
import 'package:pstb/app/modules/medical_appointment/pages/medical_package/medical_package_store.dart';
import 'package:pstb/utils/colors.dart';
import 'package:pstb/utils/styles.dart';
import 'package:pstb/widgets/stateless/app_bar.dart';
import 'package:pstb/widgets/stateless/button_back.dart';
import '../../../../../utils/routes.dart';
import '../../../../../widgets/stateless/package_items/package_item.dart';
import '../../../../user_app_store.dart';

class ResultSearchPackagePage extends StatefulWidget {
  const ResultSearchPackagePage({Key? key}) : super(key: key);

  @override
  State<ResultSearchPackagePage> createState() =>
      _ResultSearchPackagePageState();
}

class _ResultSearchPackagePageState extends State<ResultSearchPackagePage> {
  final MedicalAppointmentStore _appointmentStore =
      Modular.get<MedicalAppointmentStore>();
  final MedicalPackageStore controller = Modular.get<MedicalPackageStore>();
  final UserAppStore _userAppStore = Modular.get<UserAppStore>();
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_loadMoreItems);
    controller.createBuildContext(context);
    // TODO: implement initState
  }

  Future<void> _loadMoreItems() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      await controller.loadMoreSearchPackages(controller.keyword);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_loadMoreItems);
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            RefreshIndicator(
              child: Observer(builder: (_) {
                if (controller.loadingPackage) {
                  return const SizedBox();
                } else {
                  return Stack(
                    children: [
                      Column(
                        children: [
                          Text(
                            'Kết quả tìm kiếm gói khám: ${controller.keyword}',
                            style: Styles.titleItem,
                          ),
                          const Divider(
                            color: Colors.black,
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  Styles.defaultPageMargin.copyWith(top: 8),
                              child: controller.listPackageSearch.isNotEmpty
                                  ? ListView.builder(
                                      controller: _scrollController,
                                      physics:
                                          const AlwaysScrollableScrollPhysics(),
                                      itemCount:
                                          controller.listPackageSearch.length,
                                      itemBuilder: (_, index) {
                                        return PackageItemWidget(
                                          index: index,
                                          onTap: () {
                                            _userAppStore.medicalPackage =
                                                controller
                                                    .listPackageSearch[index];
                                            _appointmentStore.setPackageDetail(
                                                controller
                                                    .listPackageSearch[index]);
                                            _appointmentStore
                                                .addPackageToShowed(controller
                                                    .listPackageSearch[index]);
                                            bool examAtHome = controller
                                                    .listPackageSearch[index]
                                                    .examAtHome ??
                                                false;
                                            bool testAtHome = controller
                                                    .listPackageSearch[index]
                                                    .testAtHome ??
                                                false;
                                            _appointmentStore
                                                .setExamAtHome(examAtHome);
                                            _appointmentStore
                                                .setTestAtHome(testAtHome);
                                            controller.navigateTo(
                                                AppRoutes.medicalPackageDetail);
                                          },
                                          data: controller
                                              .listPackageSearch[index],
                                          isLastItem: controller
                                                  .listPackageSearch.length ==
                                              index,
                                        );
                                      },
                                    )
                                  : Center(
                                      child: Text(
                                        'Không có gói khám phù hợp.',
                                        textAlign: TextAlign.center,
                                        style: Styles.content,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                      const ButtonBackWidget(),
                    ],
                  );
                }
              }),
              onRefresh: () async {
                // controller.refreshList();
              },
            ),
          ],
        ),
      ),
    );
  }
}
