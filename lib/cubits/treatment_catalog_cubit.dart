import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/repositories/dropdown_repository.dart';
import '../di/locator.dart';
import '../models/job_model.dart';
import '../models/treatment_catalog_department_model.dart';
import '../models/treatment_catalog_model.dart';

abstract class TreatmentCatalogState {}

class TreatmentCatalogInitial extends TreatmentCatalogState {}

class TreatmentCatalogLoading extends TreatmentCatalogState {}

class TreatmentCatalogLoaded extends TreatmentCatalogState {
  final List<TreatmentCatalogModel> list;

  TreatmentCatalogLoaded(this.list);
}

class TreatmentCatalogError extends TreatmentCatalogState {
  final String message;

  TreatmentCatalogError(this.message);
}

class TreatmentCatalogCubit extends Cubit<TreatmentCatalogState> {
  final repo = serviceLocator<DropdownRepository>();

  TreatmentCatalogCubit() : super(TreatmentCatalogInitial());

  Future<void> fetchTreatmentCatalogs() async {
    try {
      emit(TreatmentCatalogLoading());
      final list = await repo.fetchTreatmentCatalogs();
      print(list);
      emit(TreatmentCatalogLoaded(list));
    } catch (e) {
      emit(TreatmentCatalogError(e.toString()));
    }
  }
}
