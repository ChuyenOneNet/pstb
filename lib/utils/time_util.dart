import 'package:intl/intl.dart';
import 'package:pstb/utils/main.dart';

import '../app/modules/medical_appointment/pages/medical_date_picker/model/TimeObject.dart';

class TimeUtil {
  static String DDMMYYYY = 'dd/MM/yyyy';
  static String DDMMYYYYHHMM = 'dd/MM/yyyy HH:mm';
  static String HHMMDDMMYYYY = 'HH:mm dd/MM/yyyy';
  static String ViewDateFormat = DDMMYYYY;

  static String format(DateTime dateTime, String format) {
    return DateFormat(format).format(dateTime);
  }

  static String toTimeEvent(DateTime dateTime) {
    return DateFormat(DateTimeFormatPattern.dateFlowServer).format(dateTime);
  }

  static String toBackendString(DateTime dateTime) {
    return DateFormat(DateTimeFormatPattern.backendTimeFormat).format(dateTime);
  }

  static String? convertString(
      String source, String sourceFormat, String desFormat) {
    try {
      var time = DateFormat(sourceFormat).parse(source);
      return DateFormat(desFormat).format(time);
    } catch (e) {
      return null;
    }
  }

  static List<TimeObject> createListTimeObject(int startHour, int endHour,
      String startMinutes, String endMinutes, int startDays) {
    var day = DateTime.now().add(Duration(days: startDays)).day;
    var month = DateTime.now().add(Duration(days: startDays)).month;
    var year = DateTime.now().add(Duration(days: startDays)).year;
    var startTime =
        DateTime(year, month, day, startHour, int.parse(startMinutes), 00);
    var endTime =
        DateTime(year, month, day, endHour, int.parse(endMinutes), 00);
    int length = (endTime.difference(startTime).inMinutes / 30).round();

    List<TimeObject> list = [];

    for (int i = 0; i < length + 1; i++) {
      list.add(TimeObject(id: i, date: startTime));
      startTime = startTime.add(const Duration(minutes: 30));

      // list.add(TimeObject(
      //     id: i, date: DateTime(year, month, day, i + startHour, 00, 00)));
      // list.add(TimeObject(
      //     id: i + 1, date: DateTime(year, month, day, i + startHour, 30, 00)));
      // if (i == 0) {
      //   if (minutes == startMinutes) {
      //     list.add(TimeObject(
      //         id: i, date: DateTime(year, month, day, i + startHour, 00, 00)));
      //     list.add(TimeObject(
      //         id: i + 1,
      //         date: DateTime(year, month, day, i + startHour, 30, 00)));
      //   } else {
      //     list.add(TimeObject(
      //         id: i, date: DateTime(year, month, day, i + startHour, 30, 00)));
      //   }
      // } else if (i == length) {
      //   if (minutes == endMinutes) {
      //     list.add(TimeObject(
      //         id: i, date: DateTime(year, month, day, i + startHour, 00, 00)));
      //   } else {
      //     list.add(TimeObject(
      //         id: i, date: DateTime(year, month, day, i + startHour, 00, 00)));
      //     list.add(TimeObject(
      //         id: i + 1,
      //         date: DateTime(year, month, day, i + startHour, 30, 00)));
      //   }
      // } else {
      //   list.add(TimeObject(
      //       id: i, date: DateTime(year, month, day, i + startHour, 00, 00)));
      //   list.add(TimeObject(
      //       id: i + 1,
      //       date: DateTime(year, month, day, i + startHour, 30, 00)));
      // }
    }
    return list;
  }
}
