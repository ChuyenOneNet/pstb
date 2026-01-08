// filters_state.dart
import 'package:equatable/equatable.dart';
import 'package:pstb/app/models/department_model.dart';
import 'package:pstb/app/models/document_type_model.dart';

enum FiltersStatus { initial, loading, loadingMore, success, failure }

class FiltersState extends Equatable {
  final FiltersStatus status;
  final String? error;
  final List<DepartmentModel> departments;
  final List<TypeDocumentModel> docTypes;
  final Map<String, int> totalCounts;
  final Map<String, Map<String, int>> typeCounts;
  final String? lastFromDate;
  final String? lastToDate;

  const FiltersState({
    this.status = FiltersStatus.initial,
    this.error,
    this.departments = const [],
    this.docTypes = const [],
    this.totalCounts = const {'all': 0, 'unsigned': 0, 'signed': 0},
    this.typeCounts = const {},
    this.lastFromDate,
    this.lastToDate,
  });

  FiltersState copyWith({
    FiltersStatus? status,
    String? error,
    List<DepartmentModel>? departments,
    List<TypeDocumentModel>? docTypes,
    Map<String, int>? totalCounts,
    Map<String, Map<String, int>>? typeCounts,
    String? lastFromDate,
    String? lastToDate,
  }) {
    return FiltersState(
      status: status ?? this.status,
      error: error ?? this.error,
      departments: departments ?? this.departments,
      docTypes: docTypes ?? this.docTypes,
      totalCounts: totalCounts ?? this.totalCounts,
      typeCounts: typeCounts ?? this.typeCounts,
      lastFromDate: lastFromDate ?? this.lastFromDate,
      lastToDate: lastToDate ?? this.lastToDate,
    );
  }

  @override
  List<Object?> get props => [
        status,
        error,
        departments,
        docTypes,
        totalCounts,
        typeCounts,
        lastFromDate,
        lastToDate,
      ];
}
