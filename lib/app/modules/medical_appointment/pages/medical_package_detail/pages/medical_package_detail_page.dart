import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/medical_appointment/medical_appointment_store.dart';
import 'package:pstb/app/modules/medical_appointment/pages/medical_date_picker/medical_store.dart';
import 'package:pstb/app/modules/medical_appointment/pages/medical_package_detail/pages/other_package.dart';
import 'package:pstb/app/route_guard.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';
import '../../../../../user_app_store.dart';
import '../../medical_package/medical_package_store.dart';
import '../medical_package_detail_store.dart';
import '../widgets/basic_infomation.dart';
import 'basic_package.dart';

class MedicalPackageDetailPage extends StatefulWidget {
  const MedicalPackageDetailPage({Key? key}) : super(key: key);

  @override
  _MedicalPackageDetailPageState createState() =>
      _MedicalPackageDetailPageState();
}

class _MedicalPackageDetailPageState
    extends ModularState<MedicalPackageDetailPage, MedicalPackageDetailStore>
    with SingleTickerProviderStateMixin {
  final MedicalAppointmentStore _appointmentStore =
      Modular.get<MedicalAppointmentStore>();
  final UserAppStore _userAppStore = Modular.get<UserAppStore>();

  final MedicalStore _medicalStore = Modular.get<MedicalStore>();
  final MedicalPackageStore _medicalPackageStore =
      Modular.get<MedicalPackageStore>();
  late TabController tabController = TabController(length: 3, vsync: this);
  int indexPage = 0;

  @override
  void initState() {
    super.initState();
    _medicalStore.resetState();
    controller.otherPackages.clear();
    controller.getNewPackageDetail(_appointmentStore.selectedPackage.id!);
  }

  final UserGuard _userGuard = UserGuard();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Chi tiết gói dịch vụ',
        isBack: true,
        onBack: () {
          _medicalPackageStore.getPackages();
          Modular.to.pop();
        },
      ),
      // backgroundColor: Colors.white,
      body: Observer(
        builder: (_) => Column(children: [
          Expanded(
            child: Column(
              children: [
                BasicInformation(
                  data: _appointmentStore.selectedPackage,
                ),
                _renderWidget(
                    _appointmentStore.selectedPackage.testAtHome ?? false),
                const Align(
                    alignment: Alignment.bottomCenter, child: OtherPackage()),
                Row(
                  children: [
                    const Spacer(),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
                        child: AppButton(
                          labelStyle: Styles.titleButton,
                          title: 'Đặt lịch',
                          onPressed: () async {
                            _userAppStore.setVisibleSelectDoctor(true);
                            _appointmentStore.setcheckTimeVisitDoctor(true);
                            UserStatus isLogin = await _userGuard.canActivate();
                            if (isLogin == UserStatus.Signed) {
                              // with package, not select doctor.
                              // if (controller.isCovidPackage) {
                              //   controller
                              //       .navigateTo(AppRoutes.medicalAppointmentCovidDeclaration);
                              //   return;
                              // }
                              // Modular.to.pushNamed(AppRoutes.medicalTimeVisitDoctor,
                              //     arguments: {"doctorId": null, "booking": null});

                              //TODO:
                              if (_appointmentStore.examAtHome ||
                                  _appointmentStore.testAtHome) {
                                controller.nextPageWithPostInfo();
                              } else {
                                controller.nextPage();
                              }
                            } else {
                              Modular.to.pushNamed(
                                AppRoutes.authGuardPage,
                                arguments: {
                                  "isNotFromBottomNav": true,
                                  "title": 'Đặt lịch khám bệnh'
                                },
                              );
                            }
                            // if (isLogin == UserStatus.NoData) {
                            //
                            // }
                          },
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget _renderWidget(bool isTestAtHome) {
    return Expanded(
        child: controller.loadingPackageDetail
            ? const SizedBox()
            : SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  children: [
                    Column(
                      children: controller.otherPackages
                          .map(
                            (element) => PackageMedicalDetails(
                                packageDetailModel: element),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ));
  }
}
