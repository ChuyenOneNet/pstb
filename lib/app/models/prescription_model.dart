// To parse this JSON data, do
//
//     final prescriptionManualModel = prescriptionManualModelFromJson(jsonString);

import 'dart:convert';

class PrescriptionManualModel {
  PrescriptionManualModel({
    required this.images,
    required this.note,
  });

  List<String> images;
  String note;

  factory PrescriptionManualModel.fromRawJson(String str) =>
      PrescriptionManualModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PrescriptionManualModel.fromJson(Map<String, dynamic> json) =>
      PrescriptionManualModel(
        images: List<String>.from(json["images"].map((x) => x)),
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "images": List<dynamic>.from(images.map((x) => x)),
        "note": note,
      };
}

List<ListManualModel> listManualModelFromJson(String str) =>
    List<ListManualModel>.from(
        json.decode(str).map((x) => ListManualModel.fromJson(x)));

String listManualModelToJson(List<ListManualModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListManualModel {
  ListManualModel({
    required this.status,
  });

  String status;

  factory ListManualModel.fromRawJson(String str) =>
      ListManualModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListManualModel.fromJson(Map<String, dynamic> json) =>
      ListManualModel(
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
      };
}

class PrescriptionModel {
  String? chidinhboiId;
  String? tenbacsi;
  String? loai;
  String? tenloai;
  String? toathuocId;
  String? ylenhId;
  String? khambenhId;
  PrescriptionModel(
      {
        this.chidinhboiId,
        this.tenbacsi,
        this.loai,
        this.tenloai,
        this.toathuocId,
        this.khambenhId,
        this.ylenhId});

  PrescriptionModel.fromJson(Map<String, dynamic> json) {
    chidinhboiId = json['chidinhboi_id'];
    tenbacsi = json['tenbacsi'];
    loai = json['loai'];
    tenloai = json['tenloai'];
    toathuocId = json['toathuoc_id'];
    ylenhId = json['ylenh_id'];
    khambenhId = json['khambenh_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chidinhboi_id'] = chidinhboiId;
    data['tenbacsi'] = tenbacsi;
    data['loai'] = loai;
    data['tenloai'] = tenloai;
    data['toathuoc_id'] = toathuocId;
    data['ylenh_id'] = ylenhId;
    data['khambenh_id'] = khambenhId;
    return data;
  }
}
