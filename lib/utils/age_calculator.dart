class AgeCalculator {
  /// Calculates age from birth date string in dd/MM/yyyy format
  /// Returns 0 if the date format is invalid
  static int calculateAge(String birthDateString) {
    try {
      final parts = birthDateString.split('/');
      if (parts.length != 3) return 0;

      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);

      final birthDate = DateTime(year, month, day);
      final today = DateTime.now();

      // Check if the parsed date is valid
      if (birthDate.year != year ||
          birthDate.month != month ||
          birthDate.day != day) {
        return 0;
      }

      // Check if birth date is not in the future
      if (birthDate.isAfter(today)) {
        return 0;
      }

      int age = today.year - birthDate.year;

      // Adjust age if birthday hasn't occurred this year yet
      if (today.month < birthDate.month ||
          (today.month == birthDate.month && today.day < birthDate.day)) {
        age--;
      }

      return age;
    } catch (_) {
      return 0;
    }
  }

  /// Validates if the given age matches the calculated age from birth date
  static bool validateAgeConsistency(String birthDateString, String ageString) {
    final calculatedAge = calculateAge(birthDateString);
    final inputAge = int.tryParse(ageString);

    if (calculatedAge == 0 || inputAge == null) return false;

    // Allow 1 year difference to account for timing differences
    return (calculatedAge - inputAge).abs() <= 1;
  }
}
