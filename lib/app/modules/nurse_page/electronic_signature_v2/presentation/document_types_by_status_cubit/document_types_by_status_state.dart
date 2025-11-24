import 'package:equatable/equatable.dart';
import 'package:pstb/app/models/document_type_model.dart';

enum DocumentTypesByStatusStatus { initial, loading, success, failure }

class DocumentTypesCount {
  final TypeDocumentModel type;
  final int count;

  DocumentTypesCount({required this.type, required this.count});

  DocumentTypesCount copyWith({
    TypeDocumentModel? type,
    int? count,
  }) =>
      DocumentTypesCount(
        type: type ?? this.type,
        count: count ?? this.count,
      );
}

class DocumentTypesByStatusState extends Equatable {
  final DocumentTypesByStatusStatus status;
  final List<DocumentTypesCount> items;
  final String? error;

  const DocumentTypesByStatusState({
    this.status = DocumentTypesByStatusStatus.initial,
    this.items = const [],
    this.error,
  });

  DocumentTypesByStatusState copyWith({
    DocumentTypesByStatusStatus? status,
    List<DocumentTypesCount>? items,
    String? error,
  }) =>
      DocumentTypesByStatusState(
        status: status ?? this.status,
        items: items ?? this.items,
        error: error,
      );

  @override
  List<Object?> get props => [status, items, error];
}
