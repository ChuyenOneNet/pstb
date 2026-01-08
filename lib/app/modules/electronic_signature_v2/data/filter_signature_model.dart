import 'package:json_annotation/json_annotation.dart';

part 'filter_signature_model.g.dart';

@JsonSerializable(explicitToJson: true)
class FilterSignatureModelV2 {
  @JsonKey(name: 'UserName')
  String? userName;

  /// 0 = unsigned, 1 = signed, 2 = revoked
  @JsonKey(name: 'SigningStatus')
  int? signingStatusCode;

  @JsonKey(name: 'RoleCode')
  String? roleCode;

  /// Từ khoá tìm kiếm
  @JsonKey(name: 'Keyword')
  String? searchValue;

  /// yyyy-MM-dd
  @JsonKey(name: 'FromDate')
  String? fromDate;

  /// yyyy-MM-dd
  @JsonKey(name: 'ToDate')
  String? toDate;

  @JsonKey(name: 'DepartmentCode')
  String? departmentCode;

  @JsonKey(name: 'PatientCode')
  String? patientCode;

  @JsonKey(name: 'DocumentTypeCode')
  String? documentTypeCode;

  /// --- Paging ---
  /// Mặc định truyền 0/10 nếu null
  @JsonKey(name: 'PageIndex')
  int? pageIndex;

  @JsonKey(name: 'PageSize')
  int? pageSize;

  /// Tuỳ BE: có thể bỏ qua hoặc tính từ PageIndex * PageSize
  @JsonKey(name: 'Offset')
  int? offset;

  FilterSignatureModelV2({
    this.userName,
    this.signingStatusCode,
    this.roleCode,
    this.searchValue,
    this.fromDate,
    this.toDate,
    this.departmentCode,
    this.documentTypeCode,
    this.patientCode,
    this.pageIndex,
    this.pageSize,
    this.offset,
  });

  factory FilterSignatureModelV2.fromJson(Map<String, dynamic> json) =>
      _$FilterSignatureModelV2FromJson(json);

  Map<String, dynamic> toJson() => _$FilterSignatureModelV2ToJson(this);

  /// Map từ UI key -> code 0/1/2
  FilterSignatureModelV2 withUIStatus(String? uiKey) => copyWith(
        signingStatusCode: _mapStatusKeyToInt(uiKey),
      );

  static int? _mapStatusKeyToInt(String? key) {
    if (key == null) return null;
    switch (key) {
      case 'unsigned':
        return 0;
      case 'signed':
        return 1;
      default:
        return null;
    }
  }

  /// Copy tiện dụng
  FilterSignatureModelV2 copyWith({
    String? userName,
    int? signingStatusCode,
    String? roleCode,
    String? searchValue,
    String? fromDate,
    String? toDate,
    String? departmentCode,
    String? patientCode,
    String? documentTypeCode,
    int? pageIndex,
    int? pageSize,
    int? offset,
  }) {
    return FilterSignatureModelV2(
      userName: userName ?? this.userName,
      signingStatusCode: signingStatusCode ?? this.signingStatusCode,
      roleCode: roleCode ?? this.roleCode,
      searchValue: searchValue ?? this.searchValue,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      departmentCode: departmentCode ?? this.departmentCode,
      patientCode: patientCode ?? this.patientCode,
      documentTypeCode: documentTypeCode ?? this.documentTypeCode,
      pageIndex: pageIndex ?? this.pageIndex,
      pageSize: pageSize ?? this.pageSize,
      offset: offset ?? this.offset,
    );
  }

  FilterSignatureModelV2 copyWithDefaults({
    int? pageIndex,
    int? pageSize,
    bool recalcOffset = true,
  }) {
    final idx = pageIndex ?? this.pageIndex ?? 0;
    final siz = pageSize ?? this.pageSize ?? 10;
    final off = recalcOffset ? (this.offset ?? (idx * siz)) : this.offset;

    return copyWith(
      pageIndex: idx,
      pageSize: siz,
      offset: off,
    );
  }
}

/// Chuyển sang query param: set mặc định PageIndex=0, PageSize=10, auto tính Offset nếu null.
/// Đồng thời loại bỏ null/chuỗi rỗng.
extension FilterQuery on FilterSignatureModelV2 {
  Map<String, dynamic> toQueryParams() {
    final idx = pageIndex ?? 0;
    final siz = pageSize ?? 10;
    final off = offset ?? (idx * siz);

    final m = <String, dynamic>{
      'UserName': userName,
      'SigningStatus': signingStatusCode,
      'RoleCode': roleCode,
      'Keyword': searchValue,
      'FromDate': fromDate,
      'ToDate': toDate,
      'DepartmentCode': departmentCode,
      'PatientCode': patientCode,
      'DocumentTypeCode': documentTypeCode,
      'PageIndex': idx,
      'PageSize': siz,
      'Offset': off,
    };

    m.removeWhere((k, v) => v == null || (v is String && v.trim().isEmpty));
    return m;
  }

  FilterSignatureModelV2 firstPage({int size = 10}) =>
      copyWith(pageIndex: 0, pageSize: size, offset: 0);

  FilterSignatureModelV2 nextPage() {
    final idx = (pageIndex ?? 0) + 1;
    final siz = pageSize ?? 10;
    return copyWith(pageIndex: idx, pageSize: siz, offset: idx * siz);
  }
}
