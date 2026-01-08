// feature/booking/presentation/cubits/booking_history_remote_state.dart

import '../../data/models/crm_booking_item.dart';

abstract class BookingHistoryRemoteState {}

class BookingHistoryRemoteInitial extends BookingHistoryRemoteState {}

class BookingHistoryRemoteLoading extends BookingHistoryRemoteState {}

class BookingHistoryRemoteLoaded extends BookingHistoryRemoteState {
  final List<CrmBookingItem> list;
  final int offset;
  final bool canLoadMore;

  BookingHistoryRemoteLoaded({
    required this.list,
    required this.offset,
    required this.canLoadMore,
  });
}

class BookingHistoryRemoteError extends BookingHistoryRemoteState {
  final String message;
  BookingHistoryRemoteError(this.message);
}
