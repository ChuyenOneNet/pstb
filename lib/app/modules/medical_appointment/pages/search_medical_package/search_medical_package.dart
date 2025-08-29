import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/medical_appointment/pages/medical_package/medical_package_store.dart';
import 'package:pstb/app/modules/medical_appointment/pages/search_medical_package/widgets/item_package_search.dart';
import 'package:pstb/widgets/stateless/custom_autocomplete_basic.dart';
import '../../../../../utils/colors.dart';
import '../../../../../utils/routes.dart';
import '../../../../../utils/styles.dart';
import '../../../../user_app_store.dart';
import '../../medical_appointment_store.dart';

class SearchMedicalPackage extends StatelessWidget {
  SearchMedicalPackage({Key? key}) : super(key: key);

  final UserAppStore _userAppStore = Modular.get<UserAppStore>();
  final MedicalPackageStore _medicalPackageStore =
      Modular.get<MedicalPackageStore>();
  final MedicalAppointmentStore _appointmentStore =
      Modular.get<MedicalAppointmentStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Stack(
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Modular.to.pop();
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Center(
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    CustomAutocompleteBasic(
                      store: _medicalPackageStore,
                      keywordSearch: _medicalPackageStore.keywordSearch,
                      onSubmitted: (value) async {
                        await _medicalPackageStore.getSearchPackages(value);
                        _medicalPackageStore.keyword = value;
                        Modular.to.popAndPushNamed(AppRoutes.packageSearch);
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Tìm kiếm gần nhất',
                    style: Styles.heading4.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: ItemMedicalPackageSearch(
                    data: _userAppStore.medicalPackage),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Gợi ý cho bạn',
                    style: Styles.heading4.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      final medicalPackage =
                          _medicalPackageStore.packagesList[index];
                      return InkWell(
                        onTap: () {
                          _appointmentStore.setPackageDetail(medicalPackage);
                          _appointmentStore.addPackageToShowed(medicalPackage);
                          bool examAtHome = medicalPackage.examAtHome ?? false;
                          bool testAtHome = medicalPackage.testAtHome ?? false;
                          _appointmentStore.setExamAtHome(examAtHome);
                          _appointmentStore.setTestAtHome(testAtHome);
                          _medicalPackageStore
                              .navigateTo(AppRoutes.medicalPackageDetail);
                        },
                        child: ItemMedicalPackageSearch(data: medicalPackage),
                      );
                    },
                    itemCount: _medicalPackageStore.packagesList.length,
                    physics: const ClampingScrollPhysics(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
