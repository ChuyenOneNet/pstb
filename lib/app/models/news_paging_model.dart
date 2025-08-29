import 'package:pstb/extensions/data_extension.dart';

class NewsPagingItem {
  NewsPagingItem({
    this.id,
    this.status,
    this.tags,
    this.count,
    this.categories,
    this.title,
    this.image,
    this.shortDescription,
    this.description,
    this.slug,
    this.created,
  });

  String? id;
  String? status;
  String? tags;
  int? count;
  List<NewsCategory>? categories;
  String? title;
  String? image;
  String? shortDescription;
  String? description;
  String? slug;
  DateTime? created;

  factory NewsPagingItem.fromJson(Map<String, dynamic> json) => NewsPagingItem(
        id: json["id"],
        status: json["status"],
        tags: json["tags"],
        count: json["count"],
        categories: json.tryGetList<NewsCategory>(
            "categories", (x) => NewsCategory.fromJson(x)),
        title: json["title"],
        image: json["image"],
        shortDescription: json["shortDescription"],
        description: json["description"],
        slug: json["slug"],
        // created: DateTime.parse(json["created"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "tags": tags,
        "count": count,
        "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
        "title": title,
        "image": image,
        "short_description": shortDescription,
        "description": description,
        "slug": slug,
        "created": created!.toIso8601String(),
      };
}

class NewsCategory {
  NewsCategory({
    this.name,
  });

  String? name;

  factory NewsCategory.fromJson(Map<String, dynamic> json) => NewsCategory(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
