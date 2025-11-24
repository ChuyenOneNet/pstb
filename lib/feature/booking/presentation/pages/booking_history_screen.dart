// lib/app/modules/booking_history/booking_history_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/repositories/booking_repository.dart';
import '../../../../di/locator.dart';
import '../../domain/entities/history_entry.dart';
import '../cubits/booking_history_cubit.dart';
import '../cubits/booking_history_state.dart';
import 'history_detail_screen.dart';

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

class BookingHistoryScreen extends StatefulWidget {
  const BookingHistoryScreen({Key? key}) : super(key: key);

  @override
  State<BookingHistoryScreen> createState() => _BookingHistoryScreenState();
}

class _BookingHistoryScreenState extends State<BookingHistoryScreen> {
  late final BookingHistoryCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BookingHistoryCubit();
    _cubit.load();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  String _formatDate(String iso) {
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

  String _formatTime(String iso) {
    try {
      final dt = DateTime.parse(iso);
      final hh = dt.hour.toString().padLeft(2, '0');
      final mm = dt.minute.toString().padLeft(2, '0');
      return '$hh:$mm';
    } catch (_) {
      return iso;
    }
  }

  String _formatDateTimeShort(String iso) {
    try {
      final dt = DateTime.parse(iso);
      final d = dt.day.toString().padLeft(2, '0');
      final m = dt.month.toString().padLeft(2, '0');
      final hh = dt.hour.toString().padLeft(2, '0');
      final mm = dt.minute.toString().padLeft(2, '0');
      return '$d/$m • $hh:$mm';
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
    return BlocProvider<BookingHistoryCubit>.value(
      value: _cubit,
      child: Scaffold(
        backgroundColor: BookingColors.lightGray,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'Lịch sử hẹn khám',
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
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: BookingColors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                icon: const Icon(Icons.refresh, color: BookingColors.white),
                onPressed: () => _cubit.load(),
                tooltip: 'Làm mới',
              ),
            ),
          ],
        ),
        body: BlocBuilder<BookingHistoryCubit, BookingHistoryState>(
          builder: (context, state) {
            if (state is BookingHistoryLoading) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(
                      color: BookingColors.primaryBlue,
                      strokeWidth: 3,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Đang tải lịch sử...',
                      style: TextStyle(
                        color: BookingColors.textGray,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              );
            }

            if (state is BookingHistoryError) {
              return Center(
                child: Container(
                  margin: const EdgeInsets.all(24),
                  padding: const EdgeInsets.all(24),
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.error_outline,
                          size: 48,
                          color: Colors.red.shade600,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Không thể tải dữ liệu',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: BookingColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        state.message,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: BookingColors.textGray,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              BookingColors.primaryBlue,
                              BookingColors.lightBlue,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: BookingColors.primaryBlue.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ElevatedButton.icon(
                          onPressed: () => _cubit.load(),
                          icon: const Icon(Icons.refresh,
                              color: BookingColors.white),
                          label: const Text(
                            'Thử lại',
                            style: TextStyle(
                              color: BookingColors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (state is BookingHistoryLoaded) {
              final items = state.list;
              if (items.isEmpty) {
                return _buildEmpty();
              }

              final sorted = [...items];
              sorted.sort((a, b) => b.createdAtIso.compareTo(a.createdAtIso));

              return RefreshIndicator(
                onRefresh: () async => _cubit.load(),
                color: BookingColors.primaryBlue,
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                  itemCount: sorted.length,
                  itemBuilder: (ctx, idx) {
                    final e = sorted[idx];
                    return _buildCard(context, e);
                  },
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(24),
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: BookingColors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    BookingColors.primaryBlue.withOpacity(0.1),
                    BookingColors.lightBlue.withOpacity(0.1),
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.calendar_today_outlined,
                size: 64,
                color: BookingColors.primaryBlue,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Chưa có lịch hẹn',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: BookingColors.textDark,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Các lịch hẹn của bạn sẽ hiển thị tại đây',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: BookingColors.textGray,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, HistoryEntry e) {
    final statusColor = _statusColor(e.status);
    final statusIconData = _statusIcon(e.status);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => HistoryDetailScreen(entry: e),
              ),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    // Icon Container
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            BookingColors.primaryBlue.withOpacity(0.1),
                            BookingColors.lightBlue.withOpacity(0.1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Icon(
                        Icons.medical_services,
                        color: BookingColors.primaryBlue,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 14),

                    // Content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            e.patientName,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: BookingColors.textDark,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            e.serviceName,
                            style: const TextStyle(
                              fontSize: 14,
                              color: BookingColors.textGray,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Status Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: statusColor.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            statusIconData,
                            size: 14,
                            color: statusColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            e.status,
                            style: TextStyle(
                              color: statusColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Divider
                Container(
                  height: 1,
                  color: BookingColors.borderGray.withOpacity(0.5),
                ),
                const SizedBox(height: 14),

                // Details Row
                Row(
                  children: [
                    // Date & Time
                    Expanded(
                      child: _InfoChip(
                        icon: Icons.calendar_today,
                        label:
                            '${_formatDate(e.visitDateIso)} • ${_formatTime(e.visitTimeIso)}',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Branch
                _InfoChip(
                  icon: Icons.location_on,
                  label: e.branch,
                ),
                const SizedBox(height: 10),

                // Created At
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 14,
                          color: BookingColors.textGray,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Đặt lúc: ${_formatDateTimeShort(e.createdAtIso)}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: BookingColors.textGray,
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: BookingColors.primaryBlue,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: BookingColors.lightGray,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: BookingColors.borderGray.withOpacity(0.5),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: BookingColors.primaryBlue,
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                color: BookingColors.textDark,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
