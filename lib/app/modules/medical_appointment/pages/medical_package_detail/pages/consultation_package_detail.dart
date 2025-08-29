import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';

import '../../../medical_appointment_store.dart';
import '../medical_package_detail_store.dart';
import '../widgets/book_now_widget.dart';

class ConsultationPackageDetailPage extends StatefulWidget {
  const ConsultationPackageDetailPage({Key? key}) : super(key: key);

  @override
  _ConsultationPackageDetailPageState createState() =>
      _ConsultationPackageDetailPageState();
}

class _ConsultationPackageDetailPageState extends ModularState<
    ConsultationPackageDetailPage, MedicalPackageDetailStore> {
  final MedicalAppointmentStore _appointmentStore =
      Modular.get<MedicalAppointmentStore>();

  @override
  void initState() {
    controller.addListener(context, 375);
    controller.getBookingAdvisory(_appointmentStore.selectedPackage.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => Scaffold(
        appBar: CustomAppBar(
          backgroundColor: AppColors.primary,
          title: _appointmentStore.selectedPackage.name!,
        ),
        body: controller.loadingPackageDetail
            ? const SizedBox()
            : SingleChildScrollView(
                controller: controller.scrollController,
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: heightConvert(context, 108),
                  ),
                  child: Column(
                    children: const [
                      // BasicInformation(
                      //   setSizeOfView: (height) =>
                      //       controller.addListener(context, height),
                      // ),
                      // PackageServiceWidget(
                      //   data: controller.package.packageService,
                      // ),
                      // PackageProcedure(
                      //   procedure: controller.package.examinationProcedure!,
                      // ),
                      // PackageTested(controller: controller),
                      // PackageNotice(
                      //   description: controller.package.description!,
                      // ),
                    ],
                  ),
                ),
              ),
        bottomSheet: controller.scrollIsReached
            ? Container(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadowBaseShadow,
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset: Offset(4, 0), // changes position of shadow
                    ),
                  ],
                ),
                height: heightConvert(context, 108),
                child: BookNowWidget(),
              )
            : const SizedBox(),
      ),
    );
  }
}
