// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pstb/di/locator.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:intl/intl.dart';
// import '../../../../constant/color.dart';
// import '../../data/models/relative_model.dart';
// import '../cubit/relative_form_cubit.dart';
// import '../cubit/relative_list_cubit.dart';
// import 'relative_form_page.dart';
//
// class RelativeListPage extends StatefulWidget {
//   final String mainCccd;
//   const RelativeListPage({super.key, required this.mainCccd});
//
//   @override
//   State<RelativeListPage> createState() => _RelativeListPageState();
// }
//
// class _RelativeListPageState extends State<RelativeListPage> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<RelativeListCubit>().load(widget.mainCccd);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF8FAFC),
//       appBar: AppBar(
//         title: const Text(
//           'Người thân',
//           style: TextStyle(fontWeight: FontWeight.w600, fontSize: 19),
//         ),
//         centerTitle: true,
//         backgroundColor: AppColors.primaryColor,
//         foregroundColor: Colors.white,
//         elevation: 0,
//       ),
//       body: BlocConsumer<RelativeListCubit, RelativeListState>(
//         listener: (context, state) {
//           if (state.error != null) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(state.error!),
//                 backgroundColor: Colors.red[700],
//                 behavior: SnackBarBehavior.floating,
//                 margin: const EdgeInsets.all(16),
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12)),
//               ),
//             );
//           }
//         },
//         builder: (context, state) {
//           if (state.loading && state.items.isEmpty) {
//             return _buildShimmer();
//           }
//
//           if (state.items.isEmpty) {
//             return _buildEmptyState();
//           }
//
//           return RefreshIndicator(
//             onRefresh: () =>
//                 context.read<RelativeListCubit>().load(widget.mainCccd),
//             color: AppColors.primaryColor,
//             child: ListView.builder(
//               padding: const EdgeInsets.all(16),
//               itemCount: state.items.length,
//               itemBuilder: (context, index) {
//                 final relative = state.items[index];
//                 return Padding(
//                   padding: const EdgeInsets.only(bottom: 12),
//                   child: _RelativeCard(
//                     relative: relative,
//                     onTap: () => _openForm(context, relative),
//                     onDelete: () => _showDeleteDialog(context, relative),
//                   ),
//                 );
//               },
//             ),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () => _openForm(context, null),
//         backgroundColor: AppColors.primaryColor,
//         elevation: 6,
//         icon: const Icon(Icons.person_add_alt_1,
//             size: 22, color: AppColors.whiteColor),
//         label: const Text(
//           'Thêm người thân',
//           style: TextStyle(
//               fontWeight: FontWeight.w600, color: AppColors.whiteColor),
//         ),
//       ),
//     );
//   }
//
//   Future<void> _openForm(BuildContext context, RelativeModel? relative) async {
//     final result = await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (_) => BlocProvider(
//           create: (_) => serviceLocator<RelativeFormCubit>(),
//           child: RelativeFormPage(
//             mainCccd: widget.mainCccd,
//             relativeId: relative?.id,
//           ),
//         ),
//       ),
//     );
//     if (result == true) {
//       context.read<RelativeListCubit>().load(widget.mainCccd);
//     }
//   }
//
//   Future<void> _showDeleteDialog(
//       BuildContext context, RelativeModel relative) async {
//     final confirm = await showDialog<bool>(
//       context: context,
//       builder: (_) => AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         icon: const Icon(Icons.help_outline, size: 32, color: Colors.orange),
//         title: const Text('Xóa người thân?',
//             style: TextStyle(fontWeight: FontWeight.w600)),
//         content: Text('Xóa "${relative.fullName}" khỏi danh sách?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context, false),
//             child: const Text('Hủy'),
//           ),
//           FilledButton(
//             style: FilledButton.styleFrom(backgroundColor: Colors.red[600]),
//             onPressed: () => Navigator.pop(context, true),
//             child: const Text('Xóa'),
//           ),
//         ],
//       ),
//     );
//
//     if (confirm == true) {
//       context.read<RelativeListCubit>().delete(widget.mainCccd, relative.id!);
//     }
//   }
//
//   Widget _buildEmptyState() {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 40),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.family_restroom, size: 84, color: Colors.grey[400]),
//             const SizedBox(height: 24),
//             const Text(
//               'Chưa có người thân',
//               style: TextStyle(
//                   fontSize: 19,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.black87),
//             ),
//             const SizedBox(height: 12),
//             Text(
//               'Thêm người thân để đặt khám nhanh hơn cho cả gia đình',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                   fontSize: 14.5, color: Colors.grey[600], height: 1.5),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildShimmer() {
//     return ListView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: 6,
//       itemBuilder: (_, __) => Padding(
//         padding: const EdgeInsets.only(bottom: 12),
//         child: Shimmer.fromColors(
//           baseColor: Colors.grey[200]!,
//           highlightColor: Colors.grey[100]!,
//           child: Container(
//             height: 100,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(16),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class _RelativeCard extends StatelessWidget {
//   final RelativeModel relative;
//   final VoidCallback onTap;
//   final VoidCallback onDelete;
//
//   const _RelativeCard({
//     required this.relative,
//     required this.onTap,
//     required this.onDelete,
//   });
//
//   // Sao chép + toast
//   void _copyToClipboard(BuildContext context, String text, String label) {
//     Clipboard.setData(ClipboardData(text: text.trim()));
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Row(
//           children: [
//             const Icon(Icons.check_circle, color: Colors.white, size: 14),
//             const SizedBox(width: 8),
//             Expanded(
//               child: Text(
//                 '$label đã được sao chép!',
//                 style: const TextStyle(fontWeight: FontWeight.w600),
//               ),
//             ),
//           ],
//         ),
//         backgroundColor: Colors.green[700],
//         behavior: SnackBarBehavior.floating,
//         margin: const EdgeInsets.all(16),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         duration: const Duration(milliseconds: 1800),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final rel = _getRelationshipInfo(relative.relationship);
//
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(18),
//         border: Border.all(
//           color: rel.color.withOpacity(0.3),
//           width: 1,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.04),
//             blurRadius: 12,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         borderRadius: BorderRadius.circular(18),
//         child: InkWell(
//           borderRadius: BorderRadius.circular(18),
//           onTap: onTap,
//           child: Padding(
//             padding: const EdgeInsets.fromLTRB(14, 12, 6, 12),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Avatar quan hệ
//                 Container(
//                   width: 44,
//                   height: 44,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     gradient: LinearGradient(
//                       colors: [
//                         rel.color.withOpacity(0.18),
//                         rel.color.withOpacity(0.05),
//                       ],
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                     ),
//                   ),
//                   child: Icon(rel.icon, color: rel.color, size: 24),
//                 ),
//                 const SizedBox(width: 14),
//
//                 // Nội dung chính
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Tên + chip quan hệ
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Expanded(
//                             child: Text(
//                               relative.fullName,
//                               style: const TextStyle(
//                                 fontWeight: FontWeight.w700,
//                                 fontSize: 16,
//                               ),
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                           const SizedBox(width: 6),
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 8, vertical: 3),
//                             decoration: BoxDecoration(
//                               color: rel.color.withOpacity(0.1),
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                             child: Text(
//                               rel.label,
//                               style: TextStyle(
//                                 color: rel.color,
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 11,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 8),
//
//                       // Dòng CCCD + copy
//                       _buildCopyRow(
//                         context,
//                         icon: Icons.badge_outlined,
//                         label: 'CCCD',
//                         value: relative.cccd,
//                         onCopy: () =>
//                             _copyToClipboard(context, relative.cccd, 'CCCD'),
//                       ),
//                       const SizedBox(height: 4),
//
//                       // SĐT + copy
//                       _buildCopyRow(
//                         context,
//                         icon: Icons.phone_outlined,
//                         label: 'SĐT',
//                         value: relative.phone,
//                         onCopy: () => _copyToClipboard(
//                             context, relative.phone, 'Số điện thoại'),
//                       ),
//                       const SizedBox(height: 4),
//
//                       // Mã BN + copy
//                       _buildCopyRow(
//                         context,
//                         icon: Icons.qr_code_2_outlined,
//                         label: 'Mã BN',
//                         value: relative.patientCode,
//                         onCopy: () => _copyToClipboard(
//                             context, relative.patientCode, 'Mã bệnh nhân'),
//                       ),
//                       const SizedBox(height: 4),
//
//                       // Ngày sinh
//                       Row(
//                         children: [
//                           Icon(
//                             Icons.cake_outlined,
//                             size: 16,
//                             color: Colors.purple[700],
//                           ),
//                           const SizedBox(width: 6),
//                           Text(
//                             'Ngày sinh:',
//                             style: TextStyle(
//                               fontSize: 12.5,
//                               color: Colors.grey[600],
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           const SizedBox(width: 4),
//                           Text(
//                             _formatDob(relative.dob),
//                             style: const TextStyle(
//                               fontSize: 13,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.black87,
//                             ),
//                           ),
//                         ],
//                       ),
//
//                       // Địa chỉ (nếu có)
//                       if ((relative.addressDetail ?? '').isNotEmpty ||
//                           (relative.ward ?? '').isNotEmpty ||
//                           (relative.city ?? '').isNotEmpty) ...[
//                         const SizedBox(height: 4),
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Icon(
//                               Icons.location_on_outlined,
//                               size: 16,
//                               color: Colors.teal[700],
//                             ),
//                             const SizedBox(width: 6),
//                             Expanded(
//                               child: Text(
//                                 _buildAddressLine(relative),
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: const TextStyle(
//                                   fontSize: 12.5,
//                                   color: Colors.black87,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ],
//                   ),
//                 ),
//
//                 // Menu 3 chấm
//                 PopupMenuButton<String>(
//                   color: AppColors.whiteColor,
//                   icon: Icon(Icons.more_vert, color: Colors.grey[600]),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(14),
//                   ),
//                   onSelected: (value) {
//                     if (value == 'edit') onTap();
//                     if (value == 'delete') onDelete();
//                   },
//                   itemBuilder: (_) => [
//                     const PopupMenuItem(
//                       value: 'edit',
//                       child: Row(
//                         children: [
//                           Icon(Icons.edit_outlined, size: 20),
//                           SizedBox(width: 12),
//                           Text('Chỉnh sửa'),
//                         ],
//                       ),
//                     ),
//                     PopupMenuItem(
//                       value: 'delete',
//                       child: Row(
//                         children: [
//                           Icon(Icons.delete_outline,
//                               size: 20, color: Colors.red),
//                           SizedBox(width: 12),
//                           Text(
//                             'Xóa',
//                             style: TextStyle(color: Colors.red),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   // Dòng thông tin có nút copy
//   Widget _buildCopyRow(
//     BuildContext context, {
//     required IconData icon,
//     required String label,
//     required String value,
//     required VoidCallback onCopy,
//   }) {
//     return Row(
//       children: [
//         Icon(icon, size: 16, color: Colors.grey[700]),
//         const SizedBox(width: 6),
//         Text(
//           '$label:',
//           style: TextStyle(
//             fontSize: 12.5,
//             color: Colors.grey[600],
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         const SizedBox(width: 4),
//         Expanded(
//           child: Text(
//             value,
//             style: const TextStyle(
//               fontSize: 13,
//               fontWeight: FontWeight.w600,
//               color: Colors.black87,
//             ),
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//           ),
//         ),
//         const SizedBox(width: 6),
//         InkWell(
//           borderRadius: BorderRadius.circular(999),
//           onTap: onCopy,
//           child: Container(
//             padding: const EdgeInsets.all(4),
//             decoration: BoxDecoration(
//               color: AppColors.primaryColor.withOpacity(0.08),
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               Icons.copy,
//               size: 14,
//               color: AppColors.primaryColor,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   // Format ngày sinh
//   String _formatDob(String dob) {
//     try {
//       final date = DateTime.parse(dob);
//       return DateFormat('dd/MM/yyyy').format(date);
//     } catch (_) {
//       return dob;
//     }
//   }
//
//   String _buildAddressLine(RelativeModel r) {
//     final parts = [
//       r.addressDetail,
//       r.ward,
//       r.city,
//     ].where((e) => e != null && e!.trim().isNotEmpty).toList();
//     if (parts.isEmpty) return '';
//     return parts.join(', ');
//   }
//
//   // Thông tin quan hệ (icon + màu + nhãn)
//   ({IconData icon, String label, Color color}) _getRelationshipInfo(
//       String? code) {
//     return switch (code) {
//       'CHA' => (
//           icon: Icons.man,
//           label: 'Cha',
//           color: const Color(0xFF2E86DE),
//         ),
//       'MẸ' || 'ME' => (
//           icon: Icons.woman,
//           label: 'Mẹ',
//           color: const Color(0xFFE91E63),
//         ),
//       'CON' => (
//           icon: Icons.child_friendly,
//           label: 'Con',
//           color: const Color(0xFF4CAF50),
//         ),
//       'VO_CHONG' => (
//           icon: Icons.favorite,
//           label: 'Vợ/Chồng',
//           color: const Color(0xFF9C27B0),
//         ),
//       'ANH_CHI_EM' => (
//           icon: Icons.people_alt,
//           label: 'Anh chị em',
//           color: const Color(0xFFFF9800),
//         ),
//       'ONG_BA' => (
//           icon: Icons.elderly,
//           label: 'Ông bà',
//           color: const Color(0xFF795548),
//         ),
//       _ => (
//           icon: Icons.person_outline,
//           label: 'Người thân',
//           color: AppColors.primaryColor,
//         ),
//     };
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
// import 'package:pstb/di/locator.dart';
// import 'package:shimmer/shimmer.dart';
//
// import '../../../../constant/color.dart';
// import '../../data/models/relative_model.dart';
// import '../cubit/relative_form_cubit.dart';
// import '../cubit/relative_list_cubit.dart';
// import 'relative_form_page.dart';
//
// class RelativeListPage extends StatefulWidget {
//   final String mainCccd;
//   const RelativeListPage({super.key, required this.mainCccd});
//
//   @override
//   State<RelativeListPage> createState() => _RelativeListPageState();
// }
//
// class _RelativeListPageState extends State<RelativeListPage> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<RelativeListCubit>().load(widget.mainCccd);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFE5EDF5),
//       appBar: AppBar(
//         title: const Text(
//           'Người thân',
//           style: TextStyle(fontWeight: FontWeight.w600, fontSize: 19),
//         ),
//         centerTitle: true,
//         backgroundColor: AppColors.primaryColor,
//         foregroundColor: Colors.white,
//         elevation: 0,
//       ),
//       body: BlocConsumer<RelativeListCubit, RelativeListState>(
//         listener: (context, state) {
//           if (state.error != null) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(state.error!),
//                 backgroundColor: Colors.red[700],
//                 behavior: SnackBarBehavior.floating,
//                 margin: const EdgeInsets.all(16),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//             );
//           }
//         },
//         builder: (context, state) {
//           if (state.loading && state.items.isEmpty) {
//             return _buildShimmer();
//           }
//
//           if (state.items.isEmpty) {
//             return _buildEmptyState();
//           }
//
//           return RefreshIndicator(
//             onRefresh: () async {
//               context.read<RelativeListCubit>().load(widget.mainCccd);
//             },
//             color: AppColors.primaryColor,
//             child: ListView.builder(
//               padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
//               itemCount: state.items.length,
//               itemBuilder: (context, index) {
//                 final relative = state.items[index];
//                 return _RelativeCard(
//                   relative: relative,
//                   onTap: () => _openForm(context, relative),
//                   onDelete: () => _showDeleteDialog(context, relative),
//                 );
//               },
//             ),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () => _openForm(context, null),
//         backgroundColor: AppColors.primaryColor,
//         elevation: 6,
//         icon: const Icon(
//           Icons.person_add_alt_1,
//           size: 22,
//           color: AppColors.whiteColor,
//         ),
//         label: const Text(
//           'Thêm người thân',
//           style: TextStyle(
//             fontWeight: FontWeight.w600,
//             color: AppColors.whiteColor,
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<void> _openForm(BuildContext context, RelativeModel? relative) async {
//     final result = await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (_) => BlocProvider(
//           create: (_) => serviceLocator<RelativeFormCubit>(),
//           child: RelativeFormPage(
//             mainCccd: widget.mainCccd,
//             relativeId: relative?.id,
//           ),
//         ),
//       ),
//     );
//     if (result == true) {
//       context.read<RelativeListCubit>().load(widget.mainCccd);
//     }
//   }
//
//   Future<void> _showDeleteDialog(
//     BuildContext context,
//     RelativeModel relative,
//   ) async {
//     final confirm = await showDialog<bool>(
//       context: context,
//       builder: (_) => AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         icon: const Icon(Icons.help_outline, size: 32, color: Colors.orange),
//         title: const Text(
//           'Xóa người thân?',
//           style: TextStyle(fontWeight: FontWeight.w600),
//         ),
//         content: Text('Xóa "${relative.fullName}" khỏi danh sách?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context, false),
//             child: const Text('Hủy'),
//           ),
//           FilledButton(
//             style: FilledButton.styleFrom(backgroundColor: Colors.redAccent),
//             onPressed: () => Navigator.pop(context, true),
//             child: const Text('Xóa'),
//           ),
//         ],
//       ),
//     );
//
//     if (confirm == true) {
//       context.read<RelativeListCubit>().delete(widget.mainCccd, relative.id!);
//     }
//   }
//
//   Widget _buildEmptyState() {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 40),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.family_restroom, size: 84, color: Colors.grey[400]),
//             const SizedBox(height: 24),
//             const Text(
//               'Chưa có người thân',
//               style: TextStyle(
//                 fontSize: 19,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.black87,
//               ),
//             ),
//             const SizedBox(height: 12),
//             Text(
//               'Thêm người thân để đặt khám nhanh hơn cho cả gia đình',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 14.5,
//                 color: Colors.grey[600],
//                 height: 1.5,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildShimmer() {
//     return ListView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: 6,
//       itemBuilder: (_, __) => Padding(
//         padding: const EdgeInsets.only(bottom: 12),
//         child: Shimmer.fromColors(
//           baseColor: Colors.grey[200]!,
//           highlightColor: Colors.grey[100]!,
//           child: Container(
//             height: 110,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(18),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class _RelativeCard extends StatelessWidget {
//   final RelativeModel relative;
//   final VoidCallback onTap;
//   final VoidCallback onDelete;
//
//   const _RelativeCard({
//     required this.relative,
//     required this.onTap,
//     required this.onDelete,
//   });
//
//   // Sao chép + toast
//   void _copyToClipboard(BuildContext context, String text, String label) {
//     if (text.trim().isEmpty) return;
//     Clipboard.setData(ClipboardData(text: text.trim()));
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Row(
//           children: [
//             const Icon(Icons.check_circle_rounded,
//                 color: Colors.white, size: 18),
//             const SizedBox(width: 8),
//             Expanded(
//               child: Text(
//                 '$label đã được sao chép',
//                 style: const TextStyle(fontWeight: FontWeight.w600),
//               ),
//             ),
//           ],
//         ),
//         backgroundColor: Colors.green.shade700,
//         behavior: SnackBarBehavior.floating,
//         margin: const EdgeInsets.all(16),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
//         duration: const Duration(milliseconds: 1500),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final rel = _getRelationshipInfo(relative.relationship);
//
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: Material(
//         color: Colors.transparent,
//         borderRadius: BorderRadius.circular(20),
//         child: InkWell(
//           borderRadius: BorderRadius.circular(20),
//           onTap: onTap,
//           child: Container(
//             decoration: BoxDecoration(
//               gradient: const LinearGradient(
//                 colors: [
//                   Color(0xFFFFFFFF),
//                   Color(0xFFF5F7FF),
//                 ],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//               borderRadius: BorderRadius.circular(20),
//               border: Border.all(
//                 color: rel.color.withOpacity(0.25),
//                 width: 1,
//               ),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.04),
//                   blurRadius: 10,
//                   offset: const Offset(0, 3),
//                 ),
//               ],
//             ),
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(12, 10, 10, 10),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Cột icon quan hệ (thay avatar)
//                   Container(
//                     padding: const EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       color: rel.color.withOpacity(0.09),
//                       borderRadius: BorderRadius.circular(14),
//                     ),
//                     child: Icon(
//                       rel.icon,
//                       size: 22,
//                       color: rel.color,
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//
//                   // Nội dung chính
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Header: tên + chip + menu
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     relative.fullName,
//                                     style: const TextStyle(
//                                       fontWeight: FontWeight.w800,
//                                       fontSize: 16,
//                                       letterSpacing: 0.1,
//                                     ),
//                                     maxLines: 1,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                   const SizedBox(height: 4),
//                                   Row(
//                                     children: [
//                                       Container(
//                                         padding: const EdgeInsets.symmetric(
//                                           horizontal: 9,
//                                           vertical: 3,
//                                         ),
//                                         decoration: BoxDecoration(
//                                           color: rel.color.withOpacity(0.12),
//                                           borderRadius:
//                                               BorderRadius.circular(20),
//                                         ),
//                                         child: Row(
//                                           mainAxisSize: MainAxisSize.min,
//                                           children: [
//                                             Icon(
//                                               Icons.favorite_rounded,
//                                               size: 12,
//                                               color: rel.color,
//                                             ),
//                                             const SizedBox(width: 4),
//                                             Text(
//                                               rel.label,
//                                               style: TextStyle(
//                                                 fontSize: 11.5,
//                                                 fontWeight: FontWeight.w600,
//                                                 color: rel.color,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       const SizedBox(width: 8),
//                                       if (relative.relationship == 'CHA' ||
//                                           relative.relationship == 'MẸ' ||
//                                           relative.relationship == 'ME')
//                                         Text(
//                                           'Người chăm sóc chính',
//                                           style: TextStyle(
//                                             fontSize: 11,
//                                             fontStyle: FontStyle.italic,
//                                             color: Colors.grey[600],
//                                           ),
//                                         ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             PopupMenuButton<String>(
//                               color: Colors.white,
//                               padding: EdgeInsets.zero,
//                               icon: Icon(
//                                 Icons.more_vert_rounded,
//                                 color: Colors.grey[600],
//                                 size: 20,
//                               ),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(14),
//                               ),
//                               onSelected: (value) {
//                                 if (value == 'edit') onTap();
//                                 if (value == 'delete') onDelete();
//                               },
//                               itemBuilder: (_) => [
//                                 const PopupMenuItem(
//                                   value: 'edit',
//                                   child: Row(
//                                     children: [
//                                       Icon(Icons.edit_rounded, size: 20),
//                                       SizedBox(width: 10),
//                                       Text('Chỉnh sửa'),
//                                     ],
//                                   ),
//                                 ),
//                                 PopupMenuItem(
//                                   value: 'delete',
//                                   child: Row(
//                                     children: const [
//                                       Icon(
//                                         Icons.delete_outline_rounded,
//                                         size: 20,
//                                         color: Colors.red,
//                                       ),
//                                       SizedBox(width: 10),
//                                       Text(
//                                         'Xóa',
//                                         style: TextStyle(color: Colors.red),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//
//                         const SizedBox(height: 8),
//
//                         // Các pill thông tin copy nhanh
//                         Wrap(
//                           spacing: 6,
//                           runSpacing: 6,
//                           children: [
//                             if (relative.cccd.isNotEmpty)
//                               _buildInfoPill(
//                                 context,
//                                 icon: Icons.badge_rounded,
//                                 label: 'CCCD',
//                                 value: relative.cccd,
//                                 onCopy: () => _copyToClipboard(
//                                   context,
//                                   relative.cccd,
//                                   'CCCD',
//                                 ),
//                               ),
//                             if (relative.phone.isNotEmpty)
//                               _buildInfoPill(
//                                 context,
//                                 icon: Icons.phone_iphone_rounded,
//                                 label: 'SĐT',
//                                 value: relative.phone,
//                                 onCopy: () => _copyToClipboard(
//                                   context,
//                                   relative.phone,
//                                   'Số điện thoại',
//                                 ),
//                               ),
//                             if (relative.patientCode.isNotEmpty)
//                               _buildInfoPill(
//                                 context,
//                                 icon: Icons.qr_code_2_rounded,
//                                 label: 'Mã BN',
//                                 value: relative.patientCode,
//                                 onCopy: () => _copyToClipboard(
//                                   context,
//                                   relative.patientCode,
//                                   'Mã bệnh nhân',
//                                 ),
//                               ),
//                           ],
//                         ),
//
//                         const SizedBox(height: 8),
//
//                         // Ngày sinh
//                         Row(
//                           children: [
//                             Icon(
//                               Icons.cake_rounded,
//                               size: 16,
//                               color: Colors.purple[600],
//                             ),
//                             const SizedBox(width: 6),
//                             Text(
//                               'Ngày sinh:',
//                               style: TextStyle(
//                                 fontSize: 12.5,
//                                 color: Colors.grey[600],
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                             const SizedBox(width: 4),
//                             Text(
//                               _formatDob(relative.dob),
//                               style: const TextStyle(
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.w600,
//                                 color: Colors.black87,
//                               ),
//                             ),
//                           ],
//                         ),
//
//                         // Địa chỉ
//                         if ((relative.addressDetail ?? '').isNotEmpty ||
//                             (relative.ward ?? '').isNotEmpty ||
//                             (relative.city ?? '').isNotEmpty)
//                           Padding(
//                             padding: const EdgeInsets.only(top: 4),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Icon(
//                                   Icons.place_rounded,
//                                   size: 16,
//                                   color: Colors.teal[600],
//                                 ),
//                                 const SizedBox(width: 6),
//                                 Expanded(
//                                   child: Text(
//                                     _buildAddressLine(relative),
//                                     maxLines: 2,
//                                     overflow: TextOverflow.ellipsis,
//                                     style: TextStyle(
//                                       fontSize: 12.5,
//                                       color: Colors.grey[800],
//                                       height: 1.3,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   // Pill thông tin có thể tap để copy
//   Widget _buildInfoPill(
//     BuildContext context, {
//     required IconData icon,
//     required String label,
//     required String value,
//     required VoidCallback onCopy,
//   }) {
//     return InkWell(
//       borderRadius: BorderRadius.circular(999),
//       onTap: onCopy,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(999),
//           border: Border.all(
//             color: AppColors.primaryColor.withOpacity(0.18),
//             width: 0.9,
//           ),
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(icon, size: 14, color: AppColors.primaryColor),
//             const SizedBox(width: 6),
//             Text(
//               '$label:',
//               style: TextStyle(
//                 fontSize: 12,
//                 color: Colors.grey[700],
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             const SizedBox(width: 4),
//             Text(
//               value,
//               style: const TextStyle(
//                 fontSize: 12.5,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.black87,
//               ),
//             ),
//             const SizedBox(width: 4),
//             const Icon(
//               Icons.copy_rounded,
//               size: 13,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // Format ngày sinh
//   String _formatDob(String dob) {
//     try {
//       final date = DateTime.parse(dob);
//       return DateFormat('dd/MM/yyyy').format(date);
//     } catch (_) {
//       return dob;
//     }
//   }
//
//   String _buildAddressLine(RelativeModel r) {
//     final parts = [
//       r.addressDetail,
//       r.ward,
//       r.city,
//     ].where((e) => e != null && e!.trim().isNotEmpty).toList();
//     if (parts.isEmpty) return '';
//     return parts.join(', ');
//   }
//
//   // Thông tin quan hệ (icon + màu + nhãn)
//   ({IconData icon, String label, Color color}) _getRelationshipInfo(
//     String? code,
//   ) {
//     return switch (code) {
//       'CHA' => (
//           icon: Icons.male_rounded,
//           label: 'Cha',
//           color: const Color(0xFF3B82F6), // xanh dương
//         ),
//       'MẸ' || 'ME' => (
//           icon: Icons.female_rounded,
//           label: 'Mẹ',
//           color: const Color(0xFFEC4899), // hồng
//         ),
//       'CON' => (
//           icon: Icons.child_care_rounded,
//           label: 'Con',
//           color: const Color(0xFF22C55E), // xanh lá
//         ),
//       'VO_CHONG' => (
//           icon: Icons.favorite_rounded,
//           label: 'Vợ/Chồng',
//           color: const Color(0xFFA855F7), // tím
//         ),
//       'ANH_CHI_EM' => (
//           icon: Icons.groups_rounded,
//           label: 'Anh chị em',
//           color: const Color(0xFFF97316), // cam
//         ),
//       'ONG_BA' => (
//           icon: Icons.elderly_rounded,
//           label: 'Ông bà',
//           color: const Color(0xFF8B5CF6), // tím nhạt
//         ),
//       _ => (
//           icon: Icons.person_rounded,
//           label: 'Người thân',
//           color: AppColors.primaryColor,
//         ),
//     };
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pstb/di/locator.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../constant/color.dart';
import '../../data/models/relative_model.dart';
import '../cubit/relative_form_cubit.dart';
import '../cubit/relative_list_cubit.dart';
import 'relative_form_page.dart';

class RelativeListPage extends StatefulWidget {
  final String mainCccd;
  const RelativeListPage({super.key, required this.mainCccd});

  @override
  State<RelativeListPage> createState() => _RelativeListPageState();
}

class _RelativeListPageState extends State<RelativeListPage>
    with TickerProviderStateMixin {
  late final AnimationController _fabController;

  @override
  void initState() {
    super.initState();
    _fabController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800))
      ..forward();
    context.read<RelativeListCubit>().load(widget.mainCccd);
  }

  @override
  void dispose() {
    _fabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Người thân',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocConsumer<RelativeListCubit, RelativeListState>(
        listener: (context, state) {
          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error!),
                backgroundColor: Colors.red[700],
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.loading && state.items.isEmpty) return _buildShimmer();
          if (state.items.isEmpty) return _buildEmpty();

          return RefreshIndicator(
            onRefresh: () =>
                context.read<RelativeListCubit>().load(widget.mainCccd),
            color: AppColors.primaryColor,
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 100), // gọn hơn
              itemCount: state.items.length,
              itemBuilder: (_, i) => Padding(
                padding: const EdgeInsets.only(bottom: 12), // giảm từ 14 → 12
                child: RelativeCardCompact(
                  relative: state.items[i],
                  onTap: () => _openForm(state.items[i]),
                  onDelete: () => _confirmDelete(state.items[i]),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: ScaleTransition(
        scale:
            CurvedAnimation(parent: _fabController, curve: Curves.elasticOut),
        child: FloatingActionButton.extended(
          onPressed: () => _openForm(null),
          backgroundColor: AppColors.primaryColor,
          icon: const Icon(Icons.person_add_alt_1_rounded,
              color: AppColors.whiteColor),
          label: const Text('Thêm người thân',
              style: TextStyle(
                  fontWeight: FontWeight.w600, color: AppColors.whiteColor)),
        ),
      ),
    );
  }

  Future<void> _openForm(RelativeModel? r) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => serviceLocator<RelativeFormCubit>(),
          child: RelativeFormPage(mainCccd: widget.mainCccd, relativeId: r?.id),
        ),
      ),
    );
    if (result == true) context.read<RelativeListCubit>().load(widget.mainCccd);
  }

  Future<void> _confirmDelete(RelativeModel r) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        icon: const Icon(Icons.help_outline_rounded,
            size: 36, color: Colors.orange),
        title: const Text('Xóa người thân?',
            style: TextStyle(fontWeight: FontWeight.w700)),
        content: Text('Xóa "${r.fullName}"?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Hủy')),
          FilledButton(
              onPressed: () => Navigator.pop(context, true),
              style: FilledButton.styleFrom(backgroundColor: Colors.red[600]),
              child: const Text('Xóa')),
        ],
      ),
    );
    if (ok == true)
      context.read<RelativeListCubit>().delete(widget.mainCccd, r.id!);
  }

  Widget _buildEmpty() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.family_restroom_rounded,
                size: 80, color: Colors.grey[400]),
            const SizedBox(height: 20),
            const Text('Chưa có người thân',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
            const SizedBox(height: 10),
            Text('Thêm người thân để đặt khám nhanh hơn',
                style: TextStyle(color: Colors.grey[600]),
                textAlign: TextAlign.center),
          ],
        ),
      );

  Widget _buildShimmer() => ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 6,
        itemBuilder: (_, __) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[200]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
                height: 156,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20))),
          ),
        ),
      );
}

