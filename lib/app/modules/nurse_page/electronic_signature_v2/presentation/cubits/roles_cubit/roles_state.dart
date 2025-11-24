// // lib/app/modules/nurse_page/electronic_signature_v2/presentation/cubits/roles_cubit/roles_state.dart
// import 'package:equatable/equatable.dart';
// import 'package:pstb/app/models/sign_roles_model.dart';
//
// class RolesState extends Equatable {
//   final bool loading;
//   final List<SignRolesModel> roles;
//   final String? error;
//
//   /// Thời điểm lần cuối load (cache hoặc network)
//   final DateTime? lastLoadedAt;
//
//   /// True nếu dữ liệu phát ra lần này lấy từ cache
//   final bool fromCache;
//
//   const RolesState({
//     this.loading = false,
//     this.roles = const [],
//     this.error,
//     this.lastLoadedAt,
//     this.fromCache = false,
//   });
//
//   RolesState copyWith({
//     bool? loading,
//     List<SignRolesModel>? roles,
//     String? error,
//     DateTime? lastLoadedAt,
//     bool? fromCache,
//     bool clearError = false,
//   }) {
//     return RolesState(
//       loading: loading ?? this.loading,
//       roles: roles ?? this.roles,
//       error: clearError ? null : (error ?? this.error),
//       lastLoadedAt: lastLoadedAt ?? this.lastLoadedAt,
//       fromCache: fromCache ?? this.fromCache,
//     );
//   }
//
//   @override
//   List<Object?> get props => [loading, roles, error, lastLoadedAt, fromCache];
// }
// lib/app/modules/nurse_page/electronic_signature_v2/presentation/cubits/roles_cubit/roles_state.dart
// lib/app/modules/nurse_page/electronic_signature_v2/presentation/cubits/roles_cubit/roles_state.dart
import 'package:equatable/equatable.dart';
import 'package:pstb/app/models/sign_roles_model.dart';

enum RolesStatus { initial, loading, success, failure }

class RolesState extends Equatable {
  final RolesStatus status;
  final List<SignRolesModel> roles;
  final String? error;

  /// Thời điểm lần cuối load (cache hoặc network)
  final DateTime? lastLoadedAt;

  /// True nếu dữ liệu phát ra lần này lấy từ cache
  final bool fromCache;

  const RolesState({
    this.status = RolesStatus.initial,
    this.roles = const [],
    this.error,
    this.lastLoadedAt,
    this.fromCache = false,
  });

  RolesState copyWith({
    RolesStatus? status,
    List<SignRolesModel>? roles,
    String? error,
    DateTime? lastLoadedAt,
    bool? fromCache,
    bool clearError = false,
  }) {
    return RolesState(
      status: status ?? this.status,
      roles: roles ?? this.roles,
      error: clearError ? null : (error ?? this.error),
      lastLoadedAt: lastLoadedAt ?? this.lastLoadedAt,
      fromCache: fromCache ?? this.fromCache,
    );
  }

  @override
  List<Object?> get props => [status, roles, error, lastLoadedAt, fromCache];
}
