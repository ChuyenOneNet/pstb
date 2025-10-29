import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/repositories/booking_repository.dart';
import '../../../../di/locator.dart';
import '../../domain/entities/lead_service.dart';
part 'lead_service_state.dart';

class LeadServiceCubit extends Cubit<LeadServiceState> {
  final repo = serviceLocator<BookingRepository>();
  LeadServiceCubit() : super(LeadServiceInitial());

  Future<void> fetchLeadServices(Map<String, dynamic> body) async {
    emit(LeadServiceLoading());
    try {
      //final list = await repo.getLeadServices(body);
      await Future.delayed(const Duration(milliseconds: 400));
      final list = <LeadService>[
        LeadService(code: 'GEN_CHECK', name: 'Khám tổng quát'),
        LeadService(code: 'DENTAL', name: 'Nha khoa tổng quát'),
        LeadService(code: 'PED', name: 'Khám nhi'),
        LeadService(code: 'CARD', name: 'Tim mạch'),
        LeadService(code: 'ENT', name: 'Tai Mũi Họng'),
      ];
      emit(LeadServiceLoaded(list));
    } catch (e) {
      emit(LeadServiceError(e.toString()));
    }
  }
}
