import 'dart:convert';

class EMRDetailModel {
  EMRDetailModel({
    required this.maHoSo,
  });

  String maHoSo;

  EMRDetailModel copyWith({
    required String maHoSo,
  }) =>
      EMRDetailModel(
        maHoSo: maHoSo,
      );

  factory EMRDetailModel.fromRawJson(String str) =>
      EMRDetailModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EMRDetailModel.fromJson(Map<String, dynamic> json) => EMRDetailModel(
        maHoSo: json["MaHoSo"],
      );

  Map<String, dynamic> toJson() => {
        "MaHoSo": maHoSo,
      };
}

class PathologicalModel {
  PathologicalModel({
    required this.type,
    required this.text,
  });

  String type;
  String text;

  factory PathologicalModel.fromRawJson(String str) =>
      PathologicalModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PathologicalModel.fromJson(Map<String, dynamic> json) =>
      PathologicalModel(
        type: json["type"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "text": text,
      };
}
