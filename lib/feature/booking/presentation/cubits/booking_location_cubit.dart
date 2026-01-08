import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pstb/di/locator.dart';

import '../../../../core/repositories/booking_repository.dart';
import 'booking_location_state.dart';

class BookingLocationCubit extends Cubit<BookingLocationState> {
  final BookingRepository repo = serviceLocator<BookingRepository>();

  BookingLocationCubit() : super(const BookingLocationState());

  Future<void> loadCities() async {
    emit(state.copyWith(loadingCities: true, clearError: true));
    try {
      final cities = await repo.getCities();
      emit(state.copyWith(loadingCities: false, cities: cities));
    } catch (e) {
      emit(state.copyWith(
        loadingCities: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> selectCity(String? cityId) async {
    // reset ward khi đổi city
    emit(state.copyWith(
      selectedCityId: cityId,
      selectedWardId: null,
      wards: const [],
      clearError: true,
    ));

    if (cityId == null || cityId.isEmpty) return;

    await loadWards(cityId);
  }

  Future<void> loadWards(String cityId) async {
    emit(state.copyWith(loadingWards: true, clearError: true));
    try {
      final wards = await repo.getWardsByCity(cityId);
      emit(state.copyWith(loadingWards: false, wards: wards));
    } catch (e) {
      emit(state.copyWith(
        loadingWards: false,
        error: e.toString(),
      ));
    }
  }

  void selectWard(String? wardId) {
    emit(state.copyWith(selectedWardId: wardId, clearError: true));
  }
}
