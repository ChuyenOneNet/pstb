// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_it/get_it.dart';
// import 'package:pstb/app/modules/nurse_page/electronic_signature_v2/presentation/pages/sign_document_detail_page.dart';
// import 'package:pstb/utils/snack_bar.dart';
// // App colors
// import '../../../../../../constant/color.dart';
// // Models
// import '../../../../../../di/locator.dart';
// import '../../../../../models/department_model.dart';
// import '../../../../../models/document_type_model.dart';
// import '../../../../../models/sign_roles_model.dart';
// // Data & Cubits
// import '../../data/filter_signature_model.dart';
// import '../cubits/departments_cubit/departments_cubit.dart';
// import '../cubits/documents_cubit/documents_cubit.dart';
// import '../cubits/documents_cubit/documents_state.dart';
// import '../cubits/filters_cubit/filters_cubit.dart';
// import '../cubits/roles_cubit/roles_cubit.dart';
// import '../cubits/patients_cubit/patients_cubit.dart';
// import '../cubits/patients_cubit/patients_state.dart';
// import '../cubits/roles_cubit/roles_state.dart';
// import '../cubits/sign_action_cubit/sign_action_cubit.dart';
// import '../cubits/sign_action_cubit/sign_action_state.dart';
// import '../cubits/sign_document_detail_cubit/sign_document_detail_cubit.dart';
// // Widgets
// import '../widgets/filter_bar.dart';
// import '../widgets/doc_tile.dart';
// import '../widgets/empty_view.dart';
// import '../../data/signing_status.dart' show mapStatusKeyToInt;
// import '../widgets/patient_picker_remote.dart';
// import '../widgets/role_picker_modal.dart';
// import '../widgets/searchable_picker.dart';
//
// class SignDocumentsPage extends StatefulWidget {
//   final String userName;
//   final TypeDocumentModel docType;
//   final String statusKey;
//   final DateTime? initialFromDate;
//   final DateTime? initialToDate;
//   const SignDocumentsPage({
//     super.key,
//     required this.userName,
//     required this.docType,
//     required this.statusKey,
//     this.initialFromDate,
//     this.initialToDate,
//   });
//   @override
//   State<SignDocumentsPage> createState() => _SignDocumentsPageState();
// }
//
// class _SignDocumentsPageState extends State<SignDocumentsPage> {
//   // Selections
//   String? _roleCode, _roleLabel;
//   String? _deptCode, _deptLabel;
//   String? _patientCode, _patientLabel;
//   DateTime? _from, _to;
//   // Search & scroll
//   final ScrollController _scroll = ScrollController();
//   final TextEditingController _searchCtrl = TextEditingController();
//   Timer? _debounce;
//   // Multi-select
//   final Set<String> _selectedIds = {};
//   bool _selectionMode = false;
//   int? _selectionStatus;
//   // Flags for role loading / dialog
//   bool _roleDialogActive = false;
//   OverlayEntry? _roleOverlay;
//   // Status codes
//   late final String? uiKey;
//   late final int? fixedStatusCode;
//   final int? _unsignedCode = mapStatusKeyToInt('unsigned');
//   final int? _signedCode = mapStatusKeyToInt('signed');
//
//   @override
//   void initState() {
//     super.initState();
//     _from = widget.initialFromDate;
//     _to = widget.initialToDate;
//     uiKey = widget.statusKey;
//     fixedStatusCode = mapStatusKeyToInt(uiKey);
//     // Optionally ensure filters are loaded (safe if already loaded by parent)
//     context.read<FiltersCubit>().add(LoadEvent(userName: widget.userName));
//     _scroll.addListener(_onScroll);
//     // Ensure roles are loaded if user hasn't picked any role yet
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final rolesCubit = context.read<RolesCubit>();
//       final st = rolesCubit.state;
//       if (_roleCode == null &&
//           (st.status == RolesStatus.initial ||
//               (st.roles.isEmpty && st.status != RolesStatus.loading))) {
//         rolesCubit.load(widget.userName);
//       } else {
//         // Already have a role or roles loaded → load data
//         _reload();
//       }
//     });
//     final now = DateTime.now();
//     final from = now.subtract(const Duration(days: 30));
//     _from = from;
//     _to = now;
//
//     _reload(
//       from: from,
//       to: now,
//     );
//   }
//
//   @override
//   void dispose() {
//     _scroll.dispose();
//     _searchCtrl.dispose();
//     _debounce?.cancel();
//     _dismissRoleOverlay();
//     super.dispose();
//   }
//
//   // ===== Overlay loading for Role fetch =====
//   void _showRoleOverlay([String text = 'Đang tải vai trò...']) {
//     if (!mounted || _roleOverlay != null) return;
//     _roleOverlay = OverlayEntry(
//       builder: (_) => Stack(
//         children: [
//           Positioned.fill(
//             child: Container(color: Colors.black.withOpacity(0.35)),
//           ),
//           Center(
//             child: Material(
//               color: Colors.transparent,
//               child: Container(
//                 width: 240,
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(12),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.08),
//                       blurRadius: 20,
//                       offset: const Offset(0, 8),
//                     ),
//                   ],
//                 ),
//                 child: Row(
//                   children: [
//                     const SizedBox(
//                       width: 28,
//                       height: 28,
//                       child: CircularProgressIndicator(
//                         strokeWidth: 2.4,
//                         valueColor:
//                             AlwaysStoppedAnimation<Color>(Color(0xFF1E7FFF)),
//                       ),
//                     ),
//                     const SizedBox(width: 14),
//                     Expanded(
//                       child: Text(
//                         text,
//                         style: const TextStyle(
//                           fontWeight: FontWeight.w600,
//                           color: Color(0xFF111827),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//     Overlay.of(context, rootOverlay: true).insert(_roleOverlay!);
//   }
//
//   void _dismissRoleOverlay() {
//     _roleOverlay?.remove();
//     _roleOverlay = null;
//   }
//
//   // ===== Helpers =====
//   void _onScroll() {
//     if (!_scroll.hasClients) return;
//     if (_scroll.position.maxScrollExtent - _scroll.position.pixels <= 300) {
//       context.read<DocumentsCubit>().loadMore();
//     }
//   }
//
//   String? _fmt(DateTime? d) => d == null
//       ? null
//       : '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year.toString().padLeft(4, '0')}';
//
//   List _clientFiltered(List items) {
//     final q = _searchCtrl.text.trim().toLowerCase();
//     if (q.isEmpty) return items;
//     return items.where((e) {
//       final name = (e.name ?? '').toLowerCase();
//       final patient = (e.patientName ?? '').toLowerCase();
//       return name.contains(q) || patient.contains(q);
//     }).toList();
//   }
//
//   void _reload({
//     String? roleCode,
//     String? deptCode,
//     String? patientCode,
//     DateTime? from,
//     DateTime? to,
//   }) {
//     _debounce?.cancel();
//     _debounce = Timer(const Duration(milliseconds: 200), () {
//       final filter = FilterSignatureModelV2(
//         userName: widget.userName,
//         signingStatusCode: fixedStatusCode,
//         documentTypeCode: widget.docType.code, // always filter by type
//         departmentCode: deptCode ?? _deptCode,
//         fromDate: _fmt(from ?? _from),
//         toDate: _fmt(to ?? _to),
//         searchValue: _searchCtrl.text.trim(),
//         patientCode: patientCode ?? _patientCode,
//         roleCode: roleCode ?? _roleCode,
//         pageSize: 10,
//       );
//       context
//           .read<DocumentsCubit>()
//           .refreshWithFilter(filter, withCounts: false);
//     });
//   }
//
//   // ===== Role picking flows =====
//   Future<void> _openMandatoryRolePicker(List<SignRolesModel> roles) async {
//     if (!mounted || _roleDialogActive) return;
//     _roleDialogActive = true;
//     await showDialog(
//       context: context,
//       barrierDismissible: true,
//       barrierColor: Colors.black.withOpacity(0.5),
//       builder: (_) => Dialog(
//         backgroundColor: Colors.transparent,
//         insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
//         child: RolePickerModal(
//           roles: roles,
//           userName: widget.userName,
//           // IMPORTANT: RolePickerModal must NOT auto-pick; only pick when user taps
//           onRoleSelected: (code, label) {
//             setState(() {
//               _roleCode = code;
//               _roleLabel = label;
//             });
//             Navigator.pop(context);
//             _reload();
//           },
//         ),
//       ),
//     );
//     _roleDialogActive = false;
//   }
//
//   Future<PickValue?> _pickRole() async {
//     final rolesCubit = context.read<RolesCubit>();
//     if (rolesCubit.state.roles.isEmpty &&
//         rolesCubit.state.status != RolesStatus.loading) {
//       _showRoleOverlay();
//       try {
//         await rolesCubit.load(widget.userName);
//       } finally {
//         _dismissRoleOverlay();
//       }
//     }
//     if (!mounted) return null;
//     final roles = rolesCubit.state.roles;
//     if (roles.isEmpty) {
//       await context.showSnackBarFail(
//           text: 'Không tải được vai trò. Vui lòng thử lại.');
//       return null;
//     }
//     PickValue? result;
//     await showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (_) => SearchableListSheet<SignRolesModel>(
//         title: 'Chọn vai trò',
//         items: roles,
//         labelOf: (r) => '${r.name ?? r.code}',
//         keyOf: (r) => (r.code ?? ''),
//         onSelected: (r) =>
//             result = PickValue(r.code ?? '', r.name ?? r.code ?? ''),
//         autofocus: false,
//       ),
//     );
//     if (result != null) {
//       setState(() {
//         _roleCode = result!.code;
//         _roleLabel = result!.label;
//       });
//       _reload(roleCode: result!.code);
//     }
//     return result;
//   }
//
//   Future<PickValue?> _pickDepartment() async {
//     final cubit = serviceLocator<DepartmentsCubit>();
//     if (cubit.state.departments.isEmpty &&
//         cubit.state.status != DepartmentsStatus.loading) {
//       await cubit.load();
//     }
//     final deps = cubit.state.departments;
//     PickValue? result;
//     await showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (_) => SearchableListSheet<DepartmentModel>(
//         title: 'Chọn khoa/phòng',
//         items: deps,
//         labelOf: (d) => d.name ?? d.code ?? 'N/A',
//         keyOf: (d) => d.code ?? '',
//         onSelected: (d) =>
//             result = PickValue(d.code ?? '', d.name ?? d.code ?? ''),
//         autofocus: false,
//       ),
//     );
//     if (result != null) {
//       setState(() {
//         _deptCode = result!.code;
//         _deptLabel = result!.label;
//       });
//       _reload(deptCode: result!.code);
//     }
//     return result;
//   }
//
//   Future<PickValue?> _pickPatient() async {
//     final res = await showModalBottomSheet<PickValue>(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (_) => BlocProvider.value(
//         value: context.read<PatientsCubit>(),
//         child: const PatientPickerRemote(),
//       ),
//     );
//     if (res != null) {
//       setState(() {
//         _patientCode = res.code;
//         _patientLabel = res.label;
//       });
//       _reload(patientCode: res.code);
//     }
//     return res;
//   }
//
//   Future<void> _openFilterPanel() async {
//     await showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: AppColors.whiteColor,
//       builder: (_) => FilterBar(
//         onApply: (search, dept, from, to, patient, {roleCode}) {
//           setState(() {
//             _deptCode = dept ?? _deptCode;
//             _from = from ?? _from;
//             _to = to ?? _to;
//             _patientCode = patient ?? _patientCode;
//             // Correctly sync role label when roleCode changes
//             if (roleCode != null) {
//               _roleCode = roleCode;
//               final roles = context.read<RolesCubit>().state.roles;
//               final found = roles.firstWhere(
//                 (r) => (r.code ?? '') == _roleCode,
//                 orElse: () => SignRolesModel(code: _roleCode, name: _roleCode),
//               );
//               _roleLabel = found.name ?? _roleCode;
//             }
//           });
//           _reload();
//         },
//         onReset: () {
//           setState(() {
//             _deptCode = _patientCode = null;
//             _deptLabel = _patientLabel = null;
//             _from = _to = null;
//           });
//           _reload();
//         },
//         onPickRole: _pickRole,
//         onPickDepartment: _pickDepartment,
//         onPickPatient: _pickPatient,
//         initRoleLabel: _roleLabel,
//         initDeptLabel: _deptLabel,
//         initPatientLabel: _patientLabel,
//         initFrom: _from,
//         initTo: _to,
//       ),
//     );
//   }
//
//   // ===== Selection helpers =====
//   List<dynamic> _visibleItems() => _clientFiltered(
//         context.read<DocumentsCubit>().state.items,
//       );
//
//   String? _safeId(dynamic e) {
//     try {
//       final v = e?.id;
//       if (v == null) return null;
//       final s = (v is String) ? v : v.toString();
//       if (s.isEmpty || s == 'null') return null;
//       return s;
//     } catch (_) {
//       return null;
//     }
//   }
//
//   int? _currentStatusCode() {
//     return fixedStatusCode;
//   }
//
//   String _statusText(int? s) {
//     if (s == _unsignedCode) return 'Chưa ký';
//     if (s == _signedCode) return 'Đã ký';
//     return 'Không xác định';
//   }
//
//   List<String> _selectableVisibleIds() {
//     final lock = _selectionStatus ?? _currentStatusCode();
//     if (lock == null) return [];
//     final ids = <String>[];
//     for (final e in _visibleItems()) {
//       if (e?.signingStatus == lock) {
//         final id = _safeId(e);
//         if (id != null) ids.add(id);
//       }
//     }
//     return ids;
//   }
//
//   bool _areAllSelectableVisibleSelected() {
//     final ids = _selectableVisibleIds();
//     if (ids.isEmpty) return false;
//     for (final id in ids) {
//       if (!_selectedIds.contains(id)) return false;
//     }
//     return true;
//   }
//
//   Map<String, int> _visibleStatusCounts() {
//     int u = 0, s = 0;
//     for (final e in _visibleItems()) {
//       final st = e?.signingStatus;
//       if (st == _unsignedCode) {
//         u++;
//       } else if (st == _signedCode) {
//         s++;
//       }
//     }
//     return {'unsigned': u, 'signed': s};
//   }
//
//   Future<int?> _pickStatusForSelectAll({
//     required int unsignedCount,
//     required int signedCount,
//   }) async {
//     if (!mounted) return null;
//     return showModalBottomSheet<int>(
//       context: context,
//       backgroundColor: Colors.white,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       builder: (_) {
//         return SafeArea(
//           top: false,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const SizedBox(height: 12),
//               Container(
//                 width: 40,
//                 height: 4,
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFE5E7EB),
//                   borderRadius: BorderRadius.circular(2),
//                 ),
//               ),
//               const SizedBox(height: 12),
//               const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16),
//                 child: Text(
//                   'Chọn trạng thái để "Chọn tất cả"',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
//                 ),
//               ),
//               const SizedBox(height: 8),
//               ListTile(
//                 leading: const Icon(Icons.pending_actions_outlined),
//                 title: Text('Chưa ký ($unsignedCount)'),
//                 onTap: () => Navigator.of(context).pop(_unsignedCode),
//               ),
//               ListTile(
//                 leading: const Icon(Icons.verified_outlined),
//                 title: Text('Đã ký ($signedCount)'),
//                 onTap: () => Navigator.of(context).pop(_signedCode),
//               ),
//               const SizedBox(height: 8),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Future<void> _toggleSelectAllSelectable() async {
//     final curLock = _selectionStatus ?? _currentStatusCode();
//     if (curLock == null) {
//       final counts = _visibleStatusCounts();
//       final u = counts['unsigned'] ?? 0;
//       final s = counts['signed'] ?? 0;
//       if (u == 0 && s == 0) {
//         await context.showSnackBarFail(
//           text: 'Không có tài liệu khả dụng để chọn.',
//         );
//         setState(() => _selectionMode = true);
//         return;
//       }
//       if (u > 0 && s == 0) {
//         setState(() => _selectionStatus = _unsignedCode);
//       } else if (s > 0 && u == 0) {
//         setState(() => _selectionStatus = _signedCode);
//       } else {
//         final chosen = await _pickStatusForSelectAll(
//           unsignedCount: u,
//           signedCount: s,
//         );
//         if (chosen == null) {
//           setState(() => _selectionMode = true);
//           return;
//         }
//         setState(() {
//           _selectionStatus = chosen;
//         });
//       }
//     }
//     final ids = _selectableVisibleIds();
//     if (ids.isEmpty) {
//       await context.showSnackBarFail(
//         text:
//             'Không có tài liệu trạng thái ${_statusText(_selectionStatus ?? _currentStatusCode())} để chọn.',
//       );
//       setState(() => _selectionMode = true);
//       return;
//     }
//     final all = _areAllSelectableVisibleSelected();
//     setState(() {
//       if (all) {
//         _selectedIds.removeWhere((id) => ids.contains(id));
//       } else {
//         _selectedIds.addAll(ids);
//       }
//       _selectionMode = true;
//     });
//   }
//
//   void _clearAllSelectionAndExit() {
//     setState(() {
//       _selectedIds.clear();
//       _selectionMode = false;
//       _selectionStatus = null;
//     });
//   }
//
//   Widget _selectionBar() {
//     if (!_selectionMode) return const SizedBox.shrink();
//     final locked = _selectionStatus ?? _currentStatusCode();
//     final selectableIds = _selectableVisibleIds();
//     final totalSelectable = selectableIds.length;
//     final selectedInScope = selectableIds.where(_selectedIds.contains).length;
//     final allSelected =
//         (totalSelectable > 0) && (selectedInScope == totalSelectable);
//     final hasSelection = _selectedIds.isNotEmpty;
//     final canSign = locked != null && locked == _unsignedCode && hasSelection;
//     final canCancel = locked != null && locked == _signedCode && hasSelection;
//     // Disable while sign/revoke processing
//     final actionState = context.watch<SignActionCubit>().state;
//     final bool isBusy = actionState.status == SignActionStatus.signing ||
//         actionState.status == SignActionStatus.revoking;
//     return SafeArea(
//       top: false,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 160),
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           border: const Border(
//             top: BorderSide(color: Color(0xFFE5E7EB), width: 1),
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.06),
//               blurRadius: 10,
//               offset: const Offset(0, -2),
//             ),
//           ],
//           borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
//         ),
//         child: Row(
//           children: [
//             InkWell(
//               onTap: (totalSelectable == 0 || isBusy)
//                   ? null
//                   : _toggleSelectAllSelectable,
//               borderRadius: BorderRadius.circular(8),
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
//                 child: Row(
//                   children: [
//                     Checkbox(
//                       activeColor: AppColors.primaryColor,
//                       value: allSelected && totalSelectable > 0,
//                       onChanged: (totalSelectable == 0 || isBusy)
//                           ? null
//                           : (_) => _toggleSelectAllSelectable(),
//                     ),
//                     const SizedBox(width: 4),
//                     Text(
//                       'Tất cả ($selectedInScope/$totalSelectable)',
//                       style: TextStyle(
//                         color: totalSelectable == 0
//                             ? const Color(0xFF9CA3AF)
//                             : const Color(0xFF111827),
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const Spacer(),
//             if (canSign)
//               ElevatedButton.icon(
//                 icon: const Icon(Icons.edit_note),
//                 label: Text(isBusy ? 'Đang ký...' : 'Ký'),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF1E7FFF),
//                   foregroundColor: Colors.white,
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
//                   textStyle: const TextStyle(fontWeight: FontWeight.w700),
//                 ),
//                 onPressed: isBusy
//                     ? null
//                     : () async {
//                         if (_roleCode == null) {
//                           await context.showSnackBarFail(
//                             text: 'Vui lòng chọn vai trò ký trước khi ký',
//                           );
//                           return;
//                         }
//                         context.read<SignActionCubit>().sign(
//                               userName: widget.userName,
//                               roleCode: _roleCode!,
//                               ids: _selectedIds.toList(),
//                             );
//                       },
//               ),
//             if (canCancel)
//               OutlinedButton.icon(
//                 icon: const Icon(Icons.cancel_outlined),
//                 label: Text(isBusy ? 'Đang huỷ...' : 'Hủy ký'),
//                 style: OutlinedButton.styleFrom(
//                   side: BorderSide(color: AppColors.primaryColor, width: 1.5),
//                   foregroundColor: AppColors.primaryColor,
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
//                   textStyle: const TextStyle(fontWeight: FontWeight.w700),
//                 ),
//                 onPressed: isBusy
//                     ? null
//                     : () {
//                         context.read<SignActionCubit>().revoke(
//                               userName: widget.userName,
//                               ids: _selectedIds.toList(),
//                             );
//                       },
//               ),
//             IconButton(
//               tooltip: 'Thoát',
//               icon: const Icon(Icons.close),
//               onPressed: isBusy ? null : _clearAllSelectionAndExit,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ===== UI =====
//   @override
//   Widget build(BuildContext context) {
//     // Listen sign action → show toast + reload
//     return MultiBlocListener(
//       listeners: [
//         BlocListener<SignActionCubit, SignActionState>(
//           listenWhen: (prev, curr) =>
//               prev.status != curr.status &&
//               (curr.status == SignActionStatus.success ||
//                   curr.status == SignActionStatus.failure),
//           listener: (context, state) async {
//             final msg = state.message ??
//                 (state.status == SignActionStatus.success
//                     ? 'Thực hiện thành công'
//                     : 'Thực hiện thất bại');
//             if (state.status == SignActionStatus.success) {
//               await context.showSnackBarSuccess(text: msg);
//               _clearAllSelectionAndExit();
//               _reload();
//             } else if (state.status == SignActionStatus.failure) {
//               await context.showSnackBarFail(text: msg);
//             }
//           },
//         ),
//         // Listen roles loading → overlay + mandatory picker if no role chosen
//         BlocListener<RolesCubit, RolesState>(
//           listenWhen: (p, c) => p.status != c.status,
//           listener: (ctx, st) async {
//             if (_roleCode != null) {
//               _dismissRoleOverlay();
//               return;
//             }
//             if (st.status == RolesStatus.loading) {
//               _showRoleOverlay();
//             } else {
//               _dismissRoleOverlay();
//             }
//             if (st.status == RolesStatus.success && _roleCode == null) {
//               if (st.roles.isEmpty) {
//                 await context.showSnackBarFail(
//                     text: 'Không tải được vai trò. Vui lòng thử lại.');
//               } else {
//                 await _openMandatoryRolePicker(st.roles);
//                 // If still no role after closing picker, keep waiting (user canceled)
//               }
//             }
//             if (st.status == RolesStatus.failure && _roleCode == null) {
//               await context.showSnackBarFail(
//                   text: st.error ?? 'Lỗi tải vai trò');
//             }
//           },
//         ),
//       ],
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(
//             widget.docType.name ?? widget.docType.code ?? 'Tài liệu',
//             style: const TextStyle(fontWeight: FontWeight.w700),
//           ),
//           actions: [
//             IconButton(
//               tooltip: _selectionMode ? 'Thoát chọn' : 'Chọn nhiều',
//               icon: Icon(
//                 _selectionMode
//                     ? Icons.cancel_outlined
//                     : Icons.checklist_rounded,
//               ),
//               onPressed: () async {
//                 if (_selectionMode) {
//                   _clearAllSelectionAndExit();
//                 } else {
//                   if (_roleCode == null) {
//                     await context.showSnackBarFail(
//                       text: 'Vui lòng chọn vai trò ký trước khi chọn tài liệu',
//                     );
//                     return;
//                   }
//                   setState(() {
//                     _selectionMode = true;
//                     _selectionStatus = _currentStatusCode();
//                   });
//                 }
//               },
//             ),
//             IconButton(
//               tooltip: 'Bộ lọc',
//               icon: const Icon(Icons.filter_list_rounded),
//               onPressed: _openFilterPanel,
//             ),
//           ],
//           bottom: PreferredSize(
//             preferredSize: const Size.fromHeight(64),
//             child: Padding(
//               padding: const EdgeInsets.all(12),
//               child: TextField(
//                 controller: _searchCtrl,
//                 textInputAction: TextInputAction.search,
//                 style: const TextStyle(color: Colors.white, fontSize: 15),
//                 decoration: InputDecoration(
//                   hintText: 'Tìm tài liệu, bệnh nhân...',
//                   hintStyle: TextStyle(
//                       color: Colors.white.withOpacity(0.6), fontSize: 14),
//                   prefixIcon: Icon(Icons.search,
//                       color: Colors.white.withOpacity(0.6), size: 20),
//                   suffixIcon: (_searchCtrl.text.isEmpty)
//                       ? null
//                       : IconButton(
//                           icon: Icon(Icons.close,
//                               color: Colors.white.withOpacity(0.6), size: 20),
//                           onPressed: () {
//                             _searchCtrl.clear();
//                             setState(() {});
//                             _reload();
//                           },
//                         ),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: BorderSide(
//                         color: Colors.white.withOpacity(0.25), width: 1.5),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: BorderSide(
//                         color: Colors.white.withOpacity(0.25), width: 1.5),
//                   ),
//                   focusedBorder: const OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(12)),
//                     borderSide: BorderSide(color: Colors.white, width: 2),
//                   ),
//                   filled: true,
//                   fillColor: Colors.white.withOpacity(0.12),
//                   isDense: true,
//                   contentPadding: const EdgeInsets.symmetric(vertical: 12),
//                 ),
//                 onSubmitted: (_) => _reload(),
//                 onChanged: (_) => _reload(),
//               ),
//             ),
//           ),
//           flexibleSpace: Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Color(0xFF1E7FFF), Color(0xFF0D47A1)],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//           ),
//           backgroundColor: Colors.transparent,
//           foregroundColor: Colors.white,
//         ),
//         body: _roleCode == null
//             ? Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(Icons.lock_outlined,
//                         size: 64, color: Color(0xFFD1D5DB)),
//                     SizedBox(height: 16),
//                     Text(
//                       'Chưa chọn vai trò',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: Color(0xFF6B7280),
//                       ),
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       'Vui lòng chọn vai trò ký để xem danh sách',
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Color(0xFF9CA3AF),
//                       ),
//                     ),
//                     ElevatedButton.icon(
//                       icon: const Icon(Icons.verified_user_outlined),
//                       label: const Text(
//                         'Chọn vai trò ký để xem danh sách',
//                         style: TextStyle(fontWeight: FontWeight.w700),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF1E7FFF),
//                         foregroundColor: Colors.white,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10)),
//                       ),
//                       onPressed: _pickRole,
//                     ),
//                   ],
//                 ),
//               )
//             : Column(
//                 children: [
//                   Container(
//                     width: double.infinity,
//                     color: Colors.white,
//                     padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
//                     child: Wrap(
//                         spacing: 8, runSpacing: 4, children: _activeChips()),
//                   ),
//                   Expanded(
//                     child: BlocBuilder<DocumentsCubit, DocumentsState>(
//                       builder: (context, st) {
//                         if (st.status == DocLoadStatus.loading &&
//                             st.items.isEmpty) {
//                           return const Center(
//                             child: CircularProgressIndicator(
//                               valueColor:
//                                   AlwaysStoppedAnimation(Color(0xFF1E7FFF)),
//                             ),
//                           );
//                         }
//                         if (st.status == DocLoadStatus.failure &&
//                             st.items.isEmpty) {
//                           return EmptyView(
//                             title: 'Lỗi khi tải',
//                             message:
//                                 'Không thể tải tài liệu. Vui lòng thử lại.',
//                             icon: Icons.error_outline,
//                             action: ElevatedButton.icon(
//                               onPressed: _reload,
//                               icon: const Icon(
//                                 Icons.refresh,
//                                 color: AppColors.whiteColor,
//                               ),
//                               label: const Text(
//                                 'Thử lại',
//                                 style: TextStyle(color: AppColors.whiteColor),
//                               ),
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: const Color(0xFF1E7FFF),
//                               ),
//                             ),
//                           );
//                         }
//                         final list = _clientFiltered(st.items);
//                         if (list.isEmpty) {
//                           return const EmptyView(
//                             title: 'Không có tài liệu',
//                             message:
//                                 'Không tìm thấy tài liệu nào. Hãy điều chỉnh bộ lọc.',
//                             icon: Icons.folder_open,
//                           );
//                         }
//                         return Stack(
//                           children: [
//                             RefreshIndicator(
//                               onRefresh: () async => _reload(),
//                               color: const Color(0xFF1E7FFF),
//                               child: ListView.builder(
//                                 controller: _scroll,
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 8),
//                                 itemCount: list.length + (st.hasMore ? 1 : 0),
//                                 itemBuilder: (context, i) {
//                                   if (i < list.length) {
//                                     final item = list[i];
//                                     final rawId = item.id;
//                                     final id = (rawId is String)
//                                         ? rawId
//                                         : (rawId?.toString() ?? '');
//                                     final sel = _selectedIds.contains(id);
//                                     return DocTile(
//                                       item: item,
//                                       selectionMode: _selectionMode,
//                                       isSelected: sel,
//                                       onSelectionChanged: (checked) async {
//                                         if (id.isEmpty || id == 'null') {
//                                           await context.showSnackBarFail(
//                                             text:
//                                                 'Không thể chọn mục thiếu ID hợp lệ',
//                                           );
//                                           return;
//                                         }
//                                         final int? itemStatus =
//                                             item.signingStatus;
//                                         final int? curTabStatus =
//                                             _currentStatusCode();
//                                         final int? effectiveLock =
//                                             _selectionStatus ??
//                                                 curTabStatus ??
//                                                 itemStatus;
//                                         if (itemStatus != effectiveLock) {
//                                           await context.showSnackBarFail(
//                                             text:
//                                                 'Chỉ chọn mục trạng thái ${_statusText(effectiveLock)}',
//                                           );
//                                           return;
//                                         }
//                                         setState(() {
//                                           if (_selectionStatus == null) {
//                                             _selectionStatus = effectiveLock;
//                                           }
//                                           if (checked) {
//                                             _selectedIds.add(id);
//                                           } else {
//                                             _selectedIds.remove(id);
//                                           }
//                                           _selectionMode = true;
//                                         });
//                                       },
//                                       onTap: !_selectionMode
//                                           ? () async {
//                                               if (_roleCode == null) {
//                                                 await context.showSnackBarFail(
//                                                   text:
//                                                       'Vui lòng chọn vai trò ký trước khi xem chi tiết',
//                                                 );
//                                                 return;
//                                               }
//                                               final changed =
//                                                   await Navigator.of(context)
//                                                       .push<bool>(
//                                                 MaterialPageRoute(
//                                                   builder: (_) =>
//                                                       SignDocumentDetailScreen(
//                                                     userName: widget.userName,
//                                                     documentItem: item,
//                                                     roleCode: _roleCode,
//                                                     roleLabel: _roleLabel,
//                                                   ),
//                                                 ),
//                                               );
//                                               if (changed == true) _reload();
//                                             }
//                                           : null,
//                                     );
//                                   }
//                                   return const Padding(
//                                     padding: EdgeInsets.symmetric(vertical: 24),
//                                     child: Center(
//                                       child: SizedBox(
//                                         width: 24,
//                                         height: 24,
//                                         child: CircularProgressIndicator(
//                                           strokeWidth: 2,
//                                           valueColor: AlwaysStoppedAnimation(
//                                               Color(0xFF1E7FFF)),
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                 },
//                                 addAutomaticKeepAlives: false,
//                                 addRepaintBoundaries: true,
//                                 addSemanticIndexes: false,
//                               ),
//                             ),
//                             Positioned(
//                               left: 0,
//                               right: 0,
//                               bottom: 0,
//                               child: _selectionBar(),
//                             ),
//                           ],
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//       ),
//     );
//   }
//
//   // ===== UI bits =====
//   List<Widget> _activeChips() {
//     final chips = <Widget>[];
//     if (_roleLabel != null) {
//       chips.add(InputChip(
//         side: BorderSide(color: AppColors.primaryColor, width: 2),
//         backgroundColor: AppColors.primaryColor.withOpacity(0.1),
//         label: Text(
//           'Vai trò: $_roleLabel',
//           style: TextStyle(
//             color: AppColors.primaryColor,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         onPressed: _pickRole,
//       ));
//     }
//     if (_deptLabel != null) {
//       chips.add(InputChip(
//         side: BorderSide(color: AppColors.primaryColor),
//         backgroundColor: AppColors.whiteColor,
//         label: Text(
//           'Khoa: $_deptLabel',
//           style: const TextStyle(color: AppColors.blackColor),
//         ),
//         onPressed: _pickDepartment,
//         onDeleted: () {
//           setState(() {
//             _deptCode = _deptLabel = null;
//           });
//           _reload();
//         },
//       ));
//     }
//     if (_patientLabel != null) {
//       chips.add(InputChip(
//         side: BorderSide(color: AppColors.primaryColor),
//         backgroundColor: AppColors.whiteColor,
//         label: Text(
//           'BN: $_patientLabel',
//           style: const TextStyle(color: AppColors.blackColor),
//         ),
//         onPressed: _pickPatient,
//         onDeleted: () {
//           setState(() {
//             _patientCode = _patientLabel = null;
//           });
//           _reload();
//         },
//       ));
//     }
//     if (_from != null && _to != null) {
//       chips.add(InputChip(
//         side: BorderSide(color: AppColors.primaryColor),
//         backgroundColor: AppColors.whiteColor,
//         label: Text(
//           'Ngày: ${_from!.day}/${_from!.month}-${_to!.day}/${_to!.month}',
//           style: const TextStyle(color: AppColors.blackColor),
//         ),
//         onPressed: _openFilterPanel,
//         onDeleted: () {
//           setState(() {
//             _from = _to = null;
//           });
//           _reload();
//         },
//       ));
//     }
//     return chips;
//   }
// }

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pstb/app/modules/nurse_page/electronic_signature_v2/presentation/pages/sign_document_detail_page.dart';
import 'package:pstb/utils/snack_bar.dart';

