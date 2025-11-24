// patients_state.dart  (CẬP NHẬT)
import 'package:equatable/equatable.dart';
import 'package:pstb/app/models/patient_model.dart';

enum PatientsStatus { idle, loading, success, failure, loadingMore }

class PatientsState extends Equatable {
  final PatientsStatus status;
  final List<PatientModel> items;
  final String keyword;
  final int page; // pageIndex hiện tại
  final bool hasMore; // còn trang sau không
  final String? error;

  const PatientsState({
    this.status = PatientsStatus.idle,
    this.items = const [],
    this.keyword = '',
    this.page = 0,
    this.hasMore = false,
    this.error,
  });

  PatientsState copyWith({
    PatientsStatus? status,
    List<PatientModel>? items,
    String? keyword,
    int? page,
    bool? hasMore,
    String? error,
  }) {
    return PatientsState(
      status: status ?? this.status,
      items: items ?? this.items,
      keyword: keyword ?? this.keyword,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, items, keyword, page, hasMore, error];
}
