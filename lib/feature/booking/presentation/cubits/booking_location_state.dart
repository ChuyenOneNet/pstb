import 'package:equatable/equatable.dart';
import '../../data/models/location_item.dart';
import '../../data/models/picklist_cities_response.dart';
import '../../data/models/picklist_states_response.dart';

class BookingLocationState extends Equatable {
  final bool loadingCities;
  final bool loadingWards;
  final String? error;
  final List<MailingCityItem> cities;
  final List<MailingStateItem> wards;

  final String? selectedCityId;
  final String? selectedWardId;

  const BookingLocationState({
    this.loadingCities = false,
    this.loadingWards = false,
    this.error,
    this.cities = const [],
    this.wards = const [],
    this.selectedCityId,
    this.selectedWardId,
  });

  BookingLocationState copyWith({
    bool? loadingCities,
    bool? loadingWards,
    String? error,
    List<MailingCityItem>? cities,
    List<MailingStateItem>? wards,
    String? selectedCityId,
    String? selectedWardId,
    bool clearError = false,
  }) {
    return BookingLocationState(
      loadingCities: loadingCities ?? this.loadingCities,
      loadingWards: loadingWards ?? this.loadingWards,
      error: clearError ? null : (error ?? this.error),
      cities: cities ?? this.cities,
      wards: wards ?? this.wards,
      selectedCityId: selectedCityId ?? this.selectedCityId,
      selectedWardId: selectedWardId ?? this.selectedWardId,
    );
  }

  @override
  List<Object?> get props => [
        loadingCities,
        loadingWards,
        error,
        cities,
        wards,
        selectedCityId,
        selectedWardId,
      ];
}
