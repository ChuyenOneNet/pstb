// To parse this JSON data, do
//
//     final offerModel = offerModelFromJson(jsonString);

import 'dart:convert';

class PromotionGetModel {
  PromotionGetModel({
    this.status,
    this.priority,
    // ignore: non_constant_identifier_names
    required this.priorities,
    this.page,
  });

  String? status;
  String? priority;

  // ignore: non_constant_identifier_names
  String priorities;
  String? page;

  factory PromotionGetModel.fromRawJson(String str) =>
      PromotionGetModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PromotionGetModel.fromJson(Map<String, dynamic> json) => PromotionGetModel(
        status: json["status"] ,
        priority: json["priority"],
        priorities: json["priorities"],
        page: json["page"],
      );

  Map<String, dynamic> toJson() => {
        "status": status ?? "",
        "priority": priority ?? "",
        "priorities": priorities,
        "page": page ?? "",
      };
}
