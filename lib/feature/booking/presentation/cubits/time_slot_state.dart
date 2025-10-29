part of 'time_slot_cubit.dart';

abstract class TimeSlotState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TimeSlotInitial extends TimeSlotState {}

class TimeSlotLoading extends TimeSlotState {}

class TimeSlotLoaded extends TimeSlotState {
  final List<TimeSlot> list;
  TimeSlotLoaded(this.list);
  @override
  List<Object?> get props => [list];
}

class TimeSlotError extends TimeSlotState {
  final String message;
  TimeSlotError(this.message);
  @override
  List<Object?> get props => [message];
}
