import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/repositories/booking_repository.dart';
import '../../../../di/locator.dart';
import '../../domain/entities/time_slot.dart';
part 'time_slot_state.dart';

class TimeSlotCubit extends Cubit<TimeSlotState> {
  final repo = serviceLocator<BookingRepository>();
  TimeSlotCubit() : super(TimeSlotInitial());

  Future<void> fetchTimeSlots(Map<String, dynamic> body) async {
    emit(TimeSlotLoading());
    try {
      //final list = await repo.getTimeSlots(body);
      await Future.delayed(const Duration(milliseconds: 400));
      final day = DateTime(2025, 6, 11);
      final list = <TimeSlot>[
        // giả lập các slot: 08:00, 09:30, 10:30, 13:30, 15:00
        TimeSlot(
            id: 'S1',
            startAt: day.add(const Duration(hours: 8)).toString(),
            available: true),
        TimeSlot(
            id: 'S2',
            startAt: day.add(const Duration(hours: 9, minutes: 30)).toString(),
            available: true),
        TimeSlot(
            id: 'S3',
            startAt: day.add(const Duration(hours: 10, minutes: 30)).toString(),
            available: false),
        TimeSlot(
            id: 'S4',
            startAt: day.add(const Duration(hours: 13, minutes: 30)).toString(),
            available: true),
        TimeSlot(
            id: 'S5',
            startAt: day.add(const Duration(hours: 15)).toString(),
            available: true),
      ];
      emit(TimeSlotLoaded(list));
    } catch (e) {
      emit(TimeSlotError(e.toString()));
    }
  }
}