// App colors
import '../../../../../../constant/color.dart';

// Models
import '../../../../../../di/locator.dart';
import '../../../../../models/department_model.dart';
import '../../../../../models/document_type_model.dart';
import '../../../../../models/sign_roles_model.dart';

// Data & Cubits
import '../../data/filter_signature_model.dart';
import '../../data/repositories/signature_repository.dart';
import '../cubits/departments_cubit/departments_cubit.dart';
import '../cubits/documents_cubit/documents_cubit.dart';
import '../cubits/documents_cubit/documents_state.dart';
import '../cubits/filters_cubit/filters_cubit.dart';
import '../cubits/roles_cubit/roles_cubit.dart';
import '../cubits/patients_cubit/patients_cubit.dart';
import '../cubits/patients_cubit/patients_state.dart';
import '../cubits/roles_cubit/roles_state.dart';
import '../cubits/sign_action_cubit/sign_action_cubit.dart';
import '../cubits/sign_action_cubit/sign_action_state.dart';

// Widgets
import '../widgets/filter_bar.dart';
import '../widgets/doc_tile.dart';
import '../widgets/empty_view.dart';
import '../../data/signing_status.dart' show mapStatusKeyToInt;
import '../widgets/patient_picker_remote.dart';
import '../widgets/role_picker_modal.dart';
import '../widgets/searchable_picker.dart';

