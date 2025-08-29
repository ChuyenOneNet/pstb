class EmergencyModel {
  EmergencyModel({
    this.id,
    this.title,
    this.image,
    this.shortDescription,
    this.description,
    this.slug,
    // this.created,
    // this.status,
  });

  int? id;
  String? title;
  String? image;
  String? shortDescription;
  String? description;
  String? slug;

  // DateTime? created;
  // int? status;

  factory EmergencyModel.fromJson(Map<String, dynamic> json) => EmergencyModel(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        shortDescription:
            json["shortDescription"],
        description: json["description"],
        slug: json["slug"],
        // created:
        //     json["created"] == null ? null : DateTime.parse(json["created"]),
        // status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        // "status": status == null ? null : status,
        "image": image,
        "short_description": shortDescription,
        "description": description,
        "slug": slug,
        // "created": created == null ? null : created!.toIso8601String(),
      };
}
