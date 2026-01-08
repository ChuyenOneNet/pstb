// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_it/get_it.dart';
//
// import '../../../data/repositories/signature_repository.dart';
// import 'package:pstb/utils/api_url.dart'; // để build url PDF (giữ như dự án)
// import 'package:pstb/services/api_base_helper.dart'; // nếu bạn vẫn lấy headers tại đây
//
// class DocumentDetailState extends Equatable {
//   final bool loading; // load pdf/header ban đầu
//   final bool acting; // đang ký/thu hồi
//   final String? error;
//   final String? pdfUrl;
//   final Map<String, String>? headers;
//   final bool isSigned; // trạng thái hiện tại
//   final String? toast; // message ngắn (thành công/thất bại)
//
//   const DocumentDetailState({
//     required this.loading,
//     required this.acting,
//     required this.isSigned,
//     this.error,
//     this.pdfUrl,
//     this.headers,
//     this.toast,
//   });
//
//   DocumentDetailState copyWith({
//     bool? loading,
//     bool? acting,
//     String? error,
//     String? pdfUrl,
//     Map<String, String>? headers,
//     bool? isSigned,
//     String? toast,
//     bool clearToast = false,
//   }) =>
//       DocumentDetailState(
//         loading: loading ?? this.loading,
//         acting: acting ?? this.acting,
//         isSigned: isSigned ?? this.isSigned,
//         error: error,
//         pdfUrl: pdfUrl ?? this.pdfUrl,
//         headers: headers ?? this.headers,
//         toast: clearToast ? null : (toast ?? this.toast),
//       );
//
//   @override
//   List<Object?> get props =>
//       [loading, acting, error, pdfUrl, headers, isSigned, toast];
// }
//
// final _sl = GetIt.instance;
//
// class DocumentDetailCubit extends Cubit<DocumentDetailState> {
//   SignatureRepository get _repo => _sl<SignatureRepository>();
//   DocumentDetailCubit()
//       : super(const DocumentDetailState(
//             loading: true, acting: false, isSigned: false));
//
//   Future<void> load({
//     required String docId,
//     required bool initialSigned,
//   }) async {
//     emit(state.copyWith(loading: true, error: null, clearToast: true));
//     try {
//       // headers cho PDF (giữ cách cũ nếu server yêu cầu)
//       final headers = await ApiBaseHelper.getHeaderWithMedicalUnitId() ?? {};
//       final url = '${ApiUrl.baseUrl}${ApiUrl.getPDFDocuments}/$docId';
//
//       emit(state.copyWith(
//         loading: false,
//         pdfUrl: url,
//         headers: headers,
//         isSigned: initialSigned,
//       ));
//     } catch (e) {
//       emit(state.copyWith(loading: false, error: 'Lỗi tải chi tiết: $e'));
//     }
//   }
//
//   /// Ký văn bản qua Repository
//   Future<bool> sign({
//     required String userName,
//     required String roleCode,
//     required String docId,
//   }) async {
//     emit(state.copyWith(acting: true, clearToast: true));
//     try {
//       final res = await _repo
//           .signV1(userName: userName, roleCode: roleCode, ids: [docId]);
//       final ok = res.isTempSuccess ?? false;
//       emit(state.copyWith(
//         acting: false,
//         isSigned: ok ? true : state.isSigned,
//         toast: ok ? 'Ký thành công' : (res.message ?? 'Ký thất bại'),
//       ));
//       return ok;
//     } catch (e) {
//       emit(state.copyWith(acting: false, toast: 'Ký thất bại: $e'));
//       return false;
//     }
//   }
//
//   /// Thu hồi chữ ký qua Repository
//   Future<bool> revoke({
//     required String userName,
//     required String docId,
//   }) async {
//     emit(state.copyWith(acting: true, clearToast: true));
//     try {
//       final res = await _repo.revokeV1(userName: userName, ids: [docId]);
//       final ok = (res.ids ?? const []).contains(docId);
//       emit(state.copyWith(
//         acting: false,
//         isSigned: ok ? false : state.isSigned,
//         toast: ok ? 'Huỷ ký thành công' : (res.message ?? 'Huỷ ký thất bại'),
//       ));
//       return ok;
//     } catch (e) {
//       emit(state.copyWith(acting: false, toast: 'Huỷ ký thất bại: $e'));
//       return false;
//     }
//   }
//
//   Future<void> refresh({
//     required String docId,
//   }) async {
//     await load(docId: docId, initialSigned: state.isSigned);
//   }
//
//   void clearToast() => emit(state.copyWith(clearToast: true));
// }
import 'dart:typed_data';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../../../data/repositories/signature_repository.dart';
import 'package:pstb/utils/api_url.dart';
import 'package:pstb/services/api_base_helper.dart';
import '../../../pdf_cache.dart';

class DocumentDetailState extends Equatable {
  final bool loading;
  final bool acting;
  final String? error;
  final String? pdfUrl;
  final Map<String, String>? headers;
  final Uint8List? pdfBytes; // <—— thêm
  final bool isSigned;
  final String? toast;

  const DocumentDetailState({
    required this.loading,
    required this.acting,
    required this.isSigned,
    this.error,
    this.pdfUrl,
    this.headers,
    this.pdfBytes, // <—— thêm
    this.toast,
  });

