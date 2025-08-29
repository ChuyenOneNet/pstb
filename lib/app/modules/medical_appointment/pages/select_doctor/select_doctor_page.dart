import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/medical_appointment/medical_appointment_store.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/divider_custom_widget.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';
import 'package:loadmore/loadmore.dart';
import 'select_doctor_store.dart';
import 'widgets/doctor_item.dart';

class SelectDoctor extends StatefulWidget {
  const SelectDoctor({Key? key}) : super(key: key);

  @override
  _SelectDoctorState createState() => _SelectDoctorState();
}

class _SelectDoctorState extends ModularState<SelectDoctor, SelectDoctorStore> {
  final MedicalAppointmentStore _medicalAppointmentStore =
      Modular.get<MedicalAppointmentStore>();

  @override
  void initState() {
    controller.createBuildContext(context);
    controller
        .onGetListDoctor(_medicalAppointmentStore.selectedPackage.name ?? '');
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: l10n(context)!.select_doctor_title!,
        actionIcon: const Icon(Icons.search, color: AppColors.primary,),
        actionFunc: () {
          Modular.to.pushNamed(AppRoutes.searchDoctor, arguments: false);
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: Observer(
              builder: (context) {
                return RefreshIndicator(
                  onRefresh: () => controller.onRefresh(
                      _medicalAppointmentStore.selectedPackage.name ?? ''),
                  child: controller.listDoctor.isEmpty
                      ? Center(
                          child: Text(
                            'Không có dữ liệu.',
                            style: Styles.content
                                .copyWith(color: AppColors.black),
                          ),
                        )
                      : Container(
                          decoration: const BoxDecoration(color: Colors.white),
                          child: LoadMore(
                            isFinish: controller.isFinishLoadMore,
                            onLoadMore: controller.onLoadMore,
                            textBuilder: (status) {
                              return '';
                            },
                            delegate: LoadMoreDelegate.buildWidget(),
                            child: ListView.builder(
                                padding: const EdgeInsets.all(16),
                                // separatorBuilder: (_, index) {
                                //   return const DividerCustomWidget();
                                // },
                                itemCount: controller.lengthListDoctor,
                                physics: const ClampingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final currentItem =
                                      controller.listDoctor[index];
                                  return InkWell(
                                    splashColor: AppColors.transparent,
                                    highlightColor: AppColors.transparent,
                                    onTap: () {
                                      _medicalAppointmentStore
                                          .chooseDoctor(currentItem);
                                      if (currentItem.id == null) return;
                                      // if (currentItem.attrs == null) return;
                                      controller.navigateTo(
                                        AppRoutes.doctorInfo,
                                        currentItem.id!,
                                      );
                                    },
                                    child: DoctorItemWidget(
                                      name: currentItem.name,
                                      position: currentItem.position,
                                      avatar: currentItem.image,
                                    ),
                                  );
                                }),
                          ),
                        ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
