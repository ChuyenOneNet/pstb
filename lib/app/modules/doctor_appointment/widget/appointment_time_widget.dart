import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pstb/app/modules/schedule/widgets/schedule_time_widget.dart';
import 'package:pstb/utils/constants.dart';

class AppointmentTime extends StatelessWidget {
  const AppointmentTime({Key? key, this.timeSeeDoctor, this.timeGetSample})
      : super(key: key);

  final DateTime? timeSeeDoctor, timeGetSample;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          timeSeeDoctor != null
              ? ItemTime(
                  opacity: 1,
                  day: DateFormat(DateTimeFormatPattern.dd)
                      .format(timeSeeDoctor!.toLocal()),
                  month: DateFormat(DateTimeFormatPattern.mmyyyyy)
                      .format(timeSeeDoctor!.toLocal()),
                  hour: DateFormat(DateTimeFormatPattern.formatHHmm)
                      .format(timeSeeDoctor!.toLocal()),
                )
              : const ItemTime(
                  opacity: 1,
                  day: '      ',
                  month: '           ',
                  hour: '         ',
                ),
        ],
      ),
    );
  }
}
