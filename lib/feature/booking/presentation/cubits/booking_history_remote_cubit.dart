// feature/booking/presentation/cubits/booking_history_remote_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/repositories/booking_repository.dart';
import '../../../../di/locator.dart';
import 'booking_history_remote_state.dart';

class BookingHistoryRemoteCubit extends Cubit<BookingHistoryRemoteState> {
  final BookingRepository repo = serviceLocator<BookingRepository>();

  DateTime? _currentFrom;
  DateTime? _currentTo;

  BookingHistoryRemoteCubit() : super(BookingHistoryRemoteInitial());

  Future<void> load({
    DateTime? from,
    DateTime? to,
    int offset = 0,
    int maxRows = 20,
  }) async {
    emit(BookingHistoryRemoteLoading());
    try {
      final now = DateTime.now();
      final f = from ?? _currentFrom ?? now.subtract(const Duration(days: 30));
      final t = to ?? _currentTo ?? now.add(const Duration(days: 30));

      _currentFrom = f;
      _currentTo = t;

      final items = await repo.getHistoryRemote(
        from: f,
        to: t,
        offset: offset,
        maxRows: maxRows,
      );

      emit(BookingHistoryRemoteLoaded(
        list: items,
        offset: offset,
        canLoadMore: items.length == maxRows,
      ));
    } catch (_) {
      emit(BookingHistoryRemoteError("Có lỗi xảy ra"));
    }
  }

  void refresh() => load(from: _currentFrom, to: _currentTo);
}
