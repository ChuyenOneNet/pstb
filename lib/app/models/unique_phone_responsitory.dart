import 'dart:convert';

class UniquePhoneModel {
  UniquePhoneModel({
    this.phone,
  });

  String? phone;

  factory UniquePhoneModel.fromRawJson(String str) => UniquePhoneModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UniquePhoneModel.fromJson(Map<String, dynamic> json) => UniquePhoneModel(
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "phone": phone,
      };
}
