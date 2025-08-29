class AgeUtils {
  DateTime birthday;

  AgeUtils(this.birthday);

  int calculatedAge() {
    final yearNow = DateTime.now().year;
    final monthNow = DateTime.now().month;
    final dayNow = DateTime.now().day;
    if (birthday.year != yearNow) {
      return yearNow - birthday.year;
    } else if (monthNow != birthday.month) {
      return monthNow - birthday.month;
    }
    return dayNow - birthday.day;
  }

  String typeAge() {
    final yearNow = DateTime.now().year;
    final monthNow = DateTime.now().month;
    if (birthday.year != yearNow) {
      return 'tuổi';
    } else if (monthNow != birthday.month) {
      return 'tháng tuổi';
    }
    return 'ngày tuổi';
  }
}
