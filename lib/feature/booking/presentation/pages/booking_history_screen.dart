// // feature/booking/presentation/screens/booking_history_screen.dart
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../data/models/crm_booking_item.dart';
// import '../cubits/booking_history_remote_cubit.dart';
// import '../cubits/booking_history_remote_state.dart';
//
// // Color scheme giữ như cũ
// class BookingColors {
//   static const primaryBlue = Color(0xFF1976D2);
//   static const lightBlue = Color(0xFF42A5F5);
//   static const darkBlue = Color(0xFF0D47A1);
//   static const accentBlue = Color(0xFF2196F3);
//   static const white = Color(0xFFFFFFFF);
//   static const lightGray = Color(0xFFF5F7FA);
//   static const borderGray = Color(0xFFE0E0E0);
//   static const textDark = Color(0xFF212121);
//   static const textGray = Color(0xFF757575);
// }
//
// class BookingHistoryScreen extends StatefulWidget {
//   const BookingHistoryScreen({Key? key}) : super(key: key);
//
//   @override
//   State<BookingHistoryScreen> createState() => _BookingHistoryScreenState();
// }
//
// class _BookingHistoryScreenState extends State<BookingHistoryScreen> {
//   late final BookingHistoryRemoteCubit _cubit;
//
//   @override
//   void initState() {
//     super.initState();
//     _cubit = BookingHistoryRemoteCubit();
//     _cubit.load(); // default range
//   }
//
//   @override
//   void dispose() {
//     _cubit.close();
//     super.dispose();
//   }
//
//   String _fmtDdMm(String yyyyMmDd) {
//     // "2025-12-26" -> "26/12/2025"
//     try {
//       final dt = DateTime.parse(yyyyMmDd);
//       final d = dt.day.toString().padLeft(2, '0');
//       final m = dt.month.toString().padLeft(2, '0');
//       final y = dt.year.toString();
//       return '$d/$m/$y';
//     } catch (_) {
//       return yyyyMmDd;
//     }
//   }
//
//   String _fmtTime(String? hhmmss) {
//     if (hhmmss == null || hhmmss.trim().isEmpty) return '—';
//     final s = hhmmss.trim();
//     // "09:00:00" -> "09:00"
//     if (s.length >= 5) return s.substring(0, 5);
//     return s;
//   }
//
//   String _fmtCreated(String? createdtime) {
//     // "2025-12-25 16:14:51" -> "25/12 • 16:14"
//     if (createdtime == null || createdtime.trim().isEmpty) return '—';
//     final s = createdtime.trim();
//     try {
//       // parse dạng "yyyy-MM-dd HH:mm:ss"
//       final parts = s.split(' ');
//       final d = parts[0];
//       final t = parts.length > 1 ? parts[1] : '';
//       final dt = DateTime.parse('${d}T$t');
//       final dd = dt.day.toString().padLeft(2, '0');
//       final mm = dt.month.toString().padLeft(2, '0');
//       final hh = dt.hour.toString().padLeft(2, '0');
//       final mi = dt.minute.toString().padLeft(2, '0');
//       return '$dd/$mm • $hh:$mi';
//     } catch (_) {
//       return s;
//     }
//   }
//
//   Color _statusColor(String? status) {
//     final s = (status ?? '').trim().toLowerCase();
//     if (s == 'confirmed') return BookingColors.primaryBlue;
//     if (s == 'unconfirmed') return Colors.orange.shade700;
//     if (s == 'checked_in') return Colors.green.shade700;
//     if (s.contains('cancel')) return Colors.red.shade600;
//     return BookingColors.textGray;
//   }
//
//   IconData _statusIcon(String? status) {
//     final s = (status ?? '').trim().toLowerCase();
//     if (s == 'confirmed') return Icons.check_circle;
//     if (s == 'unconfirmed') return Icons.schedule;
//     if (s == 'checked_in') return Icons.how_to_reg;
//     if (s.contains('cancel')) return Icons.cancel;
//     return Icons.info;
//   }
//
//   String _statusLabel(String? status) {
//     final s = (status ?? '').trim().toLowerCase();
//     if (s == 'confirmed') return 'Đã xác nhận';
//     if (s == 'unconfirmed') return 'Chờ xác nhận';
//     if (s == 'checked_in') return 'Đã đến';
//     if (s.contains('cancel')) return 'Đã hủy';
//     return (status == null || status.trim().isEmpty) ? '—' : status!;
//   }
//
//   Color _syncTint(String? v) {
//     final s = (v ?? '').trim().toLowerCase();
//     if (s.contains('success')) return Colors.green.shade700;
//     if (s.contains('fail')) return Colors.red.shade600;
//     return BookingColors.textGray;
//   }
//
//   IconData _syncIcon(String? v) {
//     final s = (v ?? '').trim().toLowerCase();
//     if (s.contains('success')) return Icons.cloud_done;
//     if (s.contains('fail')) return Icons.cloud_off;
//     return Icons.cloud_queue;
//   }
//
//   String _syncLabel(String? v) {
//     final s = (v ?? '').trim().toLowerCase();
//     if (s.contains('success')) return 'HIS: Thành công';
//     if (s.contains('fail')) return 'HIS: Thất bại';
//     if (s.isEmpty) return '';
//     return 'HIS: $v';
//   }
//
//   String _maskCccd(String raw) {
//     final s = raw.trim();
//     if (s.length <= 6) return s;
//     return '${s.substring(0, 3)}******${s.substring(s.length - 3)}';
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<BookingHistoryRemoteCubit>.value(
//       value: _cubit,
//       child: Scaffold(
//         backgroundColor: BookingColors.lightGray,
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           title: const Text(
//             'Lịch sử hẹn khám',
//             style: TextStyle(
//               fontWeight: FontWeight.w700,
//               color: BookingColors.white,
//               fontSize: 20,
//             ),
//           ),
//           centerTitle: true,
//           elevation: 0,
//           backgroundColor: Colors.transparent,
//           iconTheme: const IconThemeData(color: BookingColors.white),
//           flexibleSpace: Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: [BookingColors.primaryBlue, BookingColors.lightBlue],
//               ),
//             ),
//           ),
//           actions: [
//             Container(
//               margin: const EdgeInsets.only(right: 12),
//               decoration: BoxDecoration(
//                 color: BookingColors.white.withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: IconButton(
//                 icon: const Icon(Icons.refresh, color: BookingColors.white),
//                 onPressed: () => _cubit.load(),
//                 tooltip: 'Làm mới',
//               ),
//             ),
//           ],
//         ),
//         body: BlocBuilder<BookingHistoryRemoteCubit, BookingHistoryRemoteState>(
//           builder: (context, state) {
//             if (state is BookingHistoryRemoteLoading) {
//               return Center(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const CircularProgressIndicator(
//                       color: BookingColors.primaryBlue,
//                       strokeWidth: 3,
//                     ),
//                     const SizedBox(height: 16),
//                     Text(
//                       'Đang tải lịch sử...',
//                       style: TextStyle(
//                         color: BookingColors.textGray,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             }
//
//             if (state is BookingHistoryRemoteError) {
//               return _buildError(state.message);
//             }
//
//             if (state is BookingHistoryRemoteLoaded) {
//               final items = state.list;
//               if (items.isEmpty) return _buildEmpty();
//
//               // sort theo createdtime desc nếu có
//               final sorted = [...items];
//               sorted.sort((a, b) {
//                 final ca = (a.createdtime ?? '').toString();
//                 final cb = (b.createdtime ?? '').toString();
//                 return cb.compareTo(ca);
//               });
//
//               return RefreshIndicator(
//                 onRefresh: () async => _cubit.load(),
//                 color: BookingColors.primaryBlue,
//                 child: ListView.builder(
//                   padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
//                   itemCount: sorted.length,
//                   itemBuilder: (ctx, idx) => _buildCard(sorted[idx]),
//                 ),
//               );
//             }
//
//             return const SizedBox.shrink();
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _buildError(String message) {
//     return Center(
//       child: Container(
//         margin: const EdgeInsets.all(24),
//         padding: const EdgeInsets.all(24),
//         decoration: BoxDecoration(
//           color: BookingColors.white,
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.06),
//               blurRadius: 12,
//               offset: const Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.red.shade50,
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(
//                 Icons.error_outline,
//                 size: 48,
//                 color: Colors.red.shade600,
//               ),
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               'Không thể tải dữ liệu',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w700,
//                 color: BookingColors.textDark,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               message,
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                 color: BookingColors.textGray,
//                 fontSize: 14,
//               ),
//             ),
//             const SizedBox(height: 20),
//             _PrimaryButton(
//               label: 'Thử lại',
//               icon: Icons.refresh,
//               onPressed: () => _cubit.load(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildEmpty() {
//     return Center(
//       child: Container(
//         margin: const EdgeInsets.all(24),
//         padding: const EdgeInsets.all(32),
//         decoration: BoxDecoration(
//           color: BookingColors.white,
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.06),
//               blurRadius: 12,
//               offset: const Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     BookingColors.primaryBlue.withOpacity(0.1),
//                     BookingColors.lightBlue.withOpacity(0.1),
//                   ],
//                 ),
//                 shape: BoxShape.circle,
//               ),
//               child: const Icon(
//                 Icons.calendar_today_outlined,
//                 size: 64,
//                 color: BookingColors.primaryBlue,
//               ),
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               'Chưa có lịch hẹn',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.w700,
//                 color: BookingColors.textDark,
//               ),
//             ),
//             const SizedBox(height: 8),
//             const Text(
//               'Các lịch hẹn của bạn sẽ hiển thị tại đây',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: BookingColors.textGray,
//                 fontSize: 14,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCard(CrmBookingItem b) {
//     final statusColor = _statusColor(b.cpbooking_status);
//     final statusIcon = _statusIcon(b.cpbooking_status);
//
//     final bookingNo = (b.cpbooking_no ?? '').toString().trim();
//     final name = (b.related_contact_label ?? '').toString().trim();
//     final phone = (b.related_contactmobile ?? '').toString().trim();
//     final cccd =
//         (b.related_contactidentification_number ?? '').toString().trim();
//
//     final day = (b.start_day ?? '').toString().trim();
//     final time = _fmtTime(b.start_time?.toString());
//     final shift = (b.cpbooking_shift ?? '').toString().trim();
//
//     final specialty =
//         (b.related_cpspecialtycategory_label ?? '').toString().trim();
//     final note = (b.note ?? '').toString().trim();
//     final source = (b.cpbooking_source ?? '').toString().trim();
//     final sync = (b.sync_his_status ?? '').toString().trim();
//     final created = _fmtCreated(b.createdtime?.toString());
//
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       decoration: BoxDecoration(
//         color: BookingColors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.06),
//             blurRadius: 12,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Header: mã hẹn + trạng thái
//             Row(
//               children: [
//                 _Tag(
//                   text: bookingNo.isNotEmpty ? bookingNo : 'Lịch hẹn',
//                 ),
//                 const Spacer(),
//                 _Badge(
//                   icon: statusIcon,
//                   label: _statusLabel(b.cpbooking_status),
//                   color: statusColor,
//                 ),
//               ],
//             ),
//
//             const SizedBox(height: 12),
//
//             // Name + phone + cccd masked
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   width: 44,
//                   height: 44,
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [
//                         BookingColors.primaryBlue.withOpacity(0.12),
//                         BookingColors.lightBlue.withOpacity(0.10),
//                       ],
//                     ),
//                     borderRadius: BorderRadius.circular(14),
//                   ),
//                   child: const Icon(
//                     Icons.person,
//                     color: BookingColors.primaryBlue,
//                     size: 26,
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         name.isNotEmpty ? name : 'Không rõ',
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                         style: const TextStyle(
//                           fontWeight: FontWeight.w800,
//                           fontSize: 16,
//                           color: BookingColors.textDark,
//                         ),
//                       ),
//                       const SizedBox(height: 6),
//                       Wrap(
//                         spacing: 8,
//                         runSpacing: 8,
//                         children: [
//                           _MiniChip(
//                             icon: Icons.phone,
//                             label: phone.isNotEmpty ? phone : '—',
//                           ),
//                           if (cccd.isNotEmpty)
//                             _MiniChip(
//                               icon: Icons.badge,
//                               label: _maskCccd(cccd),
//                             ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//
//             const SizedBox(height: 14),
//             _divider(),
//             const SizedBox(height: 14),
//
//             // Time + Specialty + shift
//             Wrap(
//               spacing: 10,
//               runSpacing: 10,
//               children: [
//                 _InfoPill(
//                   icon: Icons.calendar_today,
//                   title: 'Ngày khám',
//                   value: day.isNotEmpty ? _fmtDdMm(day) : '—',
//                 ),
//                 // _InfoPill(
//                 //   icon: Icons.access_time,
//                 //   title: 'Giờ',
//                 //   value: time,
//                 // ),
//                 if (shift.isNotEmpty)
//                   _InfoPill(
//                     icon: Icons.wb_sunny_outlined,
//                     title: 'Ca',
//                     value: shift,
//                   ),
//                 if (specialty.isNotEmpty)
//                   _InfoPill(
//                     icon: Icons.local_hospital,
//                     title: 'Khoa',
//                     value: specialty,
//                   ),
//               ],
//             ),
//
//             if (note.isNotEmpty) ...[
//               const SizedBox(height: 14),
//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: BookingColors.lightGray,
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(
//                       color: BookingColors.borderGray.withOpacity(0.55)),
//                 ),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Icon(Icons.note_alt,
//                         size: 18, color: BookingColors.primaryBlue),
//                     const SizedBox(width: 10),
//                     Expanded(
//                       child: Text(
//                         note,
//                         style: const TextStyle(
//                           fontSize: 13,
//                           color: BookingColors.textDark,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//
//             const SizedBox(height: 14),
//             // _divider(),
//             // const SizedBox(height: 12),
//             //
//             // // Footer meta
//             // Row(
//             //   children: [
//             //     Expanded(
//             //       child: Wrap(
//             //         spacing: 8,
//             //         runSpacing: 8,
//             //         children: [
//             //           if (source.isNotEmpty)
//             //             _MetaChip(
//             //               icon: Icons.public,
//             //               label: source,
//             //             ),
//             //           if (sync.isNotEmpty)
//             //             _MetaChip(
//             //               icon: _syncIcon(sync),
//             //               label: _syncLabel(sync),
//             //               tint: _syncTint(sync),
//             //             ),
//             //         ],
//             //       ),
//             //     ),
//             //     const SizedBox(width: 8),
//             //     Row(
//             //       mainAxisSize: MainAxisSize.min,
//             //       children: [
//             //         const Icon(Icons.schedule,
//             //             size: 14, color: BookingColors.textGray),
//             //         const SizedBox(width: 6),
//             //         Text(
//             //           created,
//             //           style: const TextStyle(
//             //             fontSize: 12,
//             //             color: BookingColors.textGray,
//             //             fontWeight: FontWeight.w600,
//             //           ),
//             //         ),
//             //       ],
//             //     ),
//             //   ],
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _divider() => Container(
//         height: 1,
//         color: BookingColors.borderGray.withOpacity(0.55),
//       );
// }
//
// // ======= small widgets =======
//
// class _PrimaryButton extends StatelessWidget {
//   const _PrimaryButton({
//     required this.label,
//     required this.icon,
//     required this.onPressed,
//   });
//
//   final String label;
//   final IconData icon;
//   final VoidCallback onPressed;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [BookingColors.primaryBlue, BookingColors.lightBlue],
//         ),
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: BookingColors.primaryBlue.withOpacity(0.3),
//             blurRadius: 8,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: ElevatedButton.icon(
//         onPressed: onPressed,
//         icon: Icon(icon, color: BookingColors.white),
//         label: Text(
//           label,
//           style: const TextStyle(
//             color: BookingColors.white,
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.transparent,
//           shadowColor: Colors.transparent,
//           padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         ),
//       ),
//     );
//   }
// }
//
// class _Tag extends StatelessWidget {
//   const _Tag({required this.text});
//   final String text;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//       decoration: BoxDecoration(
//         color: BookingColors.lightGray,
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: BookingColors.borderGray.withOpacity(0.6)),
//       ),
//       child: Text(
//         text,
//         style: const TextStyle(
//           fontWeight: FontWeight.w800,
//           fontSize: 12,
//           color: BookingColors.textDark,
//         ),
//       ),
//     );
//   }
// }
//
// class _Badge extends StatelessWidget {
//   const _Badge({
//     required this.icon,
//     required this.label,
//     required this.color,
//   });
//
//   final IconData icon;
//   final String label;
//   final Color color;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.12),
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: color.withOpacity(0.25)),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, size: 14, color: color),
//           const SizedBox(width: 6),
//           Text(
//             label,
//             style: TextStyle(
//               fontWeight: FontWeight.w800,
//               fontSize: 12,
//               color: color,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _MiniChip extends StatelessWidget {
//   const _MiniChip({required this.icon, required this.label});
//
//   final IconData icon;
//   final String label;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
//       decoration: BoxDecoration(
//         color: BookingColors.lightGray,
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: BookingColors.borderGray.withOpacity(0.5)),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, size: 14, color: BookingColors.primaryBlue),
//           const SizedBox(width: 6),
//           Text(
//             label,
//             style: const TextStyle(
//               fontSize: 12,
//               color: BookingColors.textDark,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _InfoPill extends StatelessWidget {
//   const _InfoPill({
//     required this.icon,
//     required this.title,
//     required this.value,
//   });
//
//   final IconData icon;
//   final String title;
//   final String value;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       constraints: const BoxConstraints(minWidth: 150),
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//       decoration: BoxDecoration(
//         color: BookingColors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: BookingColors.borderGray.withOpacity(0.65)),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, size: 18, color: BookingColors.primaryBlue),
//           const SizedBox(width: 10),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     fontSize: 11,
//                     color: BookingColors.textGray,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 const SizedBox(height: 2),
//                 Text(
//                   value,
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(
//                     fontSize: 13,
//                     color: BookingColors.textDark,
//                     fontWeight: FontWeight.w800,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _MetaChip extends StatelessWidget {
//   const _MetaChip({
//     required this.icon,
//     required this.label,
//     this.tint,
//   });
//
//   final IconData icon;
//   final String label;
//   final Color? tint;
//
//   @override
//   Widget build(BuildContext context) {
//     final c = tint ?? BookingColors.textGray;
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//       decoration: BoxDecoration(
//         color: c.withOpacity(0.10),
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: c.withOpacity(0.20)),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, size: 14, color: c),
//           const SizedBox(width: 6),
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 12,
//               color: c,
//               fontWeight: FontWeight.w800,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/crm_booking_item.dart';
import '../cubits/booking_history_remote_cubit.dart';
import '../cubits/booking_history_remote_state.dart';

// Color scheme giữ như cũ
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
  late final BookingHistoryRemoteCubit _cubit;

  DateTime? _from;
  DateTime? _to;

  @override
  void initState() {
    super.initState();
    _cubit = BookingHistoryRemoteCubit();

    final now = DateTime.now();
    _from = now.subtract(const Duration(days: 30));
    _to = now.add(const Duration(days: 30));

    _cubit.load(from: _from, to: _to);
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  // ===== Date helpers =====

  String _fmtYMD(DateTime d) {
    final y = d.year.toString().padLeft(4, '0');
    final m = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    return '$y-$m-$day';
  }

  String _fmtDdMmYyyy(String yyyyMmDd) {
    // "2025-12-26" -> "26/12/2025"
    try {
      final dt = DateTime.parse(yyyyMmDd);
      final d = dt.day.toString().padLeft(2, '0');
      final m = dt.month.toString().padLeft(2, '0');
      final y = dt.year.toString();
      return '$d/$m/$y';
    } catch (_) {
      return yyyyMmDd;
    }
  }

  String _fmtTime(String? hhmmss) {
    if (hhmmss == null || hhmmss.trim().isEmpty) return '—';
    final s = hhmmss.trim();
    if (s.length >= 5) return s.substring(0, 5); // "09:00:00" -> "09:00"
    return s;
  }

  String _fmtCreatedTop(String? createdtime) {
    // "2025-12-25 16:14:51" -> "Tạo: 25/12/2025 • 16:14"
    if (createdtime == null || createdtime.trim().isEmpty) return '';
    final s = createdtime.trim();
    try {
      final parts = s.split(' ');
      final d = parts[0];
      final t = parts.length > 1 ? parts[1] : '00:00:00';
      final dt = DateTime.parse('${d}T$t');
      final dd = dt.day.toString().padLeft(2, '0');
      final mm = dt.month.toString().padLeft(2, '0');
      final yy = dt.year.toString();
      final hh = dt.hour.toString().padLeft(2, '0');
      final mi = dt.minute.toString().padLeft(2, '0');
      return 'Tạo: $dd/$mm/$yy • $hh:$mi';
    } catch (_) {
      return 'Tạo: $s';
    }
  }

  Future<void> _pickRangeOneButton() async {
    final now = DateTime.now();
    final initialStart = _from ?? now.subtract(const Duration(days: 30));
    final initialEnd = _to ?? now.add(const Duration(days: 30));

    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
      initialDateRange: DateTimeRange(start: initialStart, end: initialEnd),
      helpText: 'Chọn khoảng ngày',
      cancelText: 'Hủy',
      confirmText: 'Áp dụng',
    );

    if (picked == null) return;

    setState(() {
      _from = picked.start;
      _to = picked.end;
    });

    _cubit.load(from: _from, to: _to);
  }

  // ===== Status helpers =====

  Color _statusColor(String? status) {
    final s = (status ?? '').trim().toLowerCase();

    switch (s) {
      case 'unconfirmed':
        return Colors.orange.shade700; // Chưa xác nhận
      case 'confirmed':
        return BookingColors.primaryBlue; // Đã xác nhận
      case 'checked_in':
        return Colors.green.shade700; // Checkin
      case 'completed':
        return Colors.teal.shade700; // Đã hoàn thành
      case 'cancelled':
      case 'canceled':
      case 'cancel':
        return Colors.red.shade600; // Hủy
      case 'not_come':
        return Colors.purple.shade700; // Không đến
      default:
        // fallback cũ: nếu API trả "cancel_*" thì vẫn đỏ
        if (s.contains('cancel')) return Colors.red.shade600;
        return BookingColors.textGray;
    }
  }

  IconData _statusIcon(String? status) {
    final s = (status ?? '').trim().toLowerCase();

    switch (s) {
      case 'unconfirmed':
        return Icons.hourglass_top; // Chưa xác nhận
      case 'confirmed':
        return Icons.check_circle; // Đã xác nhận
      case 'checked_in':
        return Icons.how_to_reg; // Checkin
      case 'completed':
        return Icons.verified; // Đã hoàn thành
      case 'cancelled':
      case 'canceled':
      case 'cancel':
        return Icons.cancel; // Hủy
      case 'not_come':
        return Icons.person_off; // Không đến
      default:
        if (s.contains('cancel')) return Icons.cancel;
        return Icons.info;
    }
  }

  String _statusLabel(String? status) {
    final s = (status ?? '').trim().toLowerCase();

    switch (s) {
      case 'unconfirmed':
        return 'Chưa xác nhận';
      case 'confirmed':
        return 'Đã xác nhận';
      case 'checked_in':
        return 'Checkin';
      case 'completed':
        return 'Đã hoàn thành';
      case 'cancelled':
      case 'canceled':
      case 'cancel':
        return 'Hủy';
      case 'not_come':
        return 'Không đến';
      default:
        if (s.contains('cancel')) return 'Hủy';
        return (status == null || status.trim().isEmpty) ? '—' : status!;
    }
  }

  String _maskCccd(String raw) {
    final s = raw.trim();
    if (s.length <= 6) return s;
    return '${s.substring(0, 3)}******${s.substring(s.length - 3)}';
  }

  // ===== UI =====

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BookingHistoryRemoteCubit>.value(
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
                colors: [BookingColors.primaryBlue, BookingColors.lightBlue],
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
                onPressed: () => _cubit.load(from: _from, to: _to),
                tooltip: 'Làm mới',
              ),
            ),
          ],
        ),
        body: BlocBuilder<BookingHistoryRemoteCubit, BookingHistoryRemoteState>(
          builder: (context, state) {
            if (state is BookingHistoryRemoteLoading) return _buildLoading();

            if (state is BookingHistoryRemoteError) {
              return _buildError(state.message);
            }

            if (state is BookingHistoryRemoteLoaded) {
              final sorted = [...state.list];

              sorted.sort((a, b) {
                final ca = (a.createdtime ?? '').toString();
                final cb = (b.createdtime ?? '').toString();
                return cb.compareTo(ca);
              });

              return RefreshIndicator(
                onRefresh: () async => _cubit.load(from: _from, to: _to),
                color: BookingColors.primaryBlue,
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                  children: [
                    _buildCompactFilter(),
                    const SizedBox(height: 10),
                    if (sorted.isEmpty)
                      _buildEmptyInline()
                    else ...[
                      ...sorted.map(_buildCard),
                    ],
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildCompactFilter() {
    final fromText = _from == null ? '—' : _fmtYMD(_from!);
    final toText = _to == null ? '—' : _fmtYMD(_to!);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: BookingColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: BookingColors.borderGray.withOpacity(0.55)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.035),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: BookingColors.primaryBlue.withOpacity(0.10),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.date_range,
              size: 18,
              color: BookingColors.primaryBlue,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              '$fromText  →  $toText',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: BookingColors.textDark,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          TextButton(
            onPressed: _pickRangeOneButton,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              minimumSize: const Size(0, 0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              foregroundColor: BookingColors.primaryBlue,
            ),
            child: const Text(
              'Chọn',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoading() {
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
            style: TextStyle(color: BookingColors.textGray, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildError(String message) {
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
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: BookingColors.textGray,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
            _PrimaryButton(
              label: 'Thử lại',
              icon: Icons.refresh,
              onPressed: () => _cubit.load(from: _from, to: _to),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyInline() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: BookingColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: BookingColors.borderGray.withOpacity(0.5)),
      ),
      child: Column(
        children: const [
          Icon(Icons.event_busy, size: 44, color: BookingColors.primaryBlue),
          SizedBox(height: 10),
          Text(
            'Chưa có lịch hẹn trong khoảng thời gian đã chọn',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: BookingColors.textDark,
            ),
          ),
        ],
      ),
    );
  }

  // ===== Card =====

  Widget _buildCard(CrmBookingItem b) {
    final statusColor = _statusColor(b.cpbooking_status);
    final statusIcon = _statusIcon(b.cpbooking_status);

    final createdTop = _fmtCreatedTop(b.createdtime?.toString());

    final bookingNo = (b.cpbooking_no ?? '').toString().trim();
    final name = (b.related_contact_label ?? '').toString().trim();
    final phone = (b.related_contactmobile ?? '').toString().trim();
    final cccd =
        (b.related_contactidentification_number ?? '').toString().trim();

    final day = (b.start_day ?? '').toString().trim();
    final time = _fmtTime(b.start_time?.toString());

    final specialty =
        (b.related_cpspecialtycategory_label ?? '').toString().trim();
    final note = (b.note ?? '').toString().trim();

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
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TOP LINE: created time (đưa lên trên)
            if (createdTop.isNotEmpty)
              Row(
                children: [
                  const Icon(Icons.schedule,
                      size: 14, color: BookingColors.textGray),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      createdTop,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        color: BookingColors.textGray,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),

            if (createdTop.isNotEmpty) const SizedBox(height: 10),

            // Header: mã hẹn + trạng thái
            Row(
              children: [
                _Tag(text: bookingNo.isNotEmpty ? bookingNo : 'Lịch hẹn'),
                const Spacer(),
                _Badge(
                  icon: statusIcon,
                  label: _statusLabel(b.cpbooking_status),
                  color: statusColor,
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Name + phone + cccd
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        BookingColors.primaryBlue.withOpacity(0.12),
                        BookingColors.lightBlue.withOpacity(0.10),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.person,
                    color: BookingColors.primaryBlue,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name.isNotEmpty ? name : 'Không rõ',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                          color: BookingColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _MiniChip(
                            icon: Icons.phone,
                            label: phone.isNotEmpty ? phone : '—',
                          ),
                          if (cccd.isNotEmpty)
                            _MiniChip(
                              icon: Icons.badge,
                              label: _maskCccd(cccd),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),
            _divider(),
            const SizedBox(height: 12),

            // Ngày khám + giờ: 1 hàng
            Row(
              children: [
                Expanded(
                  child: _InfoPillCompact(
                    icon: Icons.calendar_today,
                    title: 'Ngày khám',
                    value: day.isNotEmpty ? _fmtDdMmYyyy(day) : '—',
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _InfoPillCompact(
                    icon: Icons.access_time,
                    title: 'Giờ',
                    value: time,
                  ),
                ),
              ],
            ),

            if (specialty.isNotEmpty) ...[
              const SizedBox(height: 10),
              _InfoRow(
                icon: Icons.local_hospital,
                label: 'Khoa',
                value: specialty,
              ),
            ],

            if (note.isNotEmpty) ...[
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: BookingColors.lightGray,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: BookingColors.borderGray.withOpacity(0.55),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.note_alt,
                      size: 18,
                      color: BookingColors.primaryBlue,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        note,
                        style: const TextStyle(
                          fontSize: 13,
                          color: BookingColors.textDark,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _divider() => Container(
        height: 1,
        color: BookingColors.borderGray.withOpacity(0.55),
      );
}

// ======= small widgets =======

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [BookingColors.primaryBlue, BookingColors.lightBlue],
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
        onPressed: onPressed,
        icon: Icon(icon, color: BookingColors.white),
        label: Text(
          label,
          style: const TextStyle(
            color: BookingColors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: BookingColors.lightGray,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: BookingColors.borderGray.withOpacity(0.6)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 12,
          color: BookingColors.textDark,
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 12,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniChip extends StatelessWidget {
  const _MiniChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: BookingColors.lightGray,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: BookingColors.borderGray.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: BookingColors.primaryBlue),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: BookingColors.textDark,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoPillCompact extends StatelessWidget {
  const _InfoPillCompact({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: BookingColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: BookingColors.borderGray.withOpacity(0.65)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: BookingColors.primaryBlue),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 11,
                    color: BookingColors.textGray,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    color: BookingColors.textDark,
                    fontWeight: FontWeight.w800,
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

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: BookingColors.primaryBlue),
        const SizedBox(width: 8),
        Text(
          '$label:',
          style: const TextStyle(
            fontSize: 12,
            color: BookingColors.textGray,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12.5,
              color: BookingColors.textDark,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}
