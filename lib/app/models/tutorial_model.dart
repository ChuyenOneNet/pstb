// To parse this JSON data, do
//
//     final tutorialResponsitory = tutorialResponsitoryFromJson(jsonString);

import 'dart:convert';

class TutorialModel {
  TutorialModel({
    this.id,
    this.status,
    this.title,
    this.image,
    this.description,
    this.created,
  });

  int? id;
  String? status;
  String? title;
  String? image;
  String? description;
  DateTime? created;

  factory TutorialModel.fromRawJson(String str) =>
      TutorialModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TutorialModel.fromJson(Map<String, dynamic> json) => TutorialModel(
        id: json["id"],
        status: json["status"],
        title: json["title"],
        image: json["image"],
        description: json["description"],
        created:
            json["created"] != null ? DateTime.parse(json["created"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "title": title,
        "image": image,
        "description": description,
        "created": created!.toIso8601String(),
      };
}
