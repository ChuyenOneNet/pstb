// To parse this JSON data, do
//
//     final NewModel = NewModelFromJson(jsonString);

import 'dart:convert';

class NewModel {
  NewModel({
    this.pageSize,
    this.pageIndex,
    this.tags,
    this.shareUrl,
  });

  int? pageSize;
  int? pageIndex = 0;
  String? tags;
  String? shareUrl;
  factory NewModel.fromRawJson(String str) =>
      NewModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NewModel.fromJson(Map<String, dynamic> json) => NewModel(
        pageSize: json["pageSize"],
        pageIndex: json["pageIndex"],
        tags: json["tags"],
      shareUrl:json["shareUrl"]
      );

  Map<String, dynamic> toJson() => {
        "pageIndex": pageIndex,
        "pageSize": pageSize,
        "tags": tags,
      };
}

class NewsDetailModel {
  NewsDetailModel({
    this.id,
  });

  dynamic id;

  factory NewsDetailModel.fromRawJson(String str) =>
      NewsDetailModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NewsDetailModel.fromJson(Map<String, dynamic> json) =>
      NewsDetailModel(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