  DocumentDetailState copyWith({
    bool? loading,
    bool? acting,
    String? error,
    String? pdfUrl,
    Map<String, String>? headers,
    Uint8List? pdfBytes, // <—— thêm
    bool? isSigned,
    String? toast,
    bool clearToast = false,
  }) =>
      DocumentDetailState(
        loading: loading ?? this.loading,
        acting: acting ?? this.acting,
        isSigned: isSigned ?? this.isSigned,
        error: error,
        pdfUrl: pdfUrl ?? this.pdfUrl,
        headers: headers ?? this.headers,
        pdfBytes: pdfBytes ?? this.pdfBytes, // <—— thêm
        toast: clearToast ? null : (toast ?? this.toast),
      );

  @override
  List<Object?> get props =>
      [loading, acting, error, pdfUrl, headers, pdfBytes, isSigned, toast];
}

final _sl = GetIt.instance;

class DocumentDetailCubit extends Cubit<DocumentDetailState> {
  SignatureRepository get _repo => _sl<SignatureRepository>();
  DocumentDetailCubit()
      : super(const DocumentDetailState(
            loading: true, acting: false, isSigned: false));

  String _cacheKey({
    required String docId,
    required String userName,
    required Map<String, String> headers,
  }) {
    // Tránh nhét token vào key; đủ phân biệt theo user + medicalUnit + doc
    final unit = headers['X-Medical-Unit-Id'] ??
        headers['Medical-Unit-Id'] ??
        headers['x-medical-unit-id'] ??
        '';
    return 'pdf::user=$userName::unit=$unit::doc=$docId';
  }

  Future<void> load({
    required String docId,
    required bool initialSigned,
    bool forceRefresh = false,
  }) async {
    emit(state.copyWith(loading: true, error: null, clearToast: true));
    try {
      final headers = await ApiBaseHelper.getHeaderWithMedicalUnitId() ?? {};
      final url = '${ApiUrl.baseUrl}${ApiUrl.getPDFDocuments}/$docId';

      // 1) Thử cache trước
      final key =
          _cacheKey(docId: docId, userName: 'current', headers: headers);
      if (forceRefresh) {
        PdfCache.I.remove(key);
      }

      // THỬ CACHE TRƯỚC (chỉ khi KHÔNG force)
      final cached = forceRefresh ? null : PdfCache.I.getIfFresh(key);

      if (cached != null) {
        emit(state.copyWith(
          loading: false,
          pdfUrl: url,
          headers: headers,
          pdfBytes: cached, // ưu tiên memory
          isSigned: initialSigned,
        ));
        // Song song: có thể prefetch nền nếu muốn refresh bytes (tùy)
        return;
      }

      // 2) Không có cache → fetch bytes (ưu tiên memory render)
      Uint8List? bytes;
      try {
        final resp = await http.get(Uri.parse(url), headers: headers);
        if (resp.statusCode == 200) {
          bytes = resp.bodyBytes;
          PdfCache.I.put(key, bytes);
        } else {
          // Nếu lỗi, không vứt exception để vẫn cho viewer.network xử lý
        }
      } catch (_) {
        // ignore, sẽ fallback network viewer
      }

      emit(state.copyWith(
        loading: false,
        pdfUrl: url,
        headers: headers,
        pdfBytes: bytes, // có -> viewer.memory, không -> viewer.network
        isSigned: initialSigned,
      ));
    } catch (e) {
      emit(state.copyWith(loading: false, error: 'Lỗi tải chi tiết: $e'));
    }
  }

  // Tránh double-click
  bool _actingGuard() => state.acting;

  Future<bool> sign({
    required String userName,
    required String roleCode,
    required String docId,
  }) async {
    if (_actingGuard()) return false;
    emit(state.copyWith(acting: true, clearToast: true));
    try {
      final res = await _repo
          .signV1(userName: userName, roleCode: roleCode, ids: [docId]);
      final ok = res.isTempSuccess ?? false;
      if (ok) {
        // XÓA CACHE + TẢI LẠI PDF MỚI
        await load(docId: docId, initialSigned: true, forceRefresh: true);
      }
      emit(state.copyWith(
        acting: false,
        isSigned: ok ? true : state.isSigned,
        toast: ok ? 'Ký thành công' : (res.message ?? 'Ký thất bại'),
      ));
      return ok;
    } catch (e) {
      emit(state.copyWith(acting: false, toast: 'Ký thất bại: $e'));
      return false;
    }
  }

  Future<bool> revoke({
    required String userName,
    required String docId,
  }) async {
    if (_actingGuard()) return false;
    emit(state.copyWith(acting: true, clearToast: true));
    try {
      final res = await _repo.revokeV1(userName: userName, ids: [docId]);
      final ok = (res.ids ?? const []).contains(docId);
      if (ok) {
        // XÓA CACHE + TẢI LẠI PDF MỚI
        await load(docId: docId, initialSigned: false, forceRefresh: true);
      }
      emit(state.copyWith(
        acting: false,
        isSigned: ok ? false : state.isSigned,
        toast: ok ? 'Huỷ ký thành công' : (res.message ?? 'Huỷ ký thất bại'),
      ));
      return ok;
    } catch (e) {
      emit(state.copyWith(acting: false, toast: 'Huỷ ký thất bại: $e'));
      return false;
    }
  }

  Future<void> refresh({required String docId}) async {
    await load(
      docId: docId,
      initialSigned: state.isSigned,
      forceRefresh: true, // LUÔN TẢI MỚI KHI BẤM NÚT REFRESH
    );
  }

  void clearToast() => emit(state.copyWith(clearToast: true));
}