class SignDocumentsPage extends StatefulWidget {
  final String userName;
  final TypeDocumentModel docType;
  final String statusKey;
  final DateTime? initialFromDate;
  final DateTime? initialToDate;

  const SignDocumentsPage({
    super.key,
    required this.userName,
    required this.docType,
    required this.statusKey,
    this.initialFromDate,
    this.initialToDate,
  });

  @override
  State<SignDocumentsPage> createState() => _SignDocumentsPageState();
}

class _SignDocumentsPageState extends State<SignDocumentsPage> {
  // Selections / filters
  String? _roleCode, _roleLabel;
  String? _deptCode, _deptLabel;
  String? _patientCode, _patientLabel;
  DateTime? _from, _to;

  // Search & scroll
  final ScrollController _scroll = ScrollController();
  final TextEditingController _searchCtrl = TextEditingController();
  Timer? _debounce;

  // Multi-select
  final Set<String> _selectedIds = {};
  bool _selectionMode = false;
  int? _selectionStatus;

  // Overlay khi load role (dùng cho picker chung)
  OverlayEntry? _roleOverlay;

  // Status codes
  late final String? uiKey;
  late final int? fixedStatusCode;
  final int? _unsignedCode = mapStatusKeyToInt('unsigned');
  final int? _signedCode = mapStatusKeyToInt('signed');

