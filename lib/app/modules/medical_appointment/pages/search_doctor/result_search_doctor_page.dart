import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/medical_appointment/medical_appointment_store.dart';
import 'package:pstb/utils/colors.dart';

import '../../../../../utils/routes.dart';
import '../../../../../utils/styles.dart';
import '../select_doctor/select_doctor_store.dart';
import '../select_doctor/widgets/doctor_item.dart';

class ResultSearchDoctorPage extends StatefulWidget {
  const ResultSearchDoctorPage({Key? key}) : super(key: key);

  @override
  State<ResultSearchDoctorPage> createState() => _ResultSearchDoctorPageState();
}

class _ResultSearchDoctorPageState extends State<ResultSearchDoctorPage> {
  final SelectDoctorStore controller = Modular.get<SelectDoctorStore>();
  final MedicalAppointmentStore _medicalAppointmentStore =
      Modular.get<MedicalAppointmentStore>();
  late ScrollController _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Column(
            children: [
              Text(
                'Kết quả tìm kiếm câu hỏi: ${controller.keyword}',
                style: Styles.titleItem,
              ),
              const Divider(
                color: Colors.black,
              ),
              Expanded(
                child: Observer(builder: (context) {
                  return controller.listDoctorSearch.isNotEmpty
                      ? ListView.builder(
                          controller: _scrollController,
                          padding: EdgeInsets.zero,
                          itemBuilder: (_, index) {
                            final currentItem =
                                controller.listDoctorSearch[index];
                            return InkWell(
                              splashColor: AppColors.transparent,
                              highlightColor: AppColors.transparent,
                              onTap: () {
                                _medicalAppointmentStore
                                    .chooseDoctor(currentItem);
                                if (currentItem.id == null) return;
                                if (currentItem.attrs == null) return;
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
                          },
                          itemCount: controller.listDoctorSearch.length,
                        )
                      : Text(
                          'Không tìm thấy bác sĩ!',
                          textAlign: TextAlign.center,
                          style: Styles.content,
                        );
                }),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: InkWell(
                  onTap: () {
                    Modular.to.pop();
                  },
                  child: Container(
                      color: Colors.black.withOpacity(0.4),
                      child: const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.chevron_left,
                          size: 36,
                          color: AppColors.background,
                        ),
                      )),
                )),
          ),
        ],
      ),
    );
  }
}
