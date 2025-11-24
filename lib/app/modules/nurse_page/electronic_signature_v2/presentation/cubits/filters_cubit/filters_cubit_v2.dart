// lib/app/modules/nurse_page/electronic_signature_v2/presentation/cubits/filters_cubit/filters_cubit_v2.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pstb/app/models/document_type_model.dart';
import '../../../data/filter_signature_model.dart';
import '../../../data/repositories/signature_repository.dart';
import '../../../data/signing_status.dart';
import 'filters_state_v2.dart';

class FiltersCubitV2 extends Cubit<FiltersStateV2> {
  FiltersCubitV2() : super(FiltersStateV2());

  final _repo = GetIt.I<SignatureRepository>();
// ✅ NEW: Chuyển state -> payload ghi vào Hive (JSON-friendly)
  static Map<String, dynamic> stateToCache(FiltersStateV2 st) {
    Map<String, List<Map<String, dynamic>>> grouped = {
      'all': [],
      'unsigned': [],
      'signed': [],
    };

    void collect(Map<TypeDocumentModel, int> src, String bucket) {
      for (final e in src.entries) {
        grouped[bucket]!.add({
          'code': e.key.code, // String
          'name': e.key.name, // String? (OK)
          'count': e.value, // int
        });
      }
    }

    collect(st.groupedDocuments[null] ?? const {}, 'all');
    collect(st.groupedDocuments['unsigned'] ?? const {}, 'unsigned');
    collect(st.groupedDocuments['signed'] ?? const {}, 'signed');

    return {
      'time': DateTime.now(), // Hive lưu được DateTime
      'totalCounts': st.totalCounts, // Map<String,int>
      'grouped': grouped, // Map<String, List<Map>>
    };
  }

  // ✅ NEW: Đọc payload từ Hive -> emit lại state
  void hydrateFromCache(Map<String, dynamic> cache) {
    final Map<String, int> totals =
        Map<String, int>.from(cache['totalCounts'] ?? const {});

    final Map<String?, Map<TypeDocumentModel, int>> rebuilt = {
      null: {},
      'unsigned': {},
      'signed': {},
    };

    final Map<String, dynamic> g =
        Map<String, dynamic>.from(cache['grouped'] ?? const {});

    void addBack(String bucket, String? statusKey) {
      final List list = (g[bucket] as List?) ?? const [];
      for (final item in list) {
        final m = Map<String, dynamic>.from(item as Map);
        final code = m['code'] as String?;
        if (code == null) continue;
        final name = m['name'] as String?;
        final count = (m['count'] ?? 0) as int;
        final type = TypeDocumentModel(code: code, name: name);
        rebuilt[statusKey]![type] = count;
      }
    }

    addBack('all', null);
    addBack('unsigned', 'unsigned');
    addBack('signed', 'signed');

    emit(state.copyWith(
      isLoading: false,
      hasError: false,
      groupedDocuments: rebuilt,
      totalCounts: totals,
    ));
  }

  Future<void> load({
    required String userName,
    required String fromDate,
    required String toDate,
  }) async {
    emit(state.copyWith(isLoading: true, hasError: false));

    try {
      // GỌI 3 LẦN – LẤY HẾT DỮ LIỆU
      final futures = await Future.wait([
        _repo.getDocumentsWithFilterV1(FilterSignatureModelV2(
          userName: userName,
          fromDate: fromDate,
          toDate: toDate,
          pageSize: 9999,
        )),
        _repo.getDocumentsWithFilterV1(FilterSignatureModelV2(
          userName: userName,
          fromDate: fromDate,
          toDate: toDate,
          signingStatusCode: SigningStatus.unsigned,
          pageSize: 9999,
        )),
        _repo.getDocumentsWithFilterV1(FilterSignatureModelV2(
          userName: userName,
          fromDate: fromDate,
          toDate: toDate,
          signingStatusCode: SigningStatus.signed,
          pageSize: 9999,
        )),
      ]);

      final allDocs = futures[0].items ?? [];
      final unsignedDocs = futures[1].items ?? [];
      final signedDocs = futures[2].items ?? [];

      // Tạo map để nhóm
      final Map<String, TypeDocumentModel> typeMap = {};
      final Map<String?, Map<String, Map<String, int>>> grouped = {
        'unsigned': {},
        'signed': {},
        null: {},
      };

      // Cache documents theo type + status
      final Map<String, Map<String?, List<dynamic>>> docsCache = {};

      void _processDocs(List<dynamic> docs, String? statusKey) {
        for (final doc in docs) {
          final code = doc.documentTypeCode;
          final name = doc.documentTypeName;
          if (code == null || name == null) continue;

          // Cache type
          typeMap[code] = TypeDocumentModel(code: code, name: name);

          // Nhóm count
          grouped[statusKey]![code] ??= {'all': 0, 'unsigned': 0, 'signed': 0};
          grouped[statusKey]![code]!['all'] =
              (grouped[statusKey]![code]!['all'] ?? 0) + 1;
          if (doc.signingStatus == 0) {
            grouped[statusKey]![code]!['unsigned'] =
                (grouped[statusKey]![code]!['unsigned'] ?? 0) + 1;
          }
          if (doc.signingStatus == 1) {
            grouped[statusKey]![code]!['signed'] =
                (grouped[statusKey]![code]!['signed'] ?? 0) + 1;
          }

          // Cache document
          docsCache.putIfAbsent(code, () => {});
          docsCache[code]!.putIfAbsent(statusKey, () => []);
          docsCache[code]![statusKey]!.add(doc);
        }
      }

      _processDocs(allDocs, null);
      _processDocs(unsignedDocs, 'unsigned');
      _processDocs(signedDocs, 'signed');

      // Tạo groupedDocuments cho Home
      final Map<String?, Map<TypeDocumentModel, int>> finalGrouped = {
        for (final status in [null, 'unsigned', 'signed'])
          status: {
            for (final code in grouped[status]!.keys)
              typeMap[code]!: grouped[status]![code]!['all']!
          }
      };

      emit(state.copyWith(
        isLoading: false,
        groupedDocuments: finalGrouped,
        documentsByTypeAndStatus: docsCache,
        totalCounts: {
          'all': futures[0].total ?? 0,
          'unsigned': futures[1].total ?? 0,
          'signed': futures[2].total ?? 0,
        },
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, hasError: true));
    }
  }
}
