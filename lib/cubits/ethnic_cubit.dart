import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/repositories/dropdown_repository.dart';
import '../di/locator.dart';
import '../models/ethnic_model.dart';
import '../models/job_model.dart';

abstract class EthnicState {}

class EthnicInitial extends EthnicState {}

class EthnicLoading extends EthnicState {}

class EthnicLoaded extends EthnicState {
  final List<Ethnic> list;

  EthnicLoaded(this.list);
}

class EthnicError extends EthnicState {
  final String message;

  EthnicError(this.message);
}

class EthnicCubit extends Cubit<EthnicState> {
  final repo = serviceLocator<DropdownRepository>();

  EthnicCubit() : super(EthnicInitial());

  Future<void> fetchEthnics(String filter) async {
    try {
      emit(EthnicLoading());
      final list = await repo.fetchEthnics(filter);
      print(list);
      // final allEthnics = [
      //   Ethnic(id: '1', name: 'Kinh'),
      //   Ethnic(id: '2', name: 'Tày'),
      //   Ethnic(id: '3', name: 'Thái'),
      //   Ethnic(id: '4', name: 'Mường'),
      // ];
      emit(EthnicLoaded(list));
    } catch (e) {
      emit(EthnicError(e.toString()));
    }
  }
}
