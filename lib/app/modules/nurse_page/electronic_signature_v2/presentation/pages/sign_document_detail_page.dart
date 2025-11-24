// // lib/app/modules/nurse_page/electronic_signature_v2/presentation/pages/sign_document_detail_page.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pstb/utils/snack_bar.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// import 'package:syncfusion_flutter_core/theme.dart';
//
// import '../cubits/sign_document_detail_cubit/sign_document_detail_cubit.dart';
// import '../../../../../../constant/color.dart';
//
// /// Dùng widget này khi điều hướng:
// /// Navigator.push(context, MaterialPageRoute(
// ///   builder: (_) => SignDocumentDetailScreen(
// ///     userName: userName,
// ///     documentItem: item,
// ///     roleCode: roleCode,     // bắt buộc truyền từ màn list (đã chọn role)
// ///     roleLabel: roleLabel,   // hiển thị đẹp ở header
// ///   ),
// /// ));
// class SignDocumentDetailScreen extends StatelessWidget {
//   final String userName;
//   final dynamic documentItem; // cần: id, name, signingStatus, documentTypeCode
//   final String? roleCode;
//   final String? roleLabel;
//
//   const SignDocumentDetailScreen({
//     super.key,
//     required this.userName,
//     required this.documentItem,
//     this.roleCode,
//     this.roleLabel,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<DocumentDetailCubit>(
//       create: (_) => DocumentDetailCubit(),
//       child: SignDocumentDetailPage(
//         userName: userName,
//         documentItem: documentItem,
//         roleCode: roleCode,
//         roleLabel: roleLabel,
//       ),
//     );
//   }
// }
//
// class SignDocumentDetailPage extends StatefulWidget {
//   final String userName;
//   final dynamic documentItem;
//   final String? roleCode;
//   final String? roleLabel;
//
//   const SignDocumentDetailPage({
//     super.key,
//     required this.userName,
//     required this.documentItem,
//     this.roleCode,
//     this.roleLabel,
//   });
//
//   @override
//   State<SignDocumentDetailPage> createState() => _SignDocumentDetailPageState();
// }
//
// class _SignDocumentDetailPageState extends State<SignDocumentDetailPage>
//     with AutomaticKeepAliveClientMixin {
//   late final String _docId;
//   late final bool _initialSigned;
//   final PdfViewerController _pdfCtrl = PdfViewerController();
//
//   @override
//   bool get wantKeepAlive => true;
//
//   Color _statusColor(bool isSigned) =>
//       isSigned ? const Color(0xFF10B981) : const Color(0xFFF59E0B);
//
//   String _statusText(bool isSigned) => isSigned ? 'Đã ký' : 'Chưa ký';
//
//   @override
//   void initState() {
//     super.initState();
//     _docId = widget.documentItem.id?.toString() ?? '';
//     _initialSigned = (widget.documentItem.signingStatus == 1);
//
//     // Tải PDF + header; Cubit đã có cache RAM (nếu bạn áp dụng phần cubit tối ưu)
//     context
//         .read<DocumentDetailCubit>()
//         .load(docId: _docId, initialSigned: _initialSigned);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//
//     final title = (widget.documentItem.name?.toString() ??
//         widget.documentItem.documentTypeCode?.toString() ??
//         'Chi tiết tài liệu');
//
//     return Scaffold(
//       backgroundColor: AppColors.whiteColor,
//       appBar: AppBar(
//         elevation: 0,
//         title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
//         actions: [
//           IconButton(
//             tooltip: 'Làm mới',
//             icon: const Icon(Icons.refresh),
//             onPressed: () =>
//                 context.read<DocumentDetailCubit>().refresh(docId: _docId),
//           ),
//         ],
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Color(0xFF1E7FFF), Color(0xFF0D47A1)],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//         ),
//         backgroundColor: Colors.transparent,
//         foregroundColor: Colors.white,
//       ),
//       body: ColoredBox(
//         color: Colors.white,
//         child: Column(
//           children: [
//             // Header meta: trạng thái + role đang dùng (được truyền từ màn trước)
//             BlocBuilder<DocumentDetailCubit, DocumentDetailState>(
//               builder: (context, st) {
//                 final isSigned = st.isSigned;
//                 return Material(
//                   elevation: 1,
//                   color: Colors.white,
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 14, vertical: 10),
//                     child: Row(
//                       children: [
//                         // Chip trạng thái
//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 10, vertical: 6),
//                           decoration: BoxDecoration(
//                             color: _statusColor(isSigned).withOpacity(0.12),
//                             borderRadius: BorderRadius.circular(999),
//                             border: Border.all(
//                               color: _statusColor(isSigned).withOpacity(0.6),
//                               width: 1,
//                             ),
//                           ),
//                           child: Row(
//                             children: [
//                               Icon(
//                                 isSigned
//                                     ? Icons.verified_outlined
//                                     : Icons.pending_actions_outlined,
//                                 size: 16,
//                                 color: _statusColor(isSigned),
//                               ),
//                               const SizedBox(width: 6),
//                               Text(
//                                 _statusText(isSigned),
//                                 style: TextStyle(
//                                   color: _statusColor(isSigned),
//                                   fontWeight: FontWeight.w700,
//                                   letterSpacing: -0.2,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(width: 8),
//                         // Chip vai trò (chỉ hiển thị, không chọn tại đây)
//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 10, vertical: 6),
//                           decoration: BoxDecoration(
//                             color: Colors.black.withOpacity(0.04),
//                             borderRadius: BorderRadius.circular(999),
//                             border: Border.all(color: Colors.black12, width: 1),
//                           ),
//                           child: Row(
//                             children: [
//                               const Icon(Icons.badge_outlined, size: 16),
//                               const SizedBox(width: 6),
//                               Text(
//                                 widget.roleLabel ?? 'Không có vai trò',
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.w600,
//                                   color: Color(0xFF666666),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//
//             // PDF viewer (ưu tiên bytes từ cache RAM, fallback network)
//             Expanded(
//               child: BlocBuilder<DocumentDetailCubit, DocumentDetailState>(
//                 builder: (context, st) {
//                   if (st.loading) {
//                     return const Center(
//                       child: CircularProgressIndicator(
//                         valueColor: AlwaysStoppedAnimation(Color(0xFF1E7FFF)),
//                       ),
//                     );
//                   }
//
//                   if (st.error != null) {
//                     return Center(
//                       child: Padding(
//                         padding: const EdgeInsets.all(24),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             const Icon(Icons.error_outline,
//                                 size: 42, color: Colors.redAccent),
//                             const SizedBox(height: 12),
//                             Text(st.error!, textAlign: TextAlign.center),
//                             const SizedBox(height: 12),
//                             ElevatedButton.icon(
//                               icon: const Icon(Icons.refresh),
//                               label: const Text('Thử lại'),
//                               onPressed: () => context
//                                   .read<DocumentDetailCubit>()
//                                   .refresh(docId: _docId),
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: const Color(0xFF1E7FFF),
//                                 foregroundColor: Colors.white,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   }
//
//                   if ((st.pdfUrl ?? '').isEmpty && st.pdfBytes == null) {
//                     return const Center(
//                         child: Text('Không có tài liệu để hiển thị'));
//                   }
//
//                   final headers = st.headers ?? const {};
//                   final Widget viewer = (st.pdfBytes != null)
//                       ? SfPdfViewer.memory(
//                           st.pdfBytes!,
//                           controller: _pdfCtrl,
//                           enableDoubleTapZooming: true,
//                           canShowScrollStatus: true,
//                           onDocumentLoadFailed: (details) {
//                             context.showSnackBarFail(
//                               text: 'Lỗi tải PDF: ${details.error}',
//                             );
//                           },
//                         )
//                       : SfPdfViewer.network(
//                           st.pdfUrl!,
//                           headers: headers,
//                           controller: _pdfCtrl,
//                           enableDoubleTapZooming: true,
//                           canShowScrollStatus: true,
//                           onDocumentLoadFailed: (details) {
//                             context.showSnackBarFail(
//                               text: 'Lỗi tải PDF: ${details.error}',
//                             );
//                           },
//                         );
//
//                   return SfPdfViewerTheme(
//                     data: SfPdfViewerThemeData(
//                       backgroundColor: Colors.white,
//                       progressBarColor: AppColors.primaryColor,
//                     ),
//                     child: ColoredBox(color: Colors.white, child: viewer),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//
//       // FAB ký/thu hồi (unique heroTag để tránh đụng độ Hero mặc định)
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       floatingActionButton:
//           BlocBuilder<DocumentDetailCubit, DocumentDetailState>(
//         builder: (context, st) {
//           final isSigned = st.isSigned;
//
//           return AnimatedSwitcher(
//             duration: const Duration(milliseconds: 180),
//             child: SizedBox(
//               key: ValueKey('${isSigned}_${st.acting}'),
//               width: MediaQuery.of(context).size.width * 0.9,
//               child: FloatingActionButton.extended(
//                 heroTag: 'detail-sign-fab-$_docId',
//                 elevation: 2,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(14),
//                 ),
//                 backgroundColor:
//                     isSigned ? Colors.redAccent : AppColors.primaryColor,
//                 icon: Icon(
//                   isSigned ? Icons.cancel_outlined : Icons.edit,
//                   color: Colors.white,
//                 ),
//                 label: st.acting
//                     ? const SizedBox(
//                         height: 18,
//                         width: 18,
//                         child: CircularProgressIndicator(
//                           strokeWidth: 2,
//                           valueColor:
//                               AlwaysStoppedAnimation<Color>(Colors.white),
//                         ),
//                       )
//                     : Text(
//                         isSigned ? 'Thu hồi ký' : 'Thực hiện ký',
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                 onPressed: st.acting
//                     ? null
//                     : () async {
//                         final cubit = context.read<DocumentDetailCubit>();
//
//                         if (isSigned) {
//                           // Thu hồi chữ ký
//                           final ok = await cubit.revoke(
//                             userName: widget.userName,
//                             docId: _docId,
//                           );
//
//                           final msg = cubit.state.toast ??
//                               (ok ? 'Huỷ ký thành công' : 'Huỷ ký thất bại');
//
//                           if (ok) {
//                             await context.showSnackBarSuccess(text: msg);
//                             if (mounted) Navigator.of(context).pop(true);
//                           } else {
//                             context.showSnackBarFail(text: msg);
//                           }
//                         } else {
//                           // Ký — cần roleCode
//                           if (widget.roleCode == null) {
//                             context.showSnackBarFail(
//                               text:
//                                   'Không có vai trò được chọn. Vui lòng quay lại và chọn vai trò.',
//                             );
//                             return;
//                           }
//
//                           final ok = await cubit.sign(
//                             userName: widget.userName,
//                             roleCode: widget.roleCode!,
//                             docId: _docId,
//                           );
//
//                           final msg = cubit.state.toast ??
//                               (ok ? 'Ký thành công' : 'Ký thất bại');
//
//                           if (ok) {
//                             await context.showSnackBarSuccess(text: msg);
//                             if (mounted) Navigator.of(context).pop(true);
//                           } else {
//                             context.showSnackBarFail(text: msg);
//                           }
//                         }
//                       },
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// lib/app/modules/nurse_page/electronic_signature_v2/presentation/pages/sign_document_detail_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pstb/app/modules/nurse_page/electronic_signature_v2/data/repositories/signature_repository_impl.dart';
import 'package:pstb/utils/snack_bar.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import '../../../../../../di/locator.dart';
import '../../../../../models/sign_roles_model.dart';
import '../../data/repositories/signature_repository.dart';
import '../cubits/sign_document_detail_cubit/sign_document_detail_cubit.dart';
import '../../../../../../constant/color.dart';

