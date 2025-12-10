import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/relative_model.dart';
import '../../domain/usecases/add_relative_usecase.dart';
import '../../domain/usecases/update_relative_usecase.dart';
import '../../domain/usecases/get_relative_detail_usecase.dart';

class RelativeFormState {
  final bool loading;
  final bool success;
  final RelativeModel? initial;
  final String? error;

  RelativeFormState({
    this.loading = false,
    this.success = false,
    this.initial,
    this.error,
  });

  RelativeFormState copyWith({
    bool? loading,
    bool? success,
    RelativeModel? initial,
    String? error,
  }) {
    return RelativeFormState(
      loading: loading ?? this.loading,
      success: success ?? this.success,
      initial: initial ?? this.initial,
      error: error,
    );
  }
}

class RelativeFormCubit extends Cubit<RelativeFormState> {
  final AddRelativeUseCase addRelativeUseCase;
  final UpdateRelativeUseCase updateRelativeUseCase;
  final GetRelativeDetailUseCase getDetailUseCase;

  RelativeFormCubit({
    required this.addRelativeUseCase,
    required this.updateRelativeUseCase,
    required this.getDetailUseCase,
  }) : super(RelativeFormState());

  Future<void> loadDetail(String mainCccd, int id) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      final detail = await getDetailUseCase(mainCccd, id);
      emit(state.copyWith(loading: false, initial: detail));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  Future<void> submitAdd(String mainCccd, RelativeModel model) async {
    emit(state.copyWith(loading: true, error: null, success: false));
    try {
      await addRelativeUseCase(mainCccd, model);
      emit(state.copyWith(loading: false, success: true));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  Future<void> submitUpdate(
      String mainCccd, int id, RelativeModel model) async {
    emit(state.copyWith(loading: true, error: null, success: false));
    try {
      await updateRelativeUseCase(mainCccd, id, model);
      emit(state.copyWith(loading: false, success: true));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }
}
