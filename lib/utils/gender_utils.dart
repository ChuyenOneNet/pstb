import 'package:pstb/app/modules/medical_appointment/pages/medical_date_picker/widget/type_gender_widget.dart';

class GenderUtils {
  static String parseGender(int gender) {
    switch (gender) {
      case 0:
        return "Nam";
      case 1:
        return "Nữ";
      case 2:
        return "Khác";
      default:
        return "";
    }
  }

  static String parseGenderString(String gender) {
    switch (gender) {
      case 'm':
        return "Nam";
      case "f":
        return "Nữ";
      default:
        return "";
    }
  }

  static int parseGenderBackend(GenderType genderType) {
    switch (genderType) {
      case GenderType.m:
        return 0;
      case GenderType.f:
        return 1;
      default:
        return 3;
    }
  }
}
