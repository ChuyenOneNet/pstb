import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/repositories/booking_repository.dart';
import '../../../../di/locator.dart';
import '../../data/models/booking_request.dart';
import '../../data/models/crm_booking_response.dart';
part 'booking_submit_state.dart';

class BookingSubmitCubit extends Cubit<BookingSubmitState> {
  final repo = serviceLocator<BookingRepository>();
  BookingSubmitCubit() : super(BookingSubmitInitial());

  Future<void> submit(BookingRequest body) async {
    emit(BookingSubmitting());
    try {
      final res = await repo.createBooking(body);
      emit(BookingSubmitSuccess(res)); // IDs sẽ parse ở UI hoặc từ repo nếu cần
    } catch (e) {
      print(e);
      emit(BookingSubmitError(e.toString()));
    }
  }
}
