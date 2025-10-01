import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pstb/core/repositories/dropdown_repository.dart';
import '../di/locator.dart';
import '../models/address_model.dart';

abstract class CityState {}

class CityInitial extends CityState {}

class CityLoading extends CityState {}

class CityLoaded extends CityState {
  final List<Address> list;

  CityLoaded(this.list);
}

class CityError extends CityState {
  final String message;

  CityError(this.message);
}

class CityCubit extends Cubit<CityState> {
  final repo = serviceLocator<DropdownRepository>();

  CityCubit() : super(CityInitial());

  Future<void> fetchCity(Map<String, dynamic> body) async {
    emit(CityLoading());
    try {
      final list = await repo.getCity(body);
      print(list);
      // final allCityes = [
      //   City(id: '1', name: 'Quận Ba Đình, Hà Nội'),
      //   City(id: '2', name: 'Quận Hoàn Kiếm, Hà Nội'),
      //   City(id: '3', name: 'Quận 1, TP Hồ Chí Minh'),
      //   City(id: '4', name: 'Quận 3, TP Hồ Chí Minh'),
      // ];
      emit(CityLoaded(list));
    } catch (e) {
      emit(CityError(e.toString()));
    }
  }
}
