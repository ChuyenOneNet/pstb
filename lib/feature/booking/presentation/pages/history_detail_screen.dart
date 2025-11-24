// lib/app/modules/booking/history_detail_screen.dart
import 'package:flutter/material.dart';
import '../../domain/entities/history_entry.dart';

// Blue & White Color Scheme
class BookingColors {
  static const primaryBlue = Color(0xFF1976D2);
  static const lightBlue = Color(0xFF42A5F5);
  static const darkBlue = Color(0xFF0D47A1);
  static const accentBlue = Color(0xFF2196F3);
  static const white = Color(0xFFFFFFFF);
  static const lightGray = Color(0xFFF5F7FA);
  static const borderGray = Color(0xFFE0E0E0);
  static const textDark = Color(0xFF212121);
  static const textGray = Color(0xFF757575);
}

class HistoryDetailScreen extends StatelessWidget {
  final HistoryEntry entry;
  const HistoryDetailScreen({Key? key, required this.entry}) : super(key: key);

  String _formatIsoDate(String iso) {
    try {
      final dt = DateTime.parse(iso).toLocal();
      final d = dt.day.toString().padLeft(2, '0');
      final m = dt.month.toString().padLeft(2, '0');
      final y = dt.year;
      return '$d/$m/$y';
    } catch (_) {
      return iso;
    }
  }

  String _formatIsoTime(String iso) {
    try {
      final dt = DateTime.parse(iso).toLocal();
      final hh = dt.hour.toString().padLeft(2, '0');
      final mm = dt.minute.toString().padLeft(2, '0');
      return '$hh:$mm';
    } catch (_) {
      return iso;
    }
  }

  String _formatIsoDateTime(String iso) {
    try {
      final dt = DateTime.parse(iso).toLocal();
      final d = dt.day.toString().padLeft(2, '0');
      final m = dt.month.toString().padLeft(2, '0');
      final y = dt.year;
      final hh = dt.hour.toString().padLeft(2, '0');
      final mm = dt.minute.toString().padLeft(2, '0');
      return '$d/$m/$y • $hh:$mm';
    } catch (_) {
      return iso;
    }
  }

  Color _statusColor(String status) {
    final s = status.toLowerCase();
    if (s.contains('confirm') || s.contains('confirmed'))
      return BookingColors.primaryBlue;
    if (s.contains('pending')) return Colors.orange.shade600;
    if (s.contains('cancel') || s.contains('huỷ') || s.contains('huy'))
      return Colors.red.shade600;
    return BookingColors.textGray;
  }

  IconData _statusIcon(String status) {
    final s = status.toLowerCase();
    if (s.contains('confirm') || s.contains('confirmed'))
      return Icons.check_circle;
    if (s.contains('pending')) return Icons.schedule;
    if (s.contains('cancel') || s.contains('huỷ') || s.contains('huy'))
      return Icons.cancel;
    return Icons.info;
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor(entry.status);
    final statusIconData = _statusIcon(entry.status);

    return Scaffold(
      backgroundColor: BookingColors.lightGray,
      appBar: AppBar(
        title: const Text(
          'Chi tiết lịch hẹn',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: BookingColors.white,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: BookingColors.white),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                BookingColors.primaryBlue,
                BookingColors.lightBlue,
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    statusColor.withOpacity(0.1),
                    statusColor.withOpacity(0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: statusColor.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      statusIconData,
                      size: 40,
                      color: statusColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    entry.status,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: statusColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Patient Information Card
            _DetailCard(
              title: 'Thông tin bệnh nhân',
              icon: Icons.person,
              children: [
                _DetailRow(
                  icon: Icons.badge,
                  label: 'Mã lịch hẹn',
                  value: entry.id,
                ),
                _DetailRow(
                  icon: Icons.person_outline,
                  label: 'Họ và tên',
                  value: entry.patientName,
                ),
                _DetailRow(
                  icon: Icons.phone,
                  label: 'Số điện thoại',
                  value: entry.phone,
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Appointment Information Card
            _DetailCard(
              title: 'Thông tin lịch hẹn',
              icon: Icons.calendar_month,
              children: [
                _DetailRow(
                  icon: Icons.medical_services,
                  label: 'Dịch vụ',
                  value: entry.serviceName,
                ),
                _DetailRow(
                  icon: Icons.calendar_today,
                  label: 'Ngày khám',
                  value: _formatIsoDate(entry.visitDateIso),
                ),
                // _DetailRow(
                //   icon: Icons.access_time,
                //   label: 'Giờ khám',
                //   value: _formatIsoTime(entry.visitTimeIso),
                // ),
                _DetailRow(
                  icon: Icons.location_on,
                  label: 'Cơ sở',
                  value: entry.branch,
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Booking Metadata Card
            _DetailCard(
              title: 'Thông tin đặt lịch',
              icon: Icons.info_outline,
              children: [
                _DetailRow(
                  icon: Icons.schedule,
                  label: 'Thời gian đặt',
                  value: _formatIsoDateTime(entry.createdAtIso),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Action Buttons (if needed)
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    BookingColors.primaryBlue,
                    BookingColors.lightBlue,
                  ],
                ),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: BookingColors.primaryBlue.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back, color: BookingColors.white),
                label: const Text(
                  'Quay lại',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: BookingColors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailCard extends StatelessWidget {
  const _DetailCard({
    required this.title,
    required this.icon,
    required this.children,
  });

  final String title;
  final IconData icon;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: BookingColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        BookingColors.primaryBlue,
                        BookingColors.lightBlue,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: BookingColors.white, size: 22),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: BookingColors.textDark,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: BookingColors.lightGray,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: BookingColors.borderGray.withOpacity(0.5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: BookingColors.primaryBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 18,
              color: BookingColors.primaryBlue,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: BookingColors.textGray,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: BookingColors.textDark,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
