// // lib/app/modules/nurse_page/electronic_signature_v2/presentation/cubits/roles_cubit/roles_cubit.dart
// import 'dart:collection';
//
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_it/get_it.dart';
// import 'package:pstb/app/models/sign_roles_model.dart';
//
// import '../../../data/repositories/signature_repository.dart';
// import 'roles_state.dart';
//
// final _sl = GetIt.instance;
//
// /// Cache entry kèm timestamp để kiểm TTL
// class _CacheEntry<T> {
//   final T data;
//   final DateTime at;
//   const _CacheEntry(this.data, this.at);
// }
//
// class RolesCubit extends Cubit<RolesState> {
//   RolesCubit() : super(const RolesState());
//
//   SignatureRepository get _repo => _sl<SignatureRepository>();
//
//   /// TTL của cache (điều chỉnh theo nhu cầu)
//   static const Duration _ttl = Duration(minutes: 45);
//
//   /// Cache theo userName
//   static final Map<String, _CacheEntry<List<SignRolesModel>>> _cache =
//       HashMap<String, _CacheEntry<List<SignRolesModel>>>();
//
//   /// Dedupe các request trùng userName: chỉ bắn 1 call, các bên khác await chung
//   static final Map<String, Future<List<SignRolesModel>>> _inFlight =
//       HashMap<String, Future<List<SignRolesModel>>>();
//
//   /// Token tránh race-condition: response cũ sẽ bị bỏ qua
//   int _requestToken = 0;
//
//   bool _isFresh(String userName) {
//     final c = _cache[userName];
//     if (c == null) return false;
//     return DateTime.now().difference(c.at) < _ttl;
//     // Có thể bổ sung kiểm tra "roles.isNotEmpty" nếu cần
//   }
//
//   List<SignRolesModel>? getFromCache(String userName) {
//     final c = _cache[userName];
//     if (c == null) return null;
//     if (!_isFresh(userName)) return null;
//     return c.data;
//   }
//
//   /// Load roles cho userName.
//   /// - forceRefresh: bỏ qua cache, gọi thẳng network.
//   /// - silent: nếu đã có cache và muốn refresh nền thì set true để tránh nháy loading UI.
//   Future<void> load(
//     String userName, {
//     bool forceRefresh = false,
//     bool silent = false,
//   }) async {
//     final hasFreshCache = _isFresh(userName);
//
//     // 1) Nếu có cache tươi và không ép refresh: emit ngay cache (mượt UI)
//     if (!forceRefresh && hasFreshCache) {
//       final cached = _cache[userName]!;
//       emit(state.copyWith(
//         loading: false,
//         roles: cached.data,
//         lastLoadedAt: cached.at,
//         fromCache: true,
//         clearError: true,
//       ));
//       // Nếu chỉ cần cache thì return luôn.
//       // Nếu muốn vừa trả cache vừa refresh nền: giữ nguyên `silent=true` ở lần gọi load khác.
//       if (silent) return;
//     }
//
//     // 2) Dedupe: nếu đã có request đang chạy cho user này -> await chung
//     if (_inFlight.containsKey(userName)) {
//       try {
//         final roles = await _inFlight[userName]!;
//         // Khi in-flight xong, phát state (nếu đây là lượt mới nhất)
//         emit(state.copyWith(
//           loading: false,
//           roles: roles,
//           lastLoadedAt: DateTime.now(),
//           fromCache: false,
//           clearError: true,
//         ));
//       } catch (e) {
//         // Nếu có cache rồi và là silent refresh: không phá UI hiện tại
//         if (!(hasFreshCache && silent)) {
//           emit(state.copyWith(
//             loading: false,
//             error: e.toString(),
//             fromCache: hasFreshCache,
//           ));
//         }
//       }
//       return;
//     }
//
//     final myToken = ++_requestToken;
//
//     // 3) Nếu không dùng cache hoặc forceRefresh: gọi network
//     if (!(hasFreshCache && silent)) {
//       // Chỉ set loading nếu không chạy silent refresh trên cache
//       emit(state.copyWith(loading: true, clearError: true));
//     }
//
//     final future = _repo.getRolesV1(userName).then<List<SignRolesModel>>((raw) {
//       // Ép kiểu danh sách model; nếu repo đã trả đúng type thì có thể bỏ cast.
//       final roles = List<SignRolesModel>.from(raw);
//       // Lưu cache
//       _cache[userName] =
//           _CacheEntry<List<SignRolesModel>>(roles, DateTime.now());
//       return roles;
//     });
//
//     _inFlight[userName] = future;
//
//     try {
//       final roles = await future;
//       // Bỏ qua nếu đã có request mới hơn
//       if (myToken != _requestToken) return;
//
//       emit(state.copyWith(
//         loading: false,
//         roles: roles,
//         lastLoadedAt: DateTime.now(),
//         fromCache: false,
//         clearError: true,
//       ));
//     } catch (e) {
//       if (myToken != _requestToken) return;
//
//       // Nếu có cache rồi và đang silent refresh → không thay đổi UI đang hiển thị
//       if (hasFreshCache && silent) {
//         // no-op (hoặc log)
//       } else {
//         emit(state.copyWith(
//           loading: false,
//           error: e.toString(),
//           fromCache: hasFreshCache,
//         ));
//       }
//     } finally {
//       // Dọn in-flight
//       // Tránh xoá nhầm nếu đã có request khác chèn vào map
//       final current = _inFlight[userName];
//       if (current == future) {
//         _inFlight.remove(userName);
//       }
//     }
//   }
//
//   /// Làm ấm cache (prefetch) không tác động UI.
//   Future<void> prefetch(String userName) => load(
//         userName,
//         forceRefresh: false,
//         silent: true,
//       );
//
//   /// Buộc load lại từ server, bỏ qua cache (vẫn tránh nháy nếu muốn)
//   Future<void> forceReload(String userName, {bool silent = false}) =>
//       load(userName, forceRefresh: true, silent: silent);
//
//   /// Invalidate cache 1 user
//   void invalidate(String userName) {
//     _cache.remove(userName);
//   }
//
//   /// Invalidate toàn bộ cache
//   void invalidateAll() {
//     _cache.clear();
//   }
// }
// lib/app/modules/nurse_page/electronic_signature_v2/presentation/cubits/roles_cubit/roles_cubit.dart
// lib/app/modules/nurse_page/electronic_signature_v2/presentation/cubits/roles_cubit/roles_cubit.dart
import 'dart:collection';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pstb/app/models/sign_roles_model.dart';

