import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/relative_model.dart';
import '../../domain/usecases/get_relatives_usecase.dart';
import '../../domain/usecases/delete_relative_usecase.dart';

class RelativeListState {
  final bool loading;
  final List<RelativeModel> items;
  final String? error;

  RelativeListState({
    this.loading = false,
    this.items = const [],
    this.error,
  });

  RelativeListState copyWith({
    bool? loading,
    List<RelativeModel>? items,
    String? error,
  }) {
    return RelativeListState(
      loading: loading ?? this.loading,
      items: items ?? this.items,
      error: error,
    );
  }
}

class RelativeListCubit extends BlocBase<RelativeListState> {
  final GetRelativesUseCase getRelativesUseCase;
  final DeleteRelativeUseCase deleteRelativeUseCase;

  RelativeListCubit({
    required this.getRelativesUseCase,
    required this.deleteRelativeUseCase,
  }) : super(RelativeListState());

  Future<void> load(String mainCccd) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      final list = await getRelativesUseCase(mainCccd);
      emit(state.copyWith(loading: false, items: list));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  Future<void> delete(String mainCccd, int id) async {
    try {
      await deleteRelativeUseCase(mainCccd, id);
      final updated = state.items.where((e) => e.id != id).toList();
      emit(state.copyWith(items: updated));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }
}
