import 'package:intl/intl.dart';

class FormatUtil {
  static String formatMoney(int? money) {
    final oCcy = NumberFormat("#,##0", "en_US");
    return money == null ? '' : oCcy.format(money);
  }

  static String formatDateTime(String date) {
    var newTime = "";
    newTime = date.split("/")[2] +
        "-" +
        date.split('/')[1] +
        "-" +
        date.split("/")[0];
    return newTime;
  }
}
