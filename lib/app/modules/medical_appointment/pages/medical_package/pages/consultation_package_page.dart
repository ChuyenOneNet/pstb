import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/medical_appointment/medical_appointment_store.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateful/stateful_widget.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';

import '../medical_package_store.dart';

class ConsultationPackagePage extends StatefulWidget {
  const ConsultationPackagePage() : super();

  @override
  _ConsultationPackagePageState createState() =>
      _ConsultationPackagePageState();
}

class _ConsultationPackagePageState
    extends ModularState<ConsultationPackagePage, MedicalPackageStore> {
  final MedicalAppointmentStore _appointmentStore =
      Modular.get<MedicalAppointmentStore>();

  @override
  void initState() {
    _appointmentStore.setConsultation(true);
    controller.createBuildContext(context);
    controller.getAdvisory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Scaffold(
        appBar: AppBarSearch(
          onSubmitSearch: (String? value) {},
          onSubmitFilter: (FilterObject? valueSortBy,
              FilterObject? valueCategory,
              FilterObject? valueTime,
              FilterObject? valuePrice) {},
          listSortBy: const [FilterObject(id: 1, name: 'someThing')],
          listTime: const [FilterObject(id: 1, name: 'someThing')],
          listCategory: const [FilterObject(id: 1, name: 'someThing')],
          listPrice: const [FilterObject(id: 1, name: 'someThing')],
          title: l10n(context)!.consultation_title!,
          isShowFilter: false,
        ),
        body: controller.loadingPackage
            ? Center(
                child: AppCircleLoading(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Observer(
                      builder: (context) {
                        return Wrap(
                          children: List.generate(
                            controller.packagesList.length,
                            (index) => MedicalPackageGroup(
                              // title: controller.packagesList[index].title!,
                              data: controller.packagesList,
                              onPress: (data) {
                                _appointmentStore.setPackageDetail(data);
                                controller
                                    .navigateTo(AppRoutes.medicalPackageDetail);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
      );
    });
  }
}
