part of 'lead_service_cubit.dart';

abstract class LeadServiceState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LeadServiceInitial extends LeadServiceState {}

class LeadServiceLoading extends LeadServiceState {}

class LeadServiceLoaded extends LeadServiceState {
  final List<LeadService> list;
  LeadServiceLoaded(this.list);
  @override
  List<Object?> get props => [list];
}

class LeadServiceError extends LeadServiceState {
  final String message;
  LeadServiceError(this.message);
  @override
  List<Object?> get props => [message];
}
