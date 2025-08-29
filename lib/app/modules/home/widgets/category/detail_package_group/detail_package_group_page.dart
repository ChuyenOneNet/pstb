import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/home/widgets/category/detail_package_group/detail_package_store.dart';
import 'package:pstb/app/modules/medical_appointment/medical_appointment_store.dart';
import 'package:pstb/app/modules/medical_appointment/pages/medical_package/medical_package_store.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/package_items/package_item.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';

class DetailPackageGroupPage extends StatefulWidget {
  const DetailPackageGroupPage({Key? key}) : super(key: key);

  @override
  State<DetailPackageGroupPage> createState() => _DetailPackageGroupPageState();
}

class _DetailPackageGroupPageState extends State<DetailPackageGroupPage> {
  final _controller = Modular.get<DetailPackageStore>();
  final _appointmentStore = Modular.get<MedicalAppointmentStore>();
  final _medicalPackageStore = Modular.get<MedicalPackageStore>();
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController()..addListener(_loadMoreItems);
    super.initState();
  }

  @override
  void dispose() {
    _controller.listPackage = [];
    _scrollController.removeListener(_loadMoreItems);
    super.dispose();
  }

  Future<void> _loadMoreItems() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      await _controller.loadMorePackage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      if (_controller.isLoading) {
        return const AppCircleLoading();
      }
      return Scaffold(
        appBar: CustomAppBar(
          title: _controller.titleAppbar,
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await _controller.onRefreshPackage();
          },
          child: Observer(builder: (context) {
            if (_controller.isLoading) {
              return const SizedBox();
            }
            return ListView.builder(
              shrinkWrap: true,
              controller: _scrollController,
              padding: const EdgeInsets.all(16.0),
              itemBuilder: (_, index) {
                final package = _controller.listPackage[index];
                return PackageItemWidget(
                  index: index,
                  data: package,
                  isLastItem: true,
                  onTap: () {
                    _controller.otherListPackage
                        .addAll(_controller.listPackage);
                    _controller.otherListPackage
                        .removeWhere((element) => element.id == package.id);
                    _appointmentStore.setPackageDetail(package);
                    _appointmentStore.addPackageToShowed(package);
                    bool examAtHome = package.examAtHome ?? false;
                    bool testAtHome = package.testAtHome ?? false;
                    _appointmentStore.setExamAtHome(examAtHome);
                    _appointmentStore.setTestAtHome(testAtHome);
                    _medicalPackageStore.setPackageGroup(true);
                    Modular.to.pushNamed(AppRoutes.medicalPackageDetail);
                  },
                );
              },
              itemCount: _controller.listPackage.length,
            );
          }),
        ),
      );
    });
  }
}
