import '../../domain/entities/history_entry.dart';

class HistoryEntryDb {
  static const table = 'booking_history';

  static Map<String, Object?> toRow(HistoryEntry e, String userPhone) => {
        'id': e.id,
        'user_phone': normalizePhone(userPhone),
        'patient_name': e.patientName,
        'phone': e.phone,
        'service_name': e.serviceName,
        'visit_date_iso': e.visitDateIso,
        'visit_time_iso': e.visitTimeIso,
        'branch': e.branch,
        'status': e.status,
        'created_at_iso': e.createdAtIso,
      };

  static HistoryEntry fromRow(Map<String, Object?> m) => HistoryEntry(
        id: (m['id'] as String?) ?? '',
        patientName: (m['patient_name'] as String?) ?? '',
        phone: (m['phone'] as String?) ?? '',
        serviceName: (m['service_name'] as String?) ?? '',
        visitDateIso: (m['visit_date_iso'] as String?) ?? '',
        visitTimeIso: (m['visit_time_iso'] as String?) ?? '',
        branch: (m['branch'] as String?) ?? '',
        status: (m['status'] as String?) ?? '',
        createdAtIso: (m['created_at_iso'] as String?) ?? '',
      );

  static String normalizePhone(String raw) {
    final digits = raw.replaceAll(RegExp(r'\D'), '');
    if (digits.startsWith('84')) return '0${digits.substring(2)}';
    return digits;
  }
}
