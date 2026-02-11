/// Date utilities for grouping, filtering, and formatting
class DateUtilsHelper {
  /// Parse date string (dd/MM/yyyy format)
  static DateTime parseDate(String dateStr) {
    try {
      final parts = dateStr.split('/');
      return DateTime(
        int.parse(parts[2]),
        int.parse(parts[1]),
        int.parse(parts[0]),
      );
    } catch (e) {
      return DateTime(1970);
    }
  }

  /// Format DateTime to dd/MM/yyyy
  static String formatDate(DateTime? date) {
    if (date == null) return 'Không xác định';
    return '${date.day}/${date.month}/${date.year}';
  }

  /// Format DateTime with zero-padded (dd/MM/yyyy)
  static String formatDateDisplay(DateTime? date) {
    if (date == null) return '--';
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  /// Get display label (Hôm nay, Hôm qua, or date string)
  static String getDisplayDateLabel(String dateStr) {
    final dateObj = parseDate(dateStr);
    final now = DateTime.now();

    if (dateObj.year == now.year &&
        dateObj.month == now.month &&
        dateObj.day == now.day) {
      return 'Hôm nay';
    }

    if (dateObj.year == now.year &&
        dateObj.month == now.month &&
        dateObj.day == now.subtract(const Duration(days: 1)).day) {
      return 'Hôm qua';
    }

    return dateStr;
  }

  /// Convert dynamic dateModified to DateTime
  /// Handle both DateTime? (XN) and String? ISO (CĐHA)
  static DateTime? getDateModified(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    if (value is String) {
      if (value.isEmpty) return null;
      try {
        return DateTime.parse(value);
      } catch (_) {
        return null;
      }
    }
    return null;
  }
}