import '../../../data/repositories/signature_repository.dart';
import 'roles_state.dart';

final _sl = GetIt.instance;

/// Cache entry kèm timestamp để kiểm TTL
class _CacheEntry<T> {
  final T data;
  final DateTime at;
  const _CacheEntry(this.data, this.at);
}

class RolesCubit extends Cubit<RolesState> {
  RolesCubit() : super(const RolesState());

  SignatureRepository get _repo => _sl<SignatureRepository>();

  /// TTL cache
  static const Duration _ttl = Duration(minutes: 45);

  /// Cache theo userName
  static final Map<String, _CacheEntry<List<SignRolesModel>>> _cache =
      HashMap<String, _CacheEntry<List<SignRolesModel>>>();

  /// Dedupe request trùng userName
  static final Map<String, Future<List<SignRolesModel>>> _inFlight =
      HashMap<String, Future<List<SignRolesModel>>>();

  /// Token tránh race-condition: response cũ sẽ bị bỏ qua
  int _requestToken = 0;

  bool _isFresh(String userName) {
    final c = _cache[userName];
    if (c == null) return false;
    return DateTime.now().difference(c.at) < _ttl;
  }

  List<SignRolesModel>? getFromCache(String userName) {
    final c = _cache[userName];
    if (c == null) return null;
    if (!_isFresh(userName)) return null;
    return c.data;
  }

  /// Chuẩn hoá & loại trùng (theo code)
  List<SignRolesModel> _normalize(List<SignRolesModel> raw) {
    final seen = <String>{};
    final out = <SignRolesModel>[];
    for (final r in raw) {
      final code = (r.code ?? '').trim();
      if (code.isEmpty) continue;
      if (seen.add(code)) out.add(r);
    }
    return out;
  }

