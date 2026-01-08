import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../data/filter_signature_model.dart';
import '../../../data/repositories/signature_repository.dart';
import '../../../data/signing_status.dart';
import 'documents_state.dart';
import 'package:pstb/app/models/paging_model.dart';
import 'package:pstb/app/models/electronic_signature_model.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pstb/app/models/electronic_signature_model.dart';
import 'package:pstb/app/models/filter_signature_model.dart';

import 'package:pstb/app/models/paging_model.dart';

final _sl = GetIt.instance;

class DocumentsCubit extends Cubit<DocumentsState> {
  DocumentsCubit() : super(const DocumentsState());

  SignatureRepository get _repo => _sl<SignatureRepository>();

  FilterSignatureModelV2? _currentFilter;
  bool _loadingMore = false;

  int _allTotalCache = 0; // NEW: giữ tổng "Tất cả" ổn định

  // Tải lại API khi cần thiết (tránh gọi lại khi cache đã có)
  Future<void> refreshWithFilter(
    FilterSignatureModelV2 filter, {
    bool withCounts = false,
  }) async {
    if (_currentFilter != null && _currentFilter == filter) {
      // Dữ liệu đã có trong cache, không tải lại
      return;
    }

    _currentFilter = filter.firstPage(size: filter.pageSize ?? 10);
    emit(state.copyWith(status: DocLoadStatus.loading, items: [], page: 0));

    try {
      final res = await _repo.getDocumentsWithFilterV1(_currentFilter!);
      Map<String, int>? counts;
      if (withCounts) {
        counts = await _getCounts(base: _currentFilter!);
        _allTotalCache = (counts['unsigned'] ?? 0) + (counts['signed'] ?? 0);
      }

      emit(state.copyWith(
        status: DocLoadStatus.success,
        items: res.items ?? const <DocumentModel>[],
        total: _allTotalCache > 0 ? _allTotalCache : (res.total ?? 0), // NEW
        page: _currentFilter!.pageIndex ?? 0,
        hasMore: !(res.isEnded()),
        countsByStatus: counts ?? state.countsByStatus,
      ));
    } catch (e) {
      emit(state.copyWith(status: DocLoadStatus.failure, error: e.toString()));
    }
  }

  // Khi load thêm, chỉ tải khi có thêm dữ liệu
  Future<void> loadMore() async {
    if (_loadingMore) return;
    if (!(state.hasMore ?? false)) return;
    if (_currentFilter == null) return;

    _loadingMore = true;
    try {
      _currentFilter = _currentFilter!.nextPage();
      final res = await _repo.getDocumentsWithFilterV1(_currentFilter!);

      final merged = <DocumentModel>[
        ...state.items,
        ...(res.items ?? const []),
      ];

      emit(state.copyWith(
        items: merged,
        total: _allTotalCache > 0 ? _allTotalCache : (res.total ?? state.total),
        page: _currentFilter!.pageIndex ?? (state.page ?? 0) + 1,
        hasMore: !(res.isEnded()),
        status: DocLoadStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(status: DocLoadStatus.failure, error: e.toString()));
    } finally {
      _loadingMore = false;
    }
  }

  // Helper: lấy count nhanh cho các loại trạng thái
  Future<Map<String, int>> _getCounts(
      {required FilterSignatureModelV2 base}) async {
    Future<int> _count(int code) async {
      final f = base
          .copyWith(signingStatusCode: code, pageIndex: 0, pageSize: 1)
          .firstPage(size: 1);
      final r = await _repo.getDocumentsWithFilterV1(f);
      return r.total ?? (r.items?.length ?? 0);
    }

    final unsigned = await _count(SigningStatus.unsigned);
    final signed = await _count(SigningStatus.signed);
    return {'unsigned': unsigned, 'signed': signed};
  }
}

//
// final _sl = GetIt.instance;
//
// class DocumentsCubit extends Cubit<DocumentsState> {
//   DocumentsCubit() : super(const DocumentsState());
//
//   SignatureRepository get _repo => _sl<SignatureRepository>();
//
//   FilterSignatureModelV2? _currentFilter;
//   bool _loadingMore = false;
//
//   int _allTotalCache = 0; // NEW: giữ tổng "Tất cả" ổn định
//
//   Future<void> refreshWithFilter(
//     FilterSignatureModelV2 filter, {
//     bool withCounts = false,
//   }) async {
//     _currentFilter = filter.firstPage(size: filter.pageSize ?? 10);
//     emit(state.copyWith(status: DocLoadStatus.loading, items: [], page: 0));
//
//     try {
//       final res = await _repo.getDocumentsWithFilterV1(_currentFilter!);
//       Map<String, int>? counts;
//       if (withCounts) {
//         counts = await _getCounts(base: _currentFilter!);
//         _allTotalCache = (counts['unsigned'] ?? 0) + (counts['signed'] ?? 0);
//       }
//
//       emit(state.copyWith(
//         status: DocLoadStatus.success,
//         items: res.items ?? const <DocumentModel>[],
//         total: _allTotalCache > 0 ? _allTotalCache : (res.total ?? 0), // NEW
//         page: _currentFilter!.pageIndex ?? 0,
//         hasMore: !(res.isEnded()),
//         countsByStatus: counts ?? state.countsByStatus,
//       ));
//     } catch (e) {
//       emit(state.copyWith(status: DocLoadStatus.failure, error: e.toString()));
//     }
//   }
//
//   Future<void> loadMore() async {
//     if (_loadingMore) return;
//     if (!(state.hasMore ?? false)) return;
//     if (_currentFilter == null) return;
//
//     _loadingMore = true;
//     try {
//       _currentFilter = _currentFilter!.nextPage();
//       final res = await _repo.getDocumentsWithFilterV1(_currentFilter!);
//
//       final merged = <DocumentModel>[
//         ...state.items,
//         ...(res.items ?? const []),
//       ];
//
//       emit(state.copyWith(
//         items: merged,
//         total: _allTotalCache > 0 ? _allTotalCache : (res.total ?? state.total),
//         page: _currentFilter!.pageIndex ?? (state.page ?? 0) + 1,
//         hasMore: !(res.isEnded()),
//         status: DocLoadStatus.success,
//       ));
//     } catch (e) {
//       emit(state.copyWith(status: DocLoadStatus.failure, error: e.toString()));
//     } finally {
//       _loadingMore = false;
//     }
//   }
//
//   Future<Map<String, int>> _getCounts(
//       {required FilterSignatureModelV2 base}) async {
//     // Helper: clone base + override signingStatusCode + chốt page nhỏ để lấy total nhanh
//     Future<int> _count(int code) async {
//       final f = base
//           .copyWith(signingStatusCode: code, pageIndex: 0, pageSize: 1)
//           .firstPage(size: 1);
//       final r = await _repo.getDocumentsWithFilterV1(f);
//       return r.total ?? (r.items?.length ?? 0);
//     }
//
//     final unsigned = await _count(SigningStatus.unsigned);
//     final signed = await _count(SigningStatus.signed);
//     return {'unsigned': unsigned, 'signed': signed};
//   }
// }
