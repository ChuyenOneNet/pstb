import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/schedule_detail/widgets/schedule_detail_basic.dart';
import 'package:pstb/utils/main.dart';

import '../../../user_app_store.dart';

class ScheduleItemBasic extends StatelessWidget {
  final UserAppStore _appStore = Modular.get<UserAppStore>();
  final String? title;
  final String? doctor;
  final DateTime? timeGetSample;
  final String? status;
  final bool? isUpcoming;

  ScheduleItemBasic({
    Key? key,
    this.title,
    this.doctor,
    this.status,
    this.isUpcoming,
    this.timeGetSample,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BasicInfo(
          username: _appStore.getUserName,
          title: title,
          doctor: doctor,
          timeGetSample: timeGetSample,
          status: status,
          isUpcoming: isUpcoming!,
        ),
        const Icon(
          Icons.chevron_right,
          color: AppColors.lightSilver,
        ),
      ],
    );
  }
}
