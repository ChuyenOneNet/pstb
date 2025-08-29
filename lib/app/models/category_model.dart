import 'dart:convert';

class CategoryModel {
  CategoryModel({
    this.id,
    this.name,
    this.slug,
  });

  String? id;
  String? name;
  String? slug;

  factory CategoryModel.fromRawJson(String str) =>
      CategoryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      CategoryModel(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
  };
}
