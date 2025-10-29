class CrmIds {
  final String? customerId;
  final String? bookingId;
  const CrmIds({this.customerId, this.bookingId});
}

CrmIds parseCrmIds(String? message) {
  if (message == null) return const CrmIds();
  final customerMatch = RegExp(r'Customer\s*ID:\s*(\d+)', caseSensitive: false)
      .firstMatch(message);
  final bookingMatch = RegExp(r'Booking\s*ID:\s*(\d+)', caseSensitive: false)
      .firstMatch(message);
  return CrmIds(
    customerId: customerMatch?.group(1),
    bookingId: bookingMatch?.group(1),
  );
}
