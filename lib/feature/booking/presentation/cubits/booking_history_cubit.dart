// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../core/repositories/booking_repository.dart';
// import '../../../../di/locator.dart';
// import 'booking_history_state.dart';
//
// class BookingHistoryCubit extends Cubit<BookingHistoryState> {
//   final repo = serviceLocator<BookingRepository>();
//   BookingHistoryCubit() : super(BookingHistoryInitial());
//
//   Future<void> load() async {
//     emit(BookingHistoryLoading());
//     try {
//       final list = await repo.getHistory();
//       emit(BookingHistoryLoaded(list));
//     } catch (e) {
//       emit(BookingHistoryError(e.toString()));
//     }
//   }
// }
