import 'package:flutter/material.dart';
import 'package:pstb/utils/main.dart';

import 'schedule_detail_time_widget.dart';

class ScheduleDetailUpcomingTime extends StatelessWidget {
  final String scheduleSampleTime, scheduleExamTime;
  const ScheduleDetailUpcomingTime({
    Key? key,
    required this.scheduleSampleTime,
    required this.scheduleExamTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: widthConvert(context, 12),
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.background,
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: AppColors.neutral200,
            ),
          ),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: widthConvert(context, 20),
          vertical: widthConvert(context, 16),
        ),
        child: Column(
          children: [
            ScheduleDetailTimeWidget(
              title: l10n(context)!.schedule_sample_time!,
              description: scheduleSampleTime,
              onPressNotify: () {},
              hasNoti: true,
              titleColor: AppColors.neutral900,
            ),
            // SizedBox(
            //   height: widthConvert(context, 16),
            // ),
            // ScheduleDetailTimeWidget(
            //   title: l10n(context)!.schedule_exam_time!,
            //   description: scheduleExamTime,
            //   onPressNotify: () {},
            //   hasNoti: true,
            //   titleColor: AppColors.neutral900,
            // ),
          ],
        ),
      ),
    );
  }
}
