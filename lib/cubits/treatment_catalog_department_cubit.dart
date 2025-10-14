import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/repositories/dropdown_repository.dart';
import '../di/locator.dart';
import '../models/job_model.dart';
import '../models/treatment_catalog_department_model.dart';
import '../models/treatment_catalog_model.dart';

abstract class TreatmentCatalogDepartmentState {}

class TreatmentCatalogDepartmentInitial
    extends TreatmentCatalogDepartmentState {}

class TreatmentCatalogDepartmentLoading
    extends TreatmentCatalogDepartmentState {}

class TreatmentCatalogDepartmentLoaded extends TreatmentCatalogDepartmentState {
  final List<TreatmentCatalogDepartmentModel> list;

  TreatmentCatalogDepartmentLoaded(this.list);
}

class TreatmentCatalogDepartmentError extends TreatmentCatalogDepartmentState {
  final String message;

  TreatmentCatalogDepartmentError(this.message);
}

class TreatmentCatalogDepartmentCubit
    extends Cubit<TreatmentCatalogDepartmentState> {
  final repo = serviceLocator<DropdownRepository>();

  TreatmentCatalogDepartmentCubit()
      : super(TreatmentCatalogDepartmentInitial());

  Future<void> fetchTreatmentCatalogDepartments(
      String treatmentCatalogId) async {
    try {
      emit(TreatmentCatalogDepartmentLoading());
      final list =
          await repo.fetchTreatmentCatalogDepartments(treatmentCatalogId);
      print(list);
      emit(TreatmentCatalogDepartmentLoaded(list));
    } catch (e) {
      emit(TreatmentCatalogDepartmentError(e.toString()));
    }
  }
}
