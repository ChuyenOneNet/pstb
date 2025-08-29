class QRProcessor {
  /// Processes QR code data from Vietnamese CCCD
  /// Calls onSuccess with parsed data or onError with error message
  static void processQRData(
    String qrData, {
    required Function(Map<String, String>) onSuccess,
    required Function(String) onError,
  }) {
    try {
      // CCCD QR format: ID||Name|DOB|Gender|Address|IssueDate
      List<String> data = qrData.split('|');

      if (data.length >= 7) {
        final parsedData = {
          'cccd': data[0],
          'name': data[2],
          'birthDate': _formatDate(data[3]),
          'gender': _parseGender(data[4]),
          'address': data[5],
          'issueDate': _formatDate(data[6]),
        };

        onSuccess(parsedData);
      } else {
        throw Exception('Dữ liệu QR không đủ trường');
      }
    } catch (e) {
      onError(e.toString());
    }
  }

  /// Converts date from DDMMYYYY format to DD/MM/YYYY
  static String _formatDate(String rawDate) {
    if (rawDate.length == 8) {
      final day = rawDate.substring(0, 2);
      final month = rawDate.substring(2, 4);
      final year = rawDate.substring(4, 8);
      return '$day/$month/$year';
    }
    return rawDate; // fallback if format is different
  }

  /// Parses gender from Vietnamese text
  static String _parseGender(String rawGender) {
    String gender = rawGender.toLowerCase();
    return gender.contains('nam') ? 'Nam' : 'Nữ';
  }
}
