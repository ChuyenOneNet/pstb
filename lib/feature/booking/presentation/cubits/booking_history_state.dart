import 'package:equatable/equatable.dart';

import '../../domain/entities/history_entry.dart';

abstract class BookingHistoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class BookingHistoryInitial extends BookingHistoryState {}

class BookingHistoryLoading extends BookingHistoryState {}

class BookingHistoryLoaded extends BookingHistoryState {
  final List<HistoryEntry> list;
  BookingHistoryLoaded(this.list);
  @override
  List<Object?> get props => [list];
}

class BookingHistoryError extends BookingHistoryState {
  final String message;
  BookingHistoryError(this.message);
  @override
  List<Object?> get props => [message];
}
