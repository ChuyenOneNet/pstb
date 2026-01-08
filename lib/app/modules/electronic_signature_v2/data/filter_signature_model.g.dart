// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_signature_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterSignatureModelV2 _$FilterSignatureModelV2FromJson(
        Map<String, dynamic> json) =>
    FilterSignatureModelV2(
      userName: json['UserName'] as String?,
      signingStatusCode: (json['SigningStatus'] as num?)?.toInt(),
      roleCode: json['RoleCode'] as String?,
      searchValue: json['Keyword'] as String?,
      fromDate: json['FromDate'] as String?,
      toDate: json['ToDate'] as String?,
      departmentCode: json['DepartmentCode'] as String?,
      documentTypeCode: json['DocumentTypeCode'] as String?,
      patientCode: json['PatientCode'] as String?,
      pageIndex: (json['PageIndex'] as num?)?.toInt(),
      pageSize: (json['PageSize'] as num?)?.toInt(),
      offset: (json['Offset'] as num?)?.toInt(),
    );

Map<String, dynamic> _$FilterSignatureModelV2ToJson(
        FilterSignatureModelV2 instance) =>
    <String, dynamic>{
      'UserName': instance.userName,
      'SigningStatus': instance.signingStatusCode,
      'RoleCode': instance.roleCode,
      'Keyword': instance.searchValue,
      'FromDate': instance.fromDate,
      'ToDate': instance.toDate,
      'DepartmentCode': instance.departmentCode,
      'PatientCode': instance.patientCode,
      'DocumentTypeCode': instance.documentTypeCode,
      'PageIndex': instance.pageIndex,
      'PageSize': instance.pageSize,
      'Offset': instance.offset,
    };
