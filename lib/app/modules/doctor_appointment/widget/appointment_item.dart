import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/models/doctor_appointment/appointment_model.dart';
import 'package:pstb/app/modules/doctor_appointment/doctor_appointment_store.dart';
import 'package:pstb/app/modules/doctor_appointment/widget/appointment_info_widget.dart';
import 'package:pstb/app/modules/doctor_appointment/widget/appointment_time_widget.dart';
import 'package:pstb/utils/colors.dart';
import 'package:pstb/utils/helper.dart';

class AppointmentItem extends StatefulWidget {
  const AppointmentItem({Key? key, required this.currentItem})
      : super(key: key);

  final AppointmentModel currentItem;

  @override
  State<AppointmentItem> createState() => _AppointmentItemState();
}

class _AppointmentItemState extends State<AppointmentItem> {
  final DoctorAppointmentStore controller =
      Modular.get<DoctorAppointmentStore>();

  @override
  void initState() {
    // TODO: implement initState
    checkStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {},
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: widthConvert(context, 16),
        ),
        child: Container(
          margin: EdgeInsets.symmetric(
            vertical: widthConvert(context, 8),
          ),
          decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black.withOpacity(0.2))),
          child: Row(
            children: [
              AppointmentTime(
                timeSeeDoctor: widget.currentItem.timeSeeDoctor,
                timeGetSample: widget.currentItem.timeGetSample,
              ),
              AppointmentInfo(
                title: widget.currentItem.packageName ?? '',
                doctor: widget.currentItem.doctorName ?? '',
                timeGetSample: widget.currentItem.timeGetSample,
                status: controller.status,
                isUpcoming: false,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void checkStatus() {
    int i = widget.currentItem.status ?? 0;
    switch (i) {
      case 0:
        controller.onChangeStatus('Đang cập nhật');
        break;
      case 1:
        controller.onChangeStatus('Chờ');
        break;
      case 3:
        controller.onChangeStatus('Đã thực hiện');
        break;
    }
  }
}
