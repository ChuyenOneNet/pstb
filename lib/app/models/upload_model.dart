import 'dart:convert';

class UploadModel {
  UploadModel({
    this.id,
    this.file,
    this.created,
  });

  int? id;
  String? file;
  DateTime? created;

  factory UploadModel.fromJson(Map<String, dynamic> json) => UploadModel(
    id: json["id"],
    file: json["file"],
    created: DateTime.parse(json["created"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "file": file,
    "created": created!.toIso8601String(),
  };
}