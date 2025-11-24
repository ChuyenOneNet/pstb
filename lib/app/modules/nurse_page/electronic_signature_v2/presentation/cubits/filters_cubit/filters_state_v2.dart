// lib/app/modules/nurse_page/electronic_signature_v2/presentation/cubits/filters_cubit/filters_state_v2.dart

import 'package:pstb/app/models/document_type_model.dart';

class FiltersStateV2 {
  final bool isLoading;
  final bool hasError;
  final Map<String?, Map<TypeDocumentModel, int>> groupedDocuments;
  final Map<String, int> totalCounts;

  // MỚI: Cache toàn bộ documents theo type + status
  final Map<String, Map<String?, List<dynamic>>> documentsByTypeAndStatus;

  const FiltersStateV2({
    this.isLoading = false,
    this.hasError = false,
    this.groupedDocuments = const {},
    this.totalCounts = const {'all': 0, 'unsigned': 0, 'signed': 0},
    this.documentsByTypeAndStatus = const {},
  });

  FiltersStateV2 copyWith({
    bool? isLoading,
    bool? hasError,
    Map<String?, Map<TypeDocumentModel, int>>? groupedDocuments,
    Map<String, int>? totalCounts,
    Map<String, Map<String?, List<dynamic>>>? documentsByTypeAndStatus,
  }) {
    return FiltersStateV2(
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      groupedDocuments: groupedDocuments ?? this.groupedDocuments,
      totalCounts: totalCounts ?? this.totalCounts,
      documentsByTypeAndStatus:
          documentsByTypeAndStatus ?? this.documentsByTypeAndStatus,
    );
  }
}