  @override
  void initState() {
    super.initState();

    uiKey = widget.statusKey;
    fixedStatusCode = mapStatusKeyToInt(uiKey);

    // khoảng ngày mặc định: 30 ngày gần nhất, có thể override từ initial*
    final now = DateTime.now();
    final fromDefault = now.subtract(const Duration(days: 30));
    _from = widget.initialFromDate ?? fromDefault;
    _to = widget.initialToDate ?? now;

    // load bộ lọc chung (nếu có)
    context.read<FiltersCubit>().add(LoadEvent(userName: widget.userName));

    _scroll.addListener(_onScroll);

    // load danh sách tài liệu ngay, không phụ thuộc roleCode
    _reload(from: _from, to: _to);
  }

  @override
  void dispose() {
    _scroll.dispose();
    _searchCtrl.dispose();
    _debounce?.cancel();
    _dismissRoleOverlay();
    super.dispose();
  }

  // ===== Overlay loading cho việc load danh sách role (picker chung) =====

  void _showRoleOverlay([String text = 'Đang tải vai trò...']) {
    if (!mounted || _roleOverlay != null) return;
    _roleOverlay = OverlayEntry(
      builder: (_) => Stack(
        children: [
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.35)),
          ),
          Center(
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: 240,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 28,
                      height: 28,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.4,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(0xFF1E7FFF)),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        text,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF111827),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
    Overlay.of(context, rootOverlay: true).insert(_roleOverlay!);
  }

  void _dismissRoleOverlay() {
    _roleOverlay?.remove();
    _roleOverlay = null;
  }

  // ===== Helpers =====

  void _onScroll() {
    if (!_scroll.hasClients) return;
    if (_scroll.position.maxScrollExtent - _scroll.position.pixels <= 300) {
      context.read<DocumentsCubit>().loadMore();
    }
  }

  String? _fmt(DateTime? d) => d == null
      ? null
      : '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year.toString().padLeft(4, '0')}';

  List _clientFiltered(List items) {
    final q = _searchCtrl.text.trim().toLowerCase();
    if (q.isEmpty) return items;
    return items.where((e) {
      final name = (e.name ?? '').toLowerCase();
      final patient = (e.patientName ?? '').toLowerCase();
      return name.contains(q) || patient.contains(q);
    }).toList();
  }

  void _reload({
    String? roleCode,
    String? deptCode,
    String? patientCode,
    DateTime? from,
    DateTime? to,
  }) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 200), () {
      final filter = FilterSignatureModelV2(
        userName: widget.userName,
        signingStatusCode: fixedStatusCode,
        documentTypeCode: widget.docType.code, // luôn filter theo loại tài liệu
        departmentCode: deptCode ?? _deptCode,
        fromDate: _fmt(from ?? _from),
        toDate: _fmt(to ?? _to),
        searchValue: _searchCtrl.text.trim(),
        patientCode: patientCode ?? _patientCode,
        roleCode: roleCode ?? _roleCode, // đây là role lọc, không phải role ký
        pageSize: 10,
      );

      context
          .read<DocumentsCubit>()
          .refreshWithFilter(filter, withCounts: false);
    });
  }

  // ===== Flow chọn Role CHUNG (để lọc dữ liệu, không dùng để ký) =====

  Future<PickValue?> _pickRole() async {
    final rolesCubit = context.read<RolesCubit>();
    if (rolesCubit.state.roles.isEmpty &&
        rolesCubit.state.status != RolesStatus.loading) {
      _showRoleOverlay();
      try {
        await rolesCubit.load(widget.userName);
      } finally {
        _dismissRoleOverlay();
      }
    }
    if (!mounted) return null;
    final roles = rolesCubit.state.roles;
    if (roles.isEmpty) {
      await context.showSnackBarFail(
        text: 'Không tải được vai trò. Vui lòng thử lại.',
      );
      return null;
    }

    PickValue? result;
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SearchableListSheet<SignRolesModel>(
        title: 'Chọn vai trò',
        items: roles,
        labelOf: (r) => '${r.name ?? r.code}',
        keyOf: (r) => (r.code ?? ''),
        onSelected: (r) =>
            result = PickValue(r.code ?? '', r.name ?? r.code ?? ''),
        autofocus: false,
      ),
    );

    if (result != null) {
      setState(() {
        _roleCode = result!.code;
        _roleLabel = result!.label;
      });
      _reload(roleCode: result!.code);
    }
    return result;
  }

  Future<PickValue?> _pickDepartment() async {
    final cubit = serviceLocator<DepartmentsCubit>();
    if (cubit.state.departments.isEmpty &&
        cubit.state.status != DepartmentsStatus.loading) {
      await cubit.load();
    }
    final deps = cubit.state.departments;
    PickValue? result;
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SearchableListSheet<DepartmentModel>(
        title: 'Chọn khoa/phòng',
        items: deps,
        labelOf: (d) => d.name ?? d.code ?? 'N/A',
        keyOf: (d) => d.code ?? '',
        onSelected: (d) =>
            result = PickValue(d.code ?? '', d.name ?? d.code ?? ''),
        autofocus: false,
      ),
    );
    if (result != null) {
      setState(() {
        _deptCode = result!.code;
        _deptLabel = result!.label;
      });
      _reload(deptCode: result!.code);
    }
    return result;
  }

  Future<PickValue?> _pickPatient() async {
    final res = await showModalBottomSheet<PickValue>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: context.read<PatientsCubit>(),
        child: const PatientPickerRemote(),
      ),
    );
    if (res != null) {
      setState(() {
        _patientCode = res.code;
        _patientLabel = res.label;
      });
      _reload(patientCode: res.code);
    }
    return res;
  }

  Future<void> _openFilterPanel() async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.whiteColor,
      builder: (_) => FilterBar(
        onApply: (search, dept, from, to, patient, {roleCode}) {
          setState(() {
            _deptCode = dept ?? _deptCode;
            _from = from ?? _from;
            _to = to ?? _to;
            _patientCode = patient ?? _patientCode;
            // đồng bộ lại label role nếu có đổi
            if (roleCode != null) {
              _roleCode = roleCode;
              final roles = context.read<RolesCubit>().state.roles;
              final found = roles.firstWhere(
                (r) => (r.code ?? '') == _roleCode,
                orElse: () => SignRolesModel(code: _roleCode, name: _roleCode),
              );
              _roleLabel = found.name ?? _roleCode;
            }
          });
          _reload();
        },
        onReset: () {
          setState(() {
            _deptCode = _patientCode = null;
            _deptLabel = _patientLabel = null;
            _from = _to = null;
          });
          _reload();
        },
        onPickRole: _pickRole,
        onPickDepartment: _pickDepartment,
        onPickPatient: _pickPatient,
        initRoleLabel: _roleLabel,
        initDeptLabel: _deptLabel,
        initPatientLabel: _patientLabel,
        initFrom: _from,
        initTo: _to,
      ),
    );
  }

  // ===== Helper chọn role KHI KÝ, theo từng tài liệu =====

  Future<PickValue?> _pickRoleForDocument(String documentId) async {
    final repo = serviceLocator<SignatureRepository>();

    try {
      final roles = await repo.getSignerRolesForDocument(
        userName: widget.userName,
        documentId: documentId,
      );

      if (roles.isEmpty) {
        await context.showSnackBarFail(
          text: 'Không tìm thấy vai trò ký cho tài liệu này.',
        );
        return null;
      }

      PickValue? result;
      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => SearchableListSheet<SignRolesModel>(
          title: 'Chọn vai trò để ký',
          items: roles,
          labelOf: (r) => r.name ?? r.code ?? 'N/A',
          keyOf: (r) => r.code ?? '',
          onSelected: (r) =>
              result = PickValue(r.code ?? '', r.name ?? r.code ?? ''),
          autofocus: false,
        ),
      );

      return result;
    } catch (e) {
      await context.showSnackBarFail(
        text: 'Lỗi khi tải vai trò ký: $e',
      );
      return null;
    }
  }

  // ===== Selection helpers =====

  List<dynamic> _visibleItems() =>
      _clientFiltered(context.read<DocumentsCubit>().state.items);

  String? _safeId(dynamic e) {
    try {
      final v = e?.id;
      if (v == null) return null;
      final s = (v is String) ? v : v.toString();
      if (s.isEmpty || s == 'null') return null;
      return s;
    } catch (_) {
      return null;
    }
  }

  int? _currentStatusCode() => fixedStatusCode;

  String _statusText(int? s) {
    if (s == _unsignedCode) return 'Chưa ký';
    if (s == _signedCode) return 'Đã ký';
    return 'Không xác định';
  }

  List<String> _selectableVisibleIds() {
    final lock = _selectionStatus ?? _currentStatusCode();
    if (lock == null) return [];
    final ids = <String>[];
    for (final e in _visibleItems()) {
      if (e?.signingStatus == lock) {
        final id = _safeId(e);
        if (id != null) ids.add(id);
      }
    }
    return ids;
  }

  bool _areAllSelectableVisibleSelected() {
    final ids = _selectableVisibleIds();
    if (ids.isEmpty) return false;
    for (final id in ids) {
      if (!_selectedIds.contains(id)) return false;
    }
    return true;
  }

  Map<String, int> _visibleStatusCounts() {
    int u = 0, s = 0;
    for (final e in _visibleItems()) {
      final st = e?.signingStatus;
      if (st == _unsignedCode) {
        u++;
      } else if (st == _signedCode) {
        s++;
      }
    }
    return {'unsigned': u, 'signed': s};
  }

  Future<int?> _pickStatusForSelectAll({
    required int unsignedCount,
    required int signedCount,
  }) async {
    if (!mounted) return null;
    return showModalBottomSheet<int>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFE5E7EB),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 12),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Chọn trạng thái để "Chọn tất cả"',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 8),
              ListTile(
                leading: const Icon(Icons.pending_actions_outlined),
                title: Text('Chưa ký ($unsignedCount)'),
                onTap: () => Navigator.of(context).pop(_unsignedCode),
              ),
              ListTile(
                leading: const Icon(Icons.verified_outlined),
                title: Text('Đã ký ($signedCount)'),
                onTap: () => Navigator.of(context).pop(_signedCode),
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  Future<void> _toggleSelectAllSelectable() async {
    final curLock = _selectionStatus ?? _currentStatusCode();
    if (curLock == null) {
      final counts = _visibleStatusCounts();
      final u = counts['unsigned'] ?? 0;
      final s = counts['signed'] ?? 0;
      if (u == 0 && s == 0) {
        await context.showSnackBarFail(
          text: 'Không có tài liệu khả dụng để chọn.',
        );
        setState(() => _selectionMode = true);
        return;
      }
      if (u > 0 && s == 0) {
        setState(() => _selectionStatus = _unsignedCode);
      } else if (s > 0 && u == 0) {
        setState(() => _selectionStatus = _signedCode);
      } else {
        final chosen = await _pickStatusForSelectAll(
          unsignedCount: u,
          signedCount: s,
        );
        if (chosen == null) {
          setState(() => _selectionMode = true);
          return;
        }
        setState(() {
          _selectionStatus = chosen;
        });
      }
    }
    final ids = _selectableVisibleIds();
    if (ids.isEmpty) {
      await context.showSnackBarFail(
        text:
            'Không có tài liệu trạng thái ${_statusText(_selectionStatus ?? _currentStatusCode())} để chọn.',
      );
      setState(() => _selectionMode = true);
      return;
    }
    final all = _areAllSelectableVisibleSelected();
    setState(() {
      if (all) {
        _selectedIds.removeWhere((id) => ids.contains(id));
      } else {
        _selectedIds.addAll(ids);
      }
      _selectionMode = true;
    });
  }

  void _clearAllSelectionAndExit() {
    setState(() {
      _selectedIds.clear();
      _selectionMode = false;
      _selectionStatus = null;
    });
  }

  Widget _selectionBar() {
    if (!_selectionMode) return const SizedBox.shrink();

    final locked = _selectionStatus ?? _currentStatusCode();
    final selectableIds = _selectableVisibleIds();
    final totalSelectable = selectableIds.length;
    final selectedInScope = selectableIds.where(_selectedIds.contains).length;
    final allSelected =
        (totalSelectable > 0) && (selectedInScope == totalSelectable);
    final hasSelection = _selectedIds.isNotEmpty;

    final canSign = locked != null && locked == _unsignedCode && hasSelection;
    final canCancel = locked != null && locked == _signedCode && hasSelection;

    // Disable trong khi đang sign/revoke
    final actionState = context.watch<SignActionCubit>().state;
    final bool isBusy = actionState.status == SignActionStatus.signing ||
        actionState.status == SignActionStatus.revoking;

    return SafeArea(
      top: false,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: const Border(
            top: BorderSide(color: Color(0xFFE5E7EB), width: 1),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
          borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
        ),
        child: Row(
          children: [
            InkWell(
              onTap: (totalSelectable == 0 || isBusy)
                  ? null
                  : _toggleSelectAllSelectable,
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                child: Row(
                  children: [
                    Checkbox(
                      activeColor: AppColors.primaryColor,
                      value: allSelected && totalSelectable > 0,
                      onChanged: (totalSelectable == 0 || isBusy)
                          ? null
                          : (_) => _toggleSelectAllSelectable(),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Tất cả ($selectedInScope/$totalSelectable)',
                      style: TextStyle(
                        color: totalSelectable == 0
                            ? const Color(0xFF9CA3AF)
                            : const Color(0xFF111827),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            if (canSign)
              ElevatedButton.icon(
                icon: const Icon(Icons.edit_note),
                label: Text(isBusy ? 'Đang ký...' : 'Ký'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E7FFF),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  textStyle: const TextStyle(fontWeight: FontWeight.w700),
                ),
                onPressed: isBusy
                    ? null
                    : () async {
                        if (_selectedIds.isEmpty) {
                          await context.showSnackBarFail(
                            text: 'Chưa chọn tài liệu nào để ký.',
                          );
                          return;
                        }

                        // Nếu muốn chỉ cho phép ký từng tài liệu một:
                        // if (_selectedIds.length > 1) { ... }

                        final firstId = _selectedIds.first;
                        final picked =
                            await _pickRoleForDocument(firstId); // /api/App/...
                        if (picked == null) return;

                        context.read<SignActionCubit>().sign(
                              userName: widget.userName,
                              roleCode: picked.code,
                              ids: _selectedIds.toList(),
                            );
                      },
              ),
            if (canCancel)
              OutlinedButton.icon(
                icon: const Icon(Icons.cancel_outlined),
                label: Text(isBusy ? 'Đang huỷ...' : 'Hủy ký'),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.primaryColor, width: 1.5),
                  foregroundColor: AppColors.primaryColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  textStyle: const TextStyle(fontWeight: FontWeight.w700),
                ),
                onPressed: isBusy
                    ? null
                    : () {
                        context.read<SignActionCubit>().revoke(
                              userName: widget.userName,
                              ids: _selectedIds.toList(),
                            );
                      },
              ),
            IconButton(
              tooltip: 'Thoát',
              icon: const Icon(Icons.close),
              onPressed: isBusy ? null : _clearAllSelectionAndExit,
            ),
          ],
        ),
      ),
    );
  }

  // ===== UI =====

  @override
  Widget build(BuildContext context) {
    // Lắng nghe kết quả sign/revoke để show toast + reload
    return MultiBlocListener(
      listeners: [
        BlocListener<SignActionCubit, SignActionState>(
          listenWhen: (prev, curr) =>
              prev.status != curr.status &&
              (curr.status == SignActionStatus.success ||
                  curr.status == SignActionStatus.failure),
          listener: (context, state) async {
            final msg = state.message ??
                (state.status == SignActionStatus.success
                    ? 'Thực hiện thành công'
                    : 'Thực hiện thất bại');
            if (state.status == SignActionStatus.success) {
              await context.showSnackBarSuccess(text: msg);
              _clearAllSelectionAndExit();
              _reload();
            } else if (state.status == SignActionStatus.failure) {
              await context.showSnackBarFail(text: msg);
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.docType.name ?? widget.docType.code ?? 'Tài liệu',
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          actions: [
            IconButton(
              tooltip: _selectionMode ? 'Thoát chọn' : 'Chọn nhiều',
              icon: Icon(
                _selectionMode
                    ? Icons.cancel_outlined
                    : Icons.checklist_rounded,
              ),
              onPressed: () {
                if (_selectionMode) {
                  _clearAllSelectionAndExit();
                } else {
                  setState(() {
                    _selectionMode = true;
                    _selectionStatus = _currentStatusCode();
                  });
                }
              },
            ),
            IconButton(
              tooltip: 'Bộ lọc',
              icon: const Icon(Icons.filter_list_rounded),
              onPressed: _openFilterPanel,
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(64),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                controller: _searchCtrl,
                textInputAction: TextInputAction.search,
                style: const TextStyle(color: Colors.white, fontSize: 15),
                decoration: InputDecoration(
                  hintText: 'Tìm tài liệu, bệnh nhân...',
                  hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 14,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white.withOpacity(0.6),
                    size: 20,
                  ),
                  suffixIcon: (_searchCtrl.text.isEmpty)
                      ? null
                      : IconButton(
                          icon: Icon(
                            Icons.close,
                            color: Colors.white.withOpacity(0.6),
                            size: 20,
                          ),
                          onPressed: () {
                            _searchCtrl.clear();
                            setState(() {});
                            _reload();
                          },
                        ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.white.withOpacity(0.25),
                      width: 1.5,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.white.withOpacity(0.25),
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(color: Colors.white, width: 2),
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.12),
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onSubmitted: (_) => _reload(),
                onChanged: (_) => _reload(),
              ),
            ),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1E7FFF), Color(0xFF0D47A1)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
        ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
              child: Wrap(
                spacing: 8,
                runSpacing: 4,
                children: _activeChips(),
              ),
            ),
            Expanded(
              child: BlocBuilder<DocumentsCubit, DocumentsState>(
                builder: (context, st) {
                  if (st.status == DocLoadStatus.loading && st.items.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Color(0xFF1E7FFF)),
                      ),
                    );
                  }
                  if (st.status == DocLoadStatus.failure && st.items.isEmpty) {
                    return EmptyView(
                      title: 'Lỗi khi tải',
                      message: 'Không thể tải tài liệu. Vui lòng thử lại.',
                      icon: Icons.error_outline,
                      action: ElevatedButton.icon(
                        onPressed: _reload,
                        icon: const Icon(
                          Icons.refresh,
                          color: AppColors.whiteColor,
                        ),
                        label: const Text(
                          'Thử lại',
                          style: TextStyle(color: AppColors.whiteColor),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1E7FFF),
                        ),
                      ),
                    );
                  }

                  final list = _clientFiltered(st.items);
                  if (list.isEmpty) {
                    return const EmptyView(
                      title: 'Không có tài liệu',
                      message:
                          'Không tìm thấy tài liệu nào. Hãy điều chỉnh bộ lọc.',
                      icon: Icons.folder_open,
                    );
                  }

                  return Stack(
                    children: [
                      RefreshIndicator(
                        color: AppColors.primaryColor,
                        backgroundColor: AppColors.whiteColor,
                        onRefresh: () async => _reload(),
                        child: ListView.builder(
                          controller: _scroll,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          itemCount: list.length + (st.hasMore ? 1 : 0),
                          itemBuilder: (context, i) {
                            if (i < list.length) {
                              final item = list[i];
                              final rawId = item.id;
                              final id = (rawId is String)
                                  ? rawId
                                  : (rawId?.toString() ?? '');
                              final sel = _selectedIds.contains(id);

                              return DocTile(
                                item: item,
                                selectionMode: _selectionMode,
                                isSelected: sel,
                                onSelectionChanged: (checked) async {
                                  if (id.isEmpty || id == 'null') {
                                    await context.showSnackBarFail(
                                      text:
                                          'Không thể chọn mục thiếu ID hợp lệ',
                                    );
                                    return;
                                  }
                                  final int? itemStatus = item.signingStatus;
                                  final int? curTabStatus =
                                      _currentStatusCode();
                                  final int? effectiveLock = _selectionStatus ??
                                      curTabStatus ??
                                      itemStatus;
                                  if (itemStatus != effectiveLock) {
                                    await context.showSnackBarFail(
                                      text:
                                          'Chỉ chọn mục trạng thái ${_statusText(effectiveLock)}',
                                    );
                                    return;
                                  }
                                  setState(() {
                                    if (_selectionStatus == null) {
                                      _selectionStatus = effectiveLock;
                                    }
                                    if (checked) {
                                      _selectedIds.add(id);
                                    } else {
                                      _selectedIds.remove(id);
                                    }
                                    _selectionMode = true;
                                  });
                                },
                                onTap: !_selectionMode
                                    ? () async {
                                        final changed = await Navigator.of(
                                          context,
                                        ).push<bool>(
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                SignDocumentDetailScreen(
                                              userName: widget.userName,
                                              documentItem: item,
                                              // roleCode/roleLabel không bắt buộc nữa
                                              //roleCode: _roleCode,
                                              //roleLabel: _roleLabel,
                                            ),
                                          ),
                                        );
                                        if (changed == true) _reload();
                                      }
                                    : null,
                              );
                            }

                            // item load-more
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 24),
                              child: Center(
                                child: SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation(
                                      Color(0xFF1E7FFF),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          addAutomaticKeepAlives: false,
                          addRepaintBoundaries: true,
                          addSemanticIndexes: false,
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: _selectionBar(),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===== UI bits =====

  List<Widget> _activeChips() {
    final chips = <Widget>[];

    if (_roleLabel != null) {
      chips.add(
        InputChip(
          side: BorderSide(color: AppColors.primaryColor, width: 2),
          backgroundColor: AppColors.primaryColor.withOpacity(0.1),
          label: Text(
            'Vai trò: $_roleLabel',
            style: TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          onPressed: _pickRole,
        ),
      );
    }

    if (_deptLabel != null) {
      chips.add(
        InputChip(
          side: BorderSide(color: AppColors.primaryColor),
          backgroundColor: AppColors.whiteColor,
          label: Text(
            'Khoa: $_deptLabel',
            style: const TextStyle(color: AppColors.blackColor),
          ),
          onPressed: _pickDepartment,
          onDeleted: () {
            setState(() {
              _deptCode = _deptLabel = null;
            });
            _reload();
          },
        ),
      );
    }

    if (_patientLabel != null) {
      chips.add(
        InputChip(
          side: BorderSide(color: AppColors.primaryColor),
          backgroundColor: AppColors.whiteColor,
          label: Text(
            'BN: $_patientLabel',
            style: const TextStyle(color: AppColors.blackColor),
          ),
          onPressed: _pickPatient,
          onDeleted: () {
            setState(() {
              _patientCode = _patientLabel = null;
            });
            _reload();
          },
        ),
      );
    }

    if (_from != null && _to != null) {
      chips.add(
        InputChip(
          side: BorderSide(color: AppColors.primaryColor),
          backgroundColor: AppColors.whiteColor,
          label: Text(
            'Ngày: ${_from!.day}/${_from!.month}-${_to!.day}/${_to!.month}',
            style: const TextStyle(color: AppColors.blackColor),
          ),
          onPressed: _openFilterPanel,
          onDeleted: () {
            setState(() {
              _from = _to = null;
            });
            _reload();
          },
        ),
      );
    }

    return chips;
  }
}
