// cubits/departments_cubit/departments_state.dart
part of 'departments_cubit.dart';

enum DepartmentsStatus { initial, loading, success, failure }

class DepartmentsState {
  final DepartmentsStatus status;
  final String? error;
  final List<DepartmentModel> departments;

  const DepartmentsState({
    this.status = DepartmentsStatus.initial,
    this.error,
    this.departments = const [],
  });

  DepartmentsState copyWith({
    DepartmentsStatus? status,
    String? error,
    List<DepartmentModel>? departments,
  }) {
    return DepartmentsState(
      status: status ?? this.status,
      error: error,
      departments: departments ?? this.departments,
    );
  }
}
