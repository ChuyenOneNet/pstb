class TagItemModel {
  TagItemModel({
    this.slug,
  });

  String? slug;

  factory TagItemModel.fromJson(Map<String, dynamic> json) => TagItemModel(
        slug: json["slug"],
      );

  Map<String, dynamic> toJson() => {
        "slug": slug,
      };
}
