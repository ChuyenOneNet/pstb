import 'dart:convert';

class SearchModel {
  SearchModel(
      {this.slug,
      this.categorySlug,
      this.priceHigher,
      this.priceLower,
      this.ordering,
      this.parentId,
      this.atHomeOption,
      this.categoryGroupId});

  String? slug;
  String? categorySlug;
  String? priceHigher;
  String? priceLower;
  String? ordering;
  String? categoryGroupId;
  String? categoryGroupIds;
  String? parentId;
  String? atHomeOption;

  factory SearchModel.fromRawJson(String str) =>
      SearchModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        slug: json["packageSlug"] == null ? null : json["slug"],
        categorySlug:
            json["categorySlug"] == null ? null : json["category__slug"],
        priceHigher: json["priceLower"] == null ? null : json["price__gte"],
        priceLower: json["priceHigher"] == null ? null : json["price__lte"],
        ordering: json["ordering"] == null ? null : json["ordering"],
      );

  Map<String, dynamic> toJson() => {
        "slug": slug == null ? null : slug,
        "category__slug": categorySlug == null ? null : categorySlug,
        "price__gte": priceHigher == null ? null : priceHigher,
        "price__lte": priceLower == null ? null : priceLower,
        "ordering": ordering == null ? null : ordering,
        "categoryGroupId": categoryGroupId == null ? "" : categoryGroupId,
        'parentId': parentId ?? "",
        'atHomeOption': atHomeOption ?? ""
      };
}
