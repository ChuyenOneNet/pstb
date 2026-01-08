// cubits/departments_cubit/departments_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../../../models/department_model.dart';
import '../../../data/repositories/signature_repository.dart';

part 'departments_state.dart';

class DepartmentsCubit extends Cubit<DepartmentsState> {
  DepartmentsCubit() : super(const DepartmentsState());

  final _repo = GetIt.I<SignatureRepository>();

  Future<void> load({String? keyword}) async {
    if (state.status == DepartmentsStatus.loading) return;
    emit(state.copyWith(status: DepartmentsStatus.loading));

    try {
      final response = await _repo.getDepartments(keyword: keyword);
      emit(state.copyWith(
        status: DepartmentsStatus.success,
        departments: response.items ?? [],
      ));
    } catch (e) {
      emit(state.copyWith(
        status: DepartmentsStatus.failure,
        error: e.toString(),
      ));
    }
  }
}