  /// Load roles cho userName.
  /// Chính sách mặc định: CacheFirst (không loading nếu có cache tươi).
  /// - forceNetwork: bỏ qua cache, gọi mạng, HIỆN LOADING.
  /// - backgroundRefresh: nếu có cache tươi, vẫn gọi mạng nền, KHÔNG LOADING.
  Future<void> load(
    String userName, {
    bool forceNetwork = false,
    bool backgroundRefresh = false,
  }) async {
    final hasFreshCache = _isFresh(userName);

    // 1) Có cache tươi & không ép mạng → trả cache ngay, không loading
    if (!forceNetwork && hasFreshCache) {
      final cached = _cache[userName]!;
      emit(state.copyWith(
        status: RolesStatus.success,
        roles: cached.data,
        lastLoadedAt: cached.at,
        fromCache: true,
        clearError: true,
      ));

      // Nếu không muốn làm mới nền → kết thúc
      if (!backgroundRefresh) return;

      // 1a) Làm mới nền KHÔNG loading
      if (_inFlight.containsKey(userName)) {
        try {
          await _inFlight[userName]!;
        } catch (_) {}
        return;
      }

      final myToken = ++_requestToken;
      final future =
          _repo.getRolesV1(userName).then<List<SignRolesModel>>((raw) {
        final roles = _normalize(List<SignRolesModel>.from(raw));
        _cache[userName] =
            _CacheEntry<List<SignRolesModel>>(roles, DateTime.now());
        return roles;
      });

      _inFlight[userName] = future;

      try {
        final roles = await future;
        if (myToken != _requestToken) return;
        emit(state.copyWith(
          status: RolesStatus.success,
          roles: roles,
          lastLoadedAt: DateTime.now(),
          fromCache: false,
          clearError: true,
        ));
      } catch (_) {
        // silent — không phá UI cache
      } finally {
        if (_inFlight[userName] == future) _inFlight.remove(userName);
      }
      return;
    }

    // 2) Cần mạng (không có cache tươi hoặc forceNetwork) → HIỆN LOADING
    emit(state.copyWith(status: RolesStatus.loading, clearError: true));

    // Dedupe nếu đã có request đang chạy
    if (_inFlight.containsKey(userName)) {
      try {
        final roles = await _inFlight[userName]!;
        emit(state.copyWith(
          status: RolesStatus.success,
          roles: roles,
          lastLoadedAt: DateTime.now(),
          fromCache: false,
          clearError: true,
        ));
      } catch (e) {
        emit(state.copyWith(
          status: RolesStatus.failure,
          error: e.toString(),
          fromCache: false,
        ));
      }
      return;
    }

    final myToken = ++_requestToken;

    final future = _repo.getRolesV1(userName).then<List<SignRolesModel>>((raw) {
      final roles = _normalize(List<SignRolesModel>.from(raw));
      _cache[userName] =
          _CacheEntry<List<SignRolesModel>>(roles, DateTime.now());
      return roles;
    });

    _inFlight[userName] = future;

    try {
      final roles = await future;
      if (myToken != _requestToken) return;

      emit(state.copyWith(
        status: RolesStatus.success,
        roles: roles,
        lastLoadedAt: DateTime.now(),
        fromCache: false,
        clearError: true,
      ));
    } catch (e) {
      if (myToken != _requestToken) return;
      emit(state.copyWith(
        status: RolesStatus.failure,
        error: e.toString(),
        fromCache: false,
      ));
    } finally {
      if (_inFlight[userName] == future) _inFlight.remove(userName);
    }
  }

  /// Prefetch: làm ấm cache, không ảnh hưởng UI
  Future<void> prefetch(String userName) =>
      load(userName, forceNetwork: false, backgroundRefresh: true);

  /// Bỏ qua cache, luôn gọi mạng (sẽ show loading)
  Future<void> forceReload(String userName) =>
      load(userName, forceNetwork: true, backgroundRefresh: false);

  /// Invalidate cache 1 user
  void invalidate(String userName) {
    _cache.remove(userName);
  }

  /// Invalidate toàn bộ cache
  void invalidateAll() {
    _cache.clear();
  }

  /// Reset state về initial
  void reset() {
    emit(const RolesState());
  }
}