// CARD GỌN – ĐẸP – KHÔNG THỪA KHOẢNG TRẮNG
class RelativeCardCompact extends StatelessWidget {
  final RelativeModel relative;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const RelativeCardCompact(
      {super.key,
      required this.relative,
      required this.onTap,
      required this.onDelete});

  void _copy(BuildContext ctx, String text, String label) {
    if (text.trim().isEmpty) return;
    Clipboard.setData(ClipboardData(text: text.trim()));
    ScaffoldMessenger.of(ctx).showSnackBar(
      SnackBar(
        content: Text('$label đã được sao chép'),
        backgroundColor: Colors.green[700],
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(milliseconds: 1500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final rel = _getRelationship(relative.relationship);

    return Card(
      elevation: 0.5,
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 16, vertical: 14), // giảm padding
          child: Column(
            children: [
              // Avatar + Tên + Quan hệ
              Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(colors: [
                        rel.color.withOpacity(0.22),
                        rel.color.withOpacity(0.08)
                      ]),
                      border: Border.all(
                          color: rel.color.withOpacity(0.4), width: 2),
                    ),
                    child: Icon(rel.icon, size: 30, color: rel.color),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          relative.fullName,
                          style: const TextStyle(
                              fontSize: 17.5, fontWeight: FontWeight.w800),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                              color: rel.color.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(rel.label,
                              style: TextStyle(
                                  color: rel.color,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12)),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuButton<String>(
                    color: AppColors.whiteColor,
                    icon: Icon(Icons.more_vert_rounded,
                        color: Colors.grey[600], size: 22),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                    onSelected: (v) => v == 'edit' ? onTap() : onDelete(),
                    itemBuilder: (_) => [
                      const PopupMenuItem(
                          value: 'edit',
                          child: Row(children: [
                            Icon(Icons.edit_outlined, size: 18),
                            SizedBox(width: 8),
                            Text('Chỉnh sửa')
                          ])),
                      const PopupMenuItem(
                          value: 'delete',
                          child: Row(children: [
                            Icon(Icons.delete_outline,
                                size: 18, color: Colors.red),
                            SizedBox(width: 8),
                            Text('Xóa', style: TextStyle(color: Colors.red))
                          ])),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 14), // giảm từ 20 → 14

              // Thông tin dọc gọn
              if (relative.cccd.isNotEmpty) ...[
                _infoRow(context, Icons.badge_rounded, 'CCCD', relative.cccd,
                    Colors.blue[700]!),
                const SizedBox(height: 8),
              ],
              if (relative.phone.isNotEmpty) ...[
                _infoRow(context, Icons.phone_iphone_rounded, 'SĐT',
                    relative.phone, Colors.green[700]!),
                const SizedBox(height: 8),
              ],
              if (relative.patientCode.isNotEmpty)
                _infoRow(context, Icons.qr_code_2_rounded, 'Mã BN',
                    relative.patientCode, Colors.purple[700]!),

              if (relative.cccd.isNotEmpty ||
                  relative.phone.isNotEmpty ||
                  relative.patientCode.isNotEmpty)
                const SizedBox(height: 8),

              // Ngày sinh + địa chỉ (gọn)
              Row(
                children: [
                  // Icon(Icons.cake_rounded, size: 18, color: Colors.pink[600]),
                  // const SizedBox(width: 8),
                  Text('Ngày sinh: ',
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w600,
                          fontSize: 13.5)),
                  Text(_formatDob(relative.dob),
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 13.5)),
                  const Spacer(),
                  // if (_hasAddress()) ...[
                  //   Icon(Icons.location_on_rounded,
                  //       size: 18, color: Colors.teal[600]),
                  //   const SizedBox(width: 6),
                  //   Expanded(
                  //       child: Text(_shortAddress(),
                  //           style: TextStyle(
                  //               color: Colors.grey[700], fontSize: 13),
                  //           overflow: TextOverflow.ellipsis)),
                  // ],
                ],
              ),
              const SizedBox(height: 8),
              if (_hasAddress()) ...[
                Row(
                  children: [
                    // Icon(Icons.cake_rounded, size: 18, color: Colors.pink[600]),
                    // const SizedBox(width: 8),

                    Icon(Icons.location_on_rounded,
                        size: 18, color: Colors.teal[600]),
                    const SizedBox(width: 6),
                    Expanded(
                        child: Text(_shortAddress(),
                            maxLines: 3,
                            style: TextStyle(
                                color: Colors.grey[700], fontSize: 13),
                            overflow: TextOverflow.ellipsis)),
                  ],
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(BuildContext ctx, IconData icon, String label, String value,
      Color color) {
    return GestureDetector(
      onTap: () => _copy(ctx, value, label),
      child: Row(
        children: [
          // Icon(icon, size: 20, color: color),
          // const SizedBox(width: 10),
          Text('$label: ',
              style: TextStyle(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w600,
                  fontSize: 13.5)),
          Expanded(
              child: Text(value,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.grey[900],
                      fontSize: 13.5))),
          Icon(
            Icons.copy_rounded,
            size: 16,
          ),
        ],
      ),
    );
  }

  String _formatDob(String dob) =>
      DateFormat('dd/MM/yyyy').format(DateTime.parse(dob));
  bool _hasAddress() => [relative.addressDetail, relative.ward, relative.city]
      .any((e) => e?.trim().isNotEmpty ?? false);
  String _shortAddress() => [
        relative.addressDetail,
        relative.ward,
        relative.city
      ].where((e) => e?.trim().isNotEmpty ?? false).join(', ');

  ({IconData icon, String label, Color color}) _getRelationship(String? code) =>
      switch (code) {
        'CHA' => (
            icon: Icons.male_rounded,
            label: 'Cha',
            color: const Color(0xFF2563EB)
          ),
        'MẸ' || 'ME' => (
            icon: Icons.female_rounded,
            label: 'Mẹ',
            color: const Color(0xFFEC4899)
          ),
        'CON' => (
            icon: Icons.child_care_rounded,
            label: 'Con',
            color: const Color(0xFF16A34A)
          ),
        'VO_CHONG' => (
            icon: Icons.favorite_rounded,
            label: 'Vợ/Chồng',
            color: const Color(0xFFD946EF)
          ),
        'ANH_CHI_EM' => (
            icon: Icons.groups_rounded,
            label: 'Anh chị em',
            color: const Color(0xFFF97316)
          ),
        'ONG_BA' => (
            icon: Icons.elderly_rounded,
            label: 'Ông bà',
            color: const Color(0xFF8B5CF6)
          ),
        _ => (
            icon: Icons.person_rounded,
            label: 'Người thân',
            color: AppColors.primaryColor
          ),
      };
}
