// patients_cubit.dart  (CẬP NHẬT)
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../data/repositories/signature_repository.dart';
import 'patients_state.dart';

final _sl = GetIt.instance;

class PatientsCubit extends Cubit<PatientsState> {
  PatientsCubit() : super(const PatientsState());

  SignatureRepository get _repo => _sl<SignatureRepository>();
  static const int _pageSize = 20;

  Timer? _debounce;

  // Gọi khi người dùng gõ ô tìm kiếm trong sheet (debounce sẵn)
  void searchDebounced(String keyword) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 280), () {
      search(keyword);
    });
  }

  Future<void> search(String keyword) async {
    final kw = keyword.trim();
    // API bắt keyword -> nếu <2 ký tự thì clear, chờ gõ tiếp
    if (kw.length < 2) {
      emit(state.copyWith(
        status: PatientsStatus.idle,
        items: const [],
        keyword: kw,
        page: 0,
        hasMore: false,
        error: null,
      ));
      return;
    }

    emit(state.copyWith(
      status: PatientsStatus.loading,
      items: const [],
      keyword: kw,
      page: 0,
      hasMore: true,
      error: null,
    ));

    try {
      final page0 = await _repo.getPatients(keyword: kw, pageIndex: 0);
      final items = page0.items ?? [];
      // Heuristic hasMore: nếu trả đủ pageSize thì còn trang sau
      final hasMore = (items.length >= (_pageSize));
      emit(state.copyWith(
        status: PatientsStatus.success,
        items: items,
        page: 0,
        hasMore: hasMore,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: PatientsStatus.failure,
        error: e.toString(),
        items: const [],
        page: 0,
        hasMore: false,
      ));
    }
  }

  Future<void> loadMore() async {
    if (!state.hasMore || state.status == PatientsStatus.loadingMore) return;

    emit(state.copyWith(status: PatientsStatus.loadingMore));
    final next = state.page + 1;

    try {
      final res =
          await _repo.getPatients(keyword: state.keyword, pageIndex: next);
      final more = res.items ?? [];
      final merged = [...state.items, ...more];
      final hasMore = (more.length >= _pageSize);

      emit(state.copyWith(
        status: PatientsStatus.success,
        items: merged,
        page: next,
        hasMore: hasMore,
      ));
    } catch (e) {
      // giữ list cũ, chỉ báo lỗi nhẹ
      emit(state.copyWith(
        status: PatientsStatus.success, // quay về success để không khóa UI
        error: e.toString(),
      ));
    }
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
