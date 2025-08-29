import 'package:flutter/material.dart';
import 'package:pstb/app/modules/schedule_detail/widgets/schedule_detail_basic.dart';
import 'package:pstb/utils/colors.dart';

class AppointmentInfo extends StatelessWidget {
  const AppointmentInfo(
      {Key? key,
      this.title,
      this.doctor,
      this.timeGetSample,
      this.status,
      this.isUpcoming})
      : super(key: key);

  final String? title;
  final String? doctor;
  final DateTime? timeGetSample;
  final String? status;
  final bool? isUpcoming;

  @override
  Widget build(BuildContext context) {
    return BasicInfo(
      username: 'Nguyen Tuan',
      title: title,
      doctor: doctor,
      timeGetSample: timeGetSample,
      status: status,
      isUpcoming: isUpcoming!,
    );
  }
}
