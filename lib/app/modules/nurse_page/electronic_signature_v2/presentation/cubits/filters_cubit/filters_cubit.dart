// filters_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../../../../models/document_type_model.dart';
import '../../../data/filter_signature_model.dart';
import '../../../data/repositories/signature_repository.dart';
import '../../../data/signing_status.dart' show SigningStatus;
import 'filters_state.dart';

final _sl = GetIt.instance;

sealed class FiltersEvent {}

class LoadEvent extends FiltersEvent {
  final String userName;
  final String? keyword;
  final String? fromDate;
  final String? toDate;
  LoadEvent({
    required this.userName,
    this.keyword,
    this.fromDate,
    this.toDate,
  });
}

class LoadMoreEvent extends FiltersEvent {
  final String userName;
  final String? keyword;
  final String? fromDate;
  final String? toDate;
  LoadMoreEvent({
    required this.userName,
    this.keyword,
    this.fromDate,
    this.toDate,
  });
}

class FiltersCubit extends Bloc<FiltersEvent, FiltersState> {
  FiltersCubit() : super(const FiltersState()) {
    on<LoadEvent>(_onLoad);
    on<LoadMoreEvent>(_onLoadMore);
  }

  SignatureRepository get _repo => _sl<SignatureRepository>();
  static const int batchSize = 15;
  int _currentBatch = 0;
  bool _hasMore = true;

  Future<void> _onLoad(LoadEvent event, Emitter<FiltersState> emit) async {
    _currentBatch = 0;
    _hasMore = true;
    emit(state.copyWith(
      status: FiltersStatus.loading,
      docTypes: [],
      typeCounts: {},
      totalCounts: {'all': 0, 'unsigned': 0, 'signed': 0},
      lastFromDate: event.fromDate,
      lastToDate: event.toDate,
    ));
    await _loadMore(
      event.userName,
      keyword: event.keyword,
      fromDate: event.fromDate,
      toDate: event.toDate,
      emit: emit,
    );
  }

  Future<void> _onLoadMore(
      LoadMoreEvent event, Emitter<FiltersState> emit) async {
    if (!_hasMore || state.status == FiltersStatus.loadingMore) return;
    emit(state.copyWith(status: FiltersStatus.loadingMore));
    await _loadMore(
      event.userName,
      keyword: event.keyword,
      fromDate: event.fromDate,
      toDate: event.toDate,
      emit: emit,
    );
  }

  Future<void> _loadMore(
    String userName, {
    String? keyword,
    String? fromDate,
    String? toDate,
    required Emitter<FiltersState> emit,
  }) async {
    try {
      final typesResponse = await _repo.getTypeDocuments(keyword: keyword);
      final allDocTypes = typesResponse.items ?? [];
      if (allDocTypes.isEmpty) {
        _hasMore = false;
        emit(state.copyWith(status: FiltersStatus.success));
        return;
      }

      final start = _currentBatch * batchSize;
      final end = start + batchSize;
      final typesToCheck = allDocTypes.skip(start).take(batchSize).toList();
      if (typesToCheck.isEmpty) {
        _hasMore = false;
        emit(state.copyWith(status: FiltersStatus.success));
        return;
      }

      // DÙNG NGÀY TỪ EVENT HOẶC TỪ STATE
      final effectiveFromDate = fromDate ?? state.lastFromDate;
      final effectiveToDate = toDate ?? state.lastToDate;

      final filterBase = FilterSignatureModelV2(
        userName: userName,
        fromDate: effectiveFromDate,
        toDate: effectiveToDate,
      ).copyWith(pageSize: 1, pageIndex: 1);

      final totalFutures = _currentBatch == 0
          ? await Future.wait([
              _repo.getDocumentsWithFilterV1(filterBase),
              _repo.getDocumentsWithFilterV1(filterBase.copyWith(
                  signingStatusCode: SigningStatus.unsigned)),
              _repo.getDocumentsWithFilterV1(
                  filterBase.copyWith(signingStatusCode: SigningStatus.signed)),
            ])
          : [null, null, null];

      final allTotal = _currentBatch == 0
          ? (totalFutures[0]?.total ?? 0)
          : state.totalCounts['all']!;
      final unsignedTotal = _currentBatch == 0
          ? (totalFutures[1]?.total ?? 0)
          : state.totalCounts['unsigned']!;
      final signedTotal = _currentBatch == 0
          ? (totalFutures[2]?.total ?? 0)
          : state.totalCounts['signed']!;

      final Map<String, Map<String, int>> newTypeCounts = {};
      final List<TypeDocumentModel> newValidTypes = [];

      await Future.wait(typesToCheck.map((type) async {
        final code = type.code!;
        try {
          final results = await Future.wait([
            _repo.getDocumentsWithFilterV1(
                filterBase.copyWith(documentTypeCode: code)),
            _repo.getDocumentsWithFilterV1(filterBase.copyWith(
                documentTypeCode: code,
                signingStatusCode: SigningStatus.unsigned)),
            _repo.getDocumentsWithFilterV1(filterBase.copyWith(
                documentTypeCode: code,
                signingStatusCode: SigningStatus.signed)),
          ]);
          final allCount = results[0].total ?? 0;
          if (allCount > 0) {
            newTypeCounts[code] = {
              'all': allCount,
              'unsigned': results[1].total ?? 0,
              'signed': results[2].total ?? 0,
            };
            newValidTypes.add(type);
          }
        } catch (_) {}
      }));

      final updatedTypes = [...state.docTypes, ...newValidTypes];
      final updatedCounts = {...state.typeCounts}..addAll(newTypeCounts);

      _currentBatch++;
      _hasMore = end < allDocTypes.length;

      emit(state.copyWith(
        status: FiltersStatus.success,
        docTypes: updatedTypes,
        typeCounts: updatedCounts,
        totalCounts: {
          'all': allTotal,
          'unsigned': unsignedTotal,
          'signed': signedTotal,
        },
        lastFromDate: effectiveFromDate,
        lastToDate: effectiveToDate,
      ));

      if (_hasMore && _currentBatch < 5) {
        Future.delayed(const Duration(milliseconds: 300), () {
          add(LoadMoreEvent(
            userName: userName,
            keyword: keyword,
            fromDate: effectiveFromDate,
            toDate: effectiveToDate,
          ));
        });
      }
    } catch (e) {
      emit(state.copyWith(status: FiltersStatus.failure, error: e.toString()));
    }
  }
}
