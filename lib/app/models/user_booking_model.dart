// To parse this JSON data, do
//
//     final userBookingModel = userBookingModelFromJson(jsonString);

import 'dart:convert';

class UserBookingModel {
  UserBookingModel({
    this.limit,
    this.offset,
    this.status,
  });

  String? limit;
  String? offset;
  String? status;

  factory UserBookingModel.fromRawJson(String str) =>
      UserBookingModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserBookingModel.fromJson(Map<String, dynamic> json) =>
      UserBookingModel(
        limit: json["limit"],
        offset: json["offset"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "limit": limit,
        "offset": offset,
        "status": status,
      };
}
