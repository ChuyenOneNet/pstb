import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/repositories/dropdown_repository.dart';
import '../di/locator.dart';
import '../models/nationality_model.dart';

abstract class NationalityState {}

class NationalityInitial extends NationalityState {}

class NationalityLoading extends NationalityState {}

class NationalityLoaded extends NationalityState {
  final List<Nationality> list;

  NationalityLoaded(this.list);
}

class NationalityError extends NationalityState {
  final String message;

  NationalityError(this.message);
}

class NationalityCubit extends Cubit<NationalityState> {
  final repo = serviceLocator<DropdownRepository>();

  NationalityCubit() : super(NationalityInitial());

  Future<void> fetchNationalities(String filter) async {
    try {
      emit(NationalityLoading());
      final list = await repo.fetchNationalities(filter);
      print(list);
      // final allNationalities = [
      //   Nationality(id: 'vi', name: 'Việt Nam'),
      //   Nationality(id: 'us', name: 'Hoa Kỳ'),
      //   Nationality(id: 'jp', name: 'Nhật Bản'),
      //   Nationality(id: 'sk', name: 'Hàn Quốc'),
      // ];
      emit(NationalityLoaded(list));
    } catch (e) {
      emit(NationalityError(e.toString()));
    }
  }
}
