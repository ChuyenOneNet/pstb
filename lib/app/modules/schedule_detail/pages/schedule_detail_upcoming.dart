import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/home/home_store.dart';
import 'package:pstb/app/models/bottom_sheet_models.dart';
import 'package:pstb/app/modules/schedule_detail/schedule_detail_store.dart';
import 'package:pstb/app/modules/schedule_detail/widgets/new_schedule_detail.dart';
import 'package:pstb/app/modules/schedule_detail/widgets/schedule_detail_bottomsheet_option.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../medical_appointment/medical_appointment_store.dart';

class ScheduleDetailUpcomingPage extends StatefulWidget {
  const ScheduleDetailUpcomingPage({Key? key}) : super(key: key);

  @override
  _ScheduleDetailUpcomingPageState createState() =>
      _ScheduleDetailUpcomingPageState();
}

class _ScheduleDetailUpcomingPageState
    extends State<ScheduleDetailUpcomingPage> {
  final ScheduleDetailStore _scheduleDetailStore =
      Modular.get<ScheduleDetailStore>();
  final MedicalAppointmentStore _medicalAppointmentStore =
      Modular.get<MedicalAppointmentStore>();
  final _homeStore = Modular.get<HomeStore>();

  @override
  void initState() {
    _scheduleDetailStore.changeBuildContext(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          actionIcon: const Icon(
            Icons.settings_outlined,
            color: AppColors.primary,
          ),
          actionFunc: () {
            showBarModalBottomSheet(
                context: context,
                builder: (context) => Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        BottomSheetOption(
                          listOption: _scheduleDetailStore.option,
                          onPressOption: (BottomSheetOptionModel item) {
                            Navigator.pop(context);
                            if (item.id == 2) {
                              Modular.to.pushNamed(
                                  AppRoutes.medicalLocationGetSample);
                            }
                            if (item.id == 3) {
                              if (_scheduleDetailStore
                                      .bookingDetail?.timeSeeDoctor ==
                                  null) {
                                _medicalAppointmentStore
                                    .setcheckTimeVisitDoctor(false);
                                Modular.to.pushNamed(
                                    AppRoutes.medicalTimeGetResultTest,
                                    arguments: {
                                      "booking":
                                          _scheduleDetailStore.bookingDetail
                                    });
                              } else {
                                _medicalAppointmentStore
                                    .setcheckTimeVisitDoctor(false);
                                Modular.to.pushNamed(
                                    AppRoutes.medicalTimeVisitDoctor,
                                    arguments: {
                                      "doctorId": _scheduleDetailStore
                                          .bookingDetail!.doctorId,
                                      "booking":
                                          _scheduleDetailStore.bookingDetail
                                    });
                              }
                            }
                            if (item.id == 4) {
                              showDialog(
                                context: context,
                                builder: (context) => DialogConfirm(
                                  buttonLeft: l10n(context)!.confirm,
                                  buttonRight: l10n(context)!.cancel,
                                  title: l10n(context)!
                                      .schedule_detail_cancel_confirm,
                                  subTitle: "",
                                  onButtonLeft: () {
                                    _homeStore.totalComingBooking--;
                                    Navigator.pop(context);
                                    _scheduleDetailStore.deleteSchedule(
                                        _scheduleDetailStore.bookingDetail!.id);
                                  },
                                  onButtonRight: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                barrierColor: AppColors.black.withOpacity(0.5));
          },
          title: l10n(context)!.schedule_detail_title,
        ),
        body: NewScheduleDetail());
  }
}
