import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../data/filter_signature_model.dart';
import '../../data/repositories/signature_repository.dart';
import 'document_types_by_status_state.dart';

final _sl = GetIt.instance;

class DocumentTypesByStatusCubit extends Cubit<DocumentTypesByStatusState> {
  DocumentTypesByStatusCubit() : super(const DocumentTypesByStatusState());

  SignatureRepository get _repo => _sl<SignatureRepository>();

  /// Load document types with count filtered by signing status
  /// signingStatusCode: null = all, 0 = unsigned, 1 = signed
  Future<void> loadByStatus({
    required String userName,
    required int? signingStatusCode,
  }) async {
    emit(state.copyWith(status: DocumentTypesByStatusStatus.loading));

    try {
      // First, get all document types
      final allTypes = await _repo.getTypeDocuments();
      final typesList = allTypes.items ?? [];

      // For each type, get the count of documents with the given status
      final countsMap = <String, DocumentTypesCount>{};

      for (final type in typesList) {
        final filter = FilterSignatureModelV2(
          userName: userName,
          documentTypeCode: type.code,
          signingStatusCode: signingStatusCode,
          pageSize: 1,
        ).firstPage(size: 1);

        final result = await _repo.getDocumentsWithFilterV1(filter);
        final count = result.total ?? (result.items?.length ?? 0);

        if (count > 0) {
          countsMap[type.code ?? ''] = DocumentTypesCount(
            type: type,
            count: count,
          );
        }
      }

      // Sort by count descending
      final sortedItems = countsMap.values.toList()
        ..sort((a, b) => b.count.compareTo(a.count));

      emit(state.copyWith(
        status: DocumentTypesByStatusStatus.success,
        items: sortedItems,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: DocumentTypesByStatusStatus.failure,
        error: e.toString(),
      ));
    }
  }

  /// Refresh the list when status changes
  Future<void> refresh({
    required String userName,
    required int? signingStatusCode,
  }) async {
    await loadByStatus(
      userName: userName,
      signingStatusCode: signingStatusCode,
    );
  }
}