// 🔵 SỬA – import API lấy vai trò theo tài liệu
import '../widgets/filter_bar.dart';
import '../widgets/searchable_picker.dart';

class SignDocumentDetailScreen extends StatelessWidget {
  final String userName;
  final dynamic documentItem;

  const SignDocumentDetailScreen({
    super.key,
    required this.userName,
    required this.documentItem,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DocumentDetailCubit>(
      create: (_) => DocumentDetailCubit(),
      child: SignDocumentDetailPage(
        userName: userName,
        documentItem: documentItem,
      ),
    );
  }
}

class SignDocumentDetailPage extends StatefulWidget {
  final String userName;
  final dynamic documentItem;

  const SignDocumentDetailPage({
    super.key,
    required this.userName,
    required this.documentItem,
  });

  @override
  State<SignDocumentDetailPage> createState() => _SignDocumentDetailPageState();
}

class _SignDocumentDetailPageState extends State<SignDocumentDetailPage>
    with AutomaticKeepAliveClientMixin {
  late final String _docId;
  late final bool _initialSigned;
  final PdfViewerController _pdfCtrl = PdfViewerController();

  // 🔵 SỬA – role dùng để ký trong màn detail
  String? _roleCode;
  String? _roleLabel;

  @override
  bool get wantKeepAlive => true;

  Color _statusColor(bool isSigned) =>
      isSigned ? const Color(0xFF10B981) : const Color(0xFFF59E0B);

  String _statusText(bool isSigned) => isSigned ? 'Đã ký' : 'Chưa ký';

  @override
  void initState() {
    super.initState();
    _docId = widget.documentItem.id?.toString() ?? '';
    _initialSigned = (widget.documentItem.signingStatus == 1);

    context
        .read<DocumentDetailCubit>()
        .load(docId: _docId, initialSigned: _initialSigned);

    // 🔵 SỬA – tự lấy role theo tài liệu khi vào màn
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadRolesPerDocument();
    });
  }

  // 🔵 SỬA – Lấy vai trò theo tài liệu
  Future<void> _loadRolesPerDocument() async {
    final repo = serviceLocator<SignatureRepository>();
    final roles = await repo.getSignerRolesForDocument(
      userName: widget.userName,
      documentId: _docId,
    );

    if (!mounted) return;

    if (roles.isEmpty) {
      await context.showSnackBarFail(
        text: "Không tìm thấy vai trò ký cho tài liệu này.",
      );
      return;
    }

    if (roles.length == 1) {
      // 1 role → auto chọn
      setState(() {
        _roleCode = roles.first.code!;
        _roleLabel = roles.first.name!;
      });
      return;
    }

    // >1 role → popup chọn
    final PickValue? pick = await showModalBottomSheet<PickValue>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SearchableListSheet<SignRolesModel>(
        title: 'Chọn vai trò ký',
        items: roles,
        labelOf: (r) => r.name ?? r.code ?? '',
        keyOf: (r) => r.code ?? '',
        onSelected: (r) => Navigator.pop(
            context, PickValue(r.code ?? '', r.name ?? r.code ?? '')),
      ),
    );

    if (pick != null) {
      setState(() {
        _roleCode = pick.code;
        _roleLabel = pick.label;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final title = (widget.documentItem.name?.toString() ??
        widget.documentItem.documentTypeCode?.toString() ??
        'Chi tiết tài liệu');

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
        actions: [
          IconButton(
            tooltip: 'Làm mới',
            icon: const Icon(Icons.refresh),
            onPressed: () =>
                context.read<DocumentDetailCubit>().refresh(docId: _docId),
          ),
        ],
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
      body: ColoredBox(
        color: Colors.white,
        child: Column(
          children: [
            // ===== HEADER STATUS + ROLE =====
            BlocBuilder<DocumentDetailCubit, DocumentDetailState>(
              builder: (context, st) {
                final isSigned = st.isSigned;
                return Material(
                  elevation: 1,
                  color: Colors.white,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    child: Row(
                      children: [
                        // Chip trạng thái
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: _statusColor(isSigned).withOpacity(0.12),
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(
                              color: _statusColor(isSigned).withOpacity(0.6),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                isSigned
                                    ? Icons.verified_outlined
                                    : Icons.pending_actions_outlined,
                                size: 16,
                                color: _statusColor(isSigned),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                _statusText(isSigned),
                                style: TextStyle(
                                  color: _statusColor(isSigned),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),

                        // Chip vai trò
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(color: Colors.black12),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.badge_outlined, size: 16),
                              const SizedBox(width: 6),
                              Text(
                                _roleLabel ?? 'Đang tải vai trò...',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF555555),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            // ===== PDF VIEWER =====
            Expanded(
              child: BlocBuilder<DocumentDetailCubit, DocumentDetailState>(
                builder: (context, st) {
                  if (st.loading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Color(0xFF1E7FFF)),
                      ),
                    );
                  }

                  if (st.error != null) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.error_outline,
                                size: 42, color: Colors.redAccent),
                            const SizedBox(height: 12),
                            Text(st.error!, textAlign: TextAlign.center),
                            const SizedBox(height: 12),
                            ElevatedButton.icon(
                              icon: const Icon(Icons.refresh),
                              label: const Text('Thử lại'),
                              onPressed: () => context
                                  .read<DocumentDetailCubit>()
                                  .refresh(docId: _docId),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1E7FFF),
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  final viewer = (st.pdfBytes != null)
                      ? SfPdfViewer.memory(
                          st.pdfBytes!,
                          controller: _pdfCtrl,
                        )
                      : SfPdfViewer.network(
                          st.pdfUrl!,
                          headers: st.headers ?? const {},
                          controller: _pdfCtrl,
                        );

                  return SfPdfViewerTheme(
                    data: SfPdfViewerThemeData(
                      backgroundColor: Colors.white,
                      progressBarColor: AppColors.primaryColor,
                    ),
                    child: viewer,
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // ===== BUTTON KÝ / THU HỒI =====
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:
          BlocBuilder<DocumentDetailCubit, DocumentDetailState>(
        builder: (context, st) {
          final isSigned = st.isSigned;

          return SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: FloatingActionButton.extended(
              heroTag: "sign_detail_$_docId",
              backgroundColor:
                  isSigned ? Colors.redAccent : AppColors.primaryColor,
              icon: Icon(
                isSigned ? Icons.cancel_outlined : Icons.edit,
                color: Colors.white,
              ),
              label: st.acting
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    )
                  : Text(
                      isSigned ? 'Thu hồi ký' : 'Thực hiện ký',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
              onPressed: st.acting
                  ? null
                  : () async {
                      final cubit = context.read<DocumentDetailCubit>();

                      if (!isSigned) {
                        // 🔵 SỬA – phải có roleCode đã chọn theo tài liệu
                        if (_roleCode == null) {
                          context.showSnackBarFail(
                            text: "Hãy chọn vai trò ký cho tài liệu này.",
                          );
                          return;
                        }

                        final ok = await cubit.sign(
                          userName: widget.userName,
                          roleCode: _roleCode!,
                          docId: _docId,
                        );

                        final msg = cubit.state.toast ??
                            (ok ? 'Ký thành công' : 'Ký thất bại');

                        if (ok && mounted) Navigator.pop(context, true);
                        if (ok) {
                          await context.showSnackBarSuccess(text: msg);
                        } else {
                          context.showSnackBarFail(text: msg);
                        }
                      } else {
                        final ok = await cubit.revoke(
                          userName: widget.userName,
                          docId: _docId,
                        );

                        final msg = cubit.state.toast ??
                            (ok ? 'Huỷ ký thành công' : 'Huỷ ký thất bại');

                        if (ok && mounted) Navigator.pop(context, true);
                        if (ok) {
                          await context.showSnackBarSuccess(text: msg);
                        } else {
                          context.showSnackBarFail(text: msg);
                        }
                      }
                    },
            ),
          );
        },
      ),
    );
  }
}
