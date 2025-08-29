import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/medical_appointment/pages/search_doctor/widgets/autocomplete_basic_doctor.dart';
import 'package:pstb/app/modules/medical_appointment/pages/select_doctor/select_doctor_store.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/custom_autocomplete_basic.dart';
import '../../../../user_app_store.dart';
import '../../medical_appointment_store.dart';
import '../select_doctor/widgets/doctor_item.dart';

class SearchDoctorPage extends StatelessWidget {
  SearchDoctorPage({Key? key}) : super(key: key);

  final UserAppStore _userAppStore = Modular.get<UserAppStore>();
  final MedicalAppointmentStore _medicalAppointmentStore =
      Modular.get<MedicalAppointmentStore>();
  final SelectDoctorStore _selectDoctorStore = Modular.get<SelectDoctorStore>();

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
                      store: _selectDoctorStore,
                      keywordSearch: _selectDoctorStore.keywordSearch,
                      onSubmitted: (value) async {
                        await _selectDoctorStore.getSearchDoctor(value);
                        _selectDoctorStore.keyword = value;
                        Modular.to.popAndPushNamed(AppRoutes.doctorSearch);
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
              Observer(builder: (context) {
                return _userAppStore.doctor.name == null ||
                        _userAppStore.doctor.name == ''
                    ? SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            'Bạn chưa tìm kiếm gần đây.',
                            style: Styles.subtitleSmallest,
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: InkWell(
                          onTap: () {
                            _medicalAppointmentStore
                                .chooseDoctor(_userAppStore.doctor);
                            _selectDoctorStore.navigateTo(
                                AppRoutes.doctorInfo, _userAppStore.doctor.id!);
                          },
                          child: DoctorItemWidget(
                            name: _userAppStore.doctor.name ?? '',
                            position: _userAppStore.doctor.position ?? '',
                            avatar: _userAppStore.doctor.image ?? '',
                          ),
                        ),
                      );
              }),
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
              if (_selectDoctorStore.listDoctor.length >= 2)
                Observer(builder: (context) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          final doctor = _selectDoctorStore.listDoctor[index];
                          return InkWell(
                            onTap: () {
                              _medicalAppointmentStore.chooseDoctor(doctor);
                              _selectDoctorStore.navigateTo(
                                  AppRoutes.doctorInfo, doctor.id!);
                            },
                            child: DoctorItemWidget(
                              name: doctor.name ?? '',
                              position: doctor.position ?? '',
                              avatar: doctor.image ?? '',
                            ),
                          );
                        },
                        itemCount: 2,
                        physics: const ClampingScrollPhysics(),
                      ),
                    ),
                  );
                })
              else
                const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
