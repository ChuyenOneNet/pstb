import 'package:equatable/equatable.dart';
import 'package:pstb/app/models/electronic_signature_model.dart';

import 'package:equatable/equatable.dart';
import 'package:pstb/app/models/filter_signature_model.dart';
import 'package:pstb/app/models/sign_roles_model.dart';

enum DocLoadStatus { initial, loading, success, failure }

class DocumentFilters {
  final String? searchText;
  final String? status; // pending/signed/revoked (map BE nếu có)
  final String? docTypeCode;
  final String? departmentCode;
  final String? patientCode;
  final DateTime? fromDate;
  final DateTime? toDate;

  const DocumentFilters({
    this.searchText,
    this.status,
    this.docTypeCode,
    this.departmentCode,
    this.patientCode,
    this.fromDate,
    this.toDate,
  });

  DocumentFilters copyWith({
    String? searchText,
    String? status,
    String? docTypeCode,
    String? departmentCode,
    String? patientCode,
    DateTime? fromDate,
    DateTime? toDate,
  }) =>
      DocumentFilters(
        searchText: searchText ?? this.searchText,
        status: status ?? this.status,
        docTypeCode: docTypeCode ?? this.docTypeCode,
        departmentCode: departmentCode ?? this.departmentCode,
        patientCode: patientCode ?? this.patientCode,
        fromDate: fromDate ?? this.fromDate,
        toDate: toDate ?? this.toDate,
      );
}

class DocumentsState extends Equatable {
  final DocLoadStatus status;
  final List<DocumentModel> items;
  final int page;
  final int total;
  final bool hasMore;
  final DocumentFilters filters;
  final Map<String, int>
      countsByStatus; // {'pending':x, 'signed':y, 'revoked':z}
  final String? error;

  const DocumentsState({
    this.status = DocLoadStatus.initial,
    this.items = const [],
    this.page = 0,
    this.total = 0,
    this.hasMore = true,
    this.filters = const DocumentFilters(),
    this.countsByStatus = const {},
    this.error,
  });

  DocumentsState copyWith({
    DocLoadStatus? status,
    List<DocumentModel>? items,
    int? page,
    int? total,
    bool? hasMore,
    DocumentFilters? filters,
    Map<String, int>? countsByStatus,
    String? error,
  }) =>
      DocumentsState(
        status: status ?? this.status,
        items: items ?? this.items,
        page: page ?? this.page,
        total: total ?? this.total,
        hasMore: hasMore ?? this.hasMore,
        filters: filters ?? this.filters,
        countsByStatus: countsByStatus ?? this.countsByStatus,
        error: error,
      );

  @override
  List<Object?> get props =>
      [status, items, page, total, hasMore, filters, countsByStatus, error];
}

//
// enum DocLoadStatus { initial, loading, success, failure }
//
// class DocumentFilters {
//   final String? searchText;
//   final String? status; // pending/signed/revoked (map BE nếu có)
//   final String? docTypeCode;
//   final String? departmentCode;
//   final String? patientCode;
//   final DateTime? fromDate;
//   final DateTime? toDate;
//
//   const DocumentFilters({
//     this.searchText,
//     this.status,
//     this.docTypeCode,
//     this.departmentCode,
//     this.patientCode,
//     this.fromDate,
//     this.toDate,
//   });
//
//   DocumentFilters copyWith({
//     String? searchText,
//     String? status,
//     String? docTypeCode,
//     String? departmentCode,
//     String? patientCode,
//     DateTime? fromDate,
//     DateTime? toDate,
//   }) =>
//       DocumentFilters(
//         searchText: searchText ?? this.searchText,
//         status: status ?? this.status,
//         docTypeCode: docTypeCode ?? this.docTypeCode,
//         departmentCode: departmentCode ?? this.departmentCode,
//         patientCode: patientCode ?? this.patientCode,
//         fromDate: fromDate ?? this.fromDate,
//         toDate: toDate ?? this.toDate,
//       );
// }
//
// class DocumentsState extends Equatable {
//   final DocLoadStatus status;
//   final List<DocumentModel> items;
//   final int page;
//   final int total;
//   final bool hasMore;
//   final DocumentFilters filters;
//   final Map<String, int>
//       countsByStatus; // {'pending':x, 'signed':y, 'revoked':z}
//   final String? error;
//
//   const DocumentsState({
//     this.status = DocLoadStatus.initial,
//     this.items = const [],
//     this.page = 0,
//     this.total = 0,
//     this.hasMore = true,
//     this.filters = const DocumentFilters(),
//     this.countsByStatus = const {},
//     this.error,
//   });
//
//   DocumentsState copyWith({
//     DocLoadStatus? status,
//     List<DocumentModel>? items,
//     int? page,
//     int? total,
//     bool? hasMore,
//     DocumentFilters? filters,
//     Map<String, int>? countsByStatus,
//     String? error,
//   }) =>
//       DocumentsState(
//         status: status ?? this.status,
//         items: items ?? this.items,
//         page: page ?? this.page,
//         total: total ?? this.total,
//         hasMore: hasMore ?? this.hasMore,
//         filters: filters ?? this.filters,
//         countsByStatus: countsByStatus ?? this.countsByStatus,
//         error: error,
//       );
//
//   @override
//   List<Object?> get props =>
//       [status, items, page, total, hasMore, filters, countsByStatus, error];
// }
