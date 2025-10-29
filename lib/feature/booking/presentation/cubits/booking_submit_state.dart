part of 'booking_submit_cubit.dart';

abstract class BookingSubmitState extends Equatable {
  @override
  List<Object?> get props => [];
}

class BookingSubmitInitial extends BookingSubmitState {}

class BookingSubmitting extends BookingSubmitState {}

class BookingSubmitSuccess extends BookingSubmitState {
  final CrmBookingResponse response;
  BookingSubmitSuccess(this.response);
  @override
  List<Object?> get props => [response];
}

class BookingSubmitError extends BookingSubmitState {
  final String message;
  BookingSubmitError(this.message);
  @override
  List<Object?> get props => [message];
}
