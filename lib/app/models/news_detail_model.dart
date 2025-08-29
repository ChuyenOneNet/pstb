// To parse this JSON data, do
//
//     final newsDetailResponsitory = newsDetailResponsitoryFromJson(jsonString);

import 'dart:convert';

import 'package:pstb/extensions/data_extension.dart';

class NewsDetailModel {
  NewsDetailModel({
    this.id,
    this.tags,
    this.count,
    this.categories,
    this.title,
    this.image,
    this.description,
    this.shortDescription,
    this.slug,
    this.created,
  });

  String? shortDescription;
  String? id;
  String? tags;
  int? count;
  List<Category>? categories;
  String? title;
  dynamic image;
  String? description;
  String? slug;
  DateTime? created;

  factory NewsDetailModel.fromRawJson(String str) =>
      NewsDetailModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NewsDetailModel.fromJson(Map<String, dynamic> json) =>
      NewsDetailModel(
        id: json["id"],
        tags: json["tags"],
        count: json["count"],
        categories: json.tryGetList<Category>(
            'categories', (x) => Category.fromJson(x)),
        title: json["title"],
        image: json["image"],
        description: json["description"],
        shortDescription: json["shortDescription"],
        slug: json["slug"],
        // created: DateTime.parse(json["created"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tags": tags,
        "count": count,
        "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
        "title": title,
        "image": image,
        "description": description,
        "slug": slug,
        "created": created!.toIso8601String(),
      };
}

class Category {
  Category({
    this.name,
  });

  String? name;

  factory Category.fromRawJson(String str) =>
      Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
