// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusinessDetailModel _$BusinessDetailModelFromJson(Map<String, dynamic> json) =>
    BusinessDetailModel(
      title: json['title'] as String?,
      xuTri: json['xuTri'] as String?,
      ngayVaoVien: json['ngayVaoVien'] as String?,
      ngayRaVien: json['ngayRaVien'] as String?,
      sinhHieu: json['sinhHieu'] == null
          ? null
          : SinhHieu.fromJson(json['sinhHieu'] as Map<String, dynamic>),
      urlDataInfos: (json['urlDataInfos'] as List<dynamic>?)
          ?.map((e) => UrlDataInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      docmments: (json['docmments'] as List<dynamic>?)
          ?.map((e) => DocmmentGroup.fromJson(e as Map<String, dynamic>))
          .toList(),
      xetNghiemInfos: (json['xetNghiemInfos'] as List<dynamic>?)
          ?.map((e) => XetNghiemInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      toaThuocInfos: (json['toaThuocInfos'] as List<dynamic>?)
          ?.map((e) => ToaThuocInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      vienPhiInfos: (json['vienPhiInfos'] as List<dynamic>?)
          ?.map((e) => VienPhiInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BusinessDetailModelToJson(
        BusinessDetailModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'xuTri': instance.xuTri,
      'ngayVaoVien': instance.ngayVaoVien,
      'ngayRaVien': instance.ngayRaVien,
      'sinhHieu': instance.sinhHieu?.toJson(),
      'urlDataInfos': instance.urlDataInfos?.map((e) => e.toJson()).toList(),
      'docmments': instance.docmments?.map((e) => e.toJson()).toList(),
      'xetNghiemInfos':
          instance.xetNghiemInfos?.map((e) => e.toJson()).toList(),
      'toaThuocInfos': instance.toaThuocInfos?.map((e) => e.toJson()).toList(),
      'vienPhiInfos': instance.vienPhiInfos?.map((e) => e.toJson()).toList(),
    };

SinhHieu _$SinhHieuFromJson(Map<String, dynamic> json) => SinhHieu(
      chanDoanPhanBiet: json['chanDoanPhanBiet'] as String?,
      benhChinh: json['benhChinh'] as String?,
      benhKemTheo: json['benhKemTheo'] as String?,
      id: json['id'] as String?,
      dangKyId: json['dangKyId'] as String?,
      khamBenhId: json['khamBenhId'] as String?,
      noiTruId: json['noiTruId'] as String?,
      mach: json['mach'] as String?,
      nhietDo: json['nhietDo'] as String?,
      huyetApMin: json['huyetApMin'] as String?,
      huyetApMax: json['huyetApMax'] as String?,
      nhipTho: json['nhipTho'] as String?,
      canNang: json['canNang'] as String?,
      chieuCao: json['chieuCao'] as String?,
      bmi: json['bmi'] as String?,
      spo2: json['spo2'] as String?,
      thoiGian: json['thoiGian'] as String?,
      loai: (json['loai'] as num?)?.toInt(),
      lyDoDenKham: json['lyDoDenKham'] as String?,
    );

Map<String, dynamic> _$SinhHieuToJson(SinhHieu instance) => <String, dynamic>{
      'chanDoanPhanBiet': instance.chanDoanPhanBiet,
      'benhChinh': instance.benhChinh,
      'benhKemTheo': instance.benhKemTheo,
      'id': instance.id,
      'dangKyId': instance.dangKyId,
      'khamBenhId': instance.khamBenhId,
      'noiTruId': instance.noiTruId,
      'mach': instance.mach,
      'nhietDo': instance.nhietDo,
      'huyetApMin': instance.huyetApMin,
      'huyetApMax': instance.huyetApMax,
      'nhipTho': instance.nhipTho,
      'canNang': instance.canNang,
      'chieuCao': instance.chieuCao,
      'bmi': instance.bmi,
      'spo2': instance.spo2,
      'thoiGian': instance.thoiGian,
      'loai': instance.loai,
      'lyDoDenKham': instance.lyDoDenKham,
    };

UrlDataInfo _$UrlDataInfoFromJson(Map<String, dynamic> json) => UrlDataInfo(
      id: json['id'] as String?,
      dangKyId: json['dangKyId'] as String?,
      benhNhanId: json['benhNhanId'] as String?,
      maDichVu: json['maDichVu'] as String?,
      tenDichVu: json['tenDichVu'] as String?,
      fileUrl: json['fileUrl'] as String?,
      pdfBase64: json['pdfBase64'] as String?,
      ketLuan: json['ketLuan'] as String?,
    );

Map<String, dynamic> _$UrlDataInfoToJson(UrlDataInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'dangKyId': instance.dangKyId,
      'benhNhanId': instance.benhNhanId,
      'maDichVu': instance.maDichVu,
      'tenDichVu': instance.tenDichVu,
      'fileUrl': instance.fileUrl,
      'pdfBase64': instance.pdfBase64,
      'ketLuan': instance.ketLuan,
    };

DocmmentGroup _$DocmmentGroupFromJson(Map<String, dynamic> json) =>
    DocmmentGroup(
      title: json['title'] as String?,
      items: (json['docmment'] as List<dynamic>?)
          ?.map((e) => DocmmentItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DocmmentGroupToJson(DocmmentGroup instance) =>
    <String, dynamic>{
      'title': instance.title,
      'docmment': instance.items?.map((e) => e.toJson()).toList(),
    };

DocmmentItem _$DocmmentItemFromJson(Map<String, dynamic> json) => DocmmentItem(
      id: json['id'] as String?,
      name: json['name'] as String?,
      groupName: json['groupName'] as String?,
      content: json['content'] as String?,
    );

Map<String, dynamic> _$DocmmentItemToJson(DocmmentItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'groupName': instance.groupName,
      'content': instance.content,
    };

ToaThuocInfo _$ToaThuocInfoFromJson(Map<String, dynamic> json) => ToaThuocInfo(
      id: json['id'] as String?,
      dangKyId: json['dangKyId'] as String?,
      toaThuocId: json['toaThuocId'] as String?,
      bacSi: json['bacSi'] as String?,
      loai: json['loai'] as String?,
      soLuong: json['soLuong'] as String?,
      donViTinh: json['donViTinh'] as String?,
      cachDung: json['cachDung'] as String?,
      tenHang: json['tenHang'] as String?,
      hoatChat: json['hoatChat'] as String?,
      duongDung: json['duongDung'] as String?,
      thoiGian: json['thoiGian'] == null
          ? null
          : DateTime.parse(json['thoiGian'] as String),
      dateModified: json['dateModified'] == null
          ? null
          : DateTime.parse(json['dateModified'] as String),
    );

Map<String, dynamic> _$ToaThuocInfoToJson(ToaThuocInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'dangKyId': instance.dangKyId,
      'toaThuocId': instance.toaThuocId,
      'bacSi': instance.bacSi,
      'loai': instance.loai,
      'soLuong': instance.soLuong,
      'donViTinh': instance.donViTinh,
      'cachDung': instance.cachDung,
      'tenHang': instance.tenHang,
      'hoatChat': instance.hoatChat,
      'duongDung': instance.duongDung,
      'thoiGian': instance.thoiGian?.toIso8601String(),
      'dateModified': instance.dateModified?.toIso8601String(),
    };

VienPhiInfo _$VienPhiInfoFromJson(Map<String, dynamic> json) => VienPhiInfo(
      id: json['id'] as String?,
      dangKy_ID: json['dangKy_ID'] as String?,
      benhNhan_ID: json['benhNhan_ID'] as String?,
      lastTimeUpdate: json['lastTimeUpdate'] as String?,
      thoiGian: json['thoiGian'] as String?,
      maGiaoDich: json['maGiaoDich'] as String?,
      xmlData: json['xmlData'] as String?,
      maHoaDon: json['maHoaDon'] as String?,
    );

Map<String, dynamic> _$VienPhiInfoToJson(VienPhiInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'dangKy_ID': instance.dangKy_ID,
      'benhNhan_ID': instance.benhNhan_ID,
      'lastTimeUpdate': instance.lastTimeUpdate,
      'thoiGian': instance.thoiGian,
      'maGiaoDich': instance.maGiaoDich,
      'xmlData': instance.xmlData,
      'maHoaDon': instance.maHoaDon,
    };

XetNghiemInfo _$XetNghiemInfoFromJson(Map<String, dynamic> json) =>
    XetNghiemInfo(
      id: json['id'] as String?,
      xetNghiemId: json['xetNghiem_ID'] as String?,
      loaiXetNghiemId: json['loaiXetNghiem_ID'] as String?,
      tenLoaiXetNghiem: json['tenLoaiXetNghiem'] as String?,
      chiSoXetNghiemId: json['chiSoXetNghiem_ID'] as String?,
      giaTri: json['giaTri'] as String?,
      normalRange: json['normalRange'] as String?,
      tenChiSo: json['tenChiSo'] as String?,
      donViTinh: json['donViTinh'] as String?,
      tenDichVu: json['tenDichVu'] as String?,
      thoiGian: json['thoiGian'] == null
          ? null
          : DateTime.parse(json['thoiGian'] as String),
      dangKyId: json['dangKy_ID'] as String?,
    );

Map<String, dynamic> _$XetNghiemInfoToJson(XetNghiemInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'xetNghiem_ID': instance.xetNghiemId,
      'loaiXetNghiem_ID': instance.loaiXetNghiemId,
      'tenLoaiXetNghiem': instance.tenLoaiXetNghiem,
      'chiSoXetNghiem_ID': instance.chiSoXetNghiemId,
      'giaTri': instance.giaTri,
      'normalRange': instance.normalRange,
      'tenChiSo': instance.tenChiSo,
      'donViTinh': instance.donViTinh,
      'tenDichVu': instance.tenDichVu,
      'thoiGian': instance.thoiGian?.toIso8601String(),
      'dangKy_ID': instance.dangKyId,
    };
