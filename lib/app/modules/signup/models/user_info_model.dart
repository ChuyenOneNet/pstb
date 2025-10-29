// lib/app/modules/signup/models/user_info_model.dart
import 'dart:convert';

class UserInfoModel {
  final String name; // Họ tên
  final String email;
  final String dob; // ví dụ: "dd/MM/yyyy 00:00" (đã format sẵn)
  final String gender; // "m" | "f" | "u"
  final String personalId; // CCCD/CMND - BẮT BUỘC
  final String? address;
  final String? insuranceNumber;

  UserInfoModel({
    required this.name,
    required this.email,
    required this.dob,
    required this.gender,
    required this.personalId,
    this.address,
    this.insuranceNumber,
  });

  Map<String, dynamic> toJson() => {
        "fullname": name,
        "email": email,
        "dob": dob,
        "gender": gender,
        "personalId": personalId,
        if (address != null) "address": address,
        if (insuranceNumber != null) "insuranceNumber": insuranceNumber,
      };

  String toRawJson() => json.encode(toJson());

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
        name: json["fullname"] ?? json["name"] ?? "",
        email: json["email"] ?? "",
        dob: json["dob"] ?? "",
        gender: (json["gender"] ?? "u").toString(),
        personalId: (json["personalId"] ?? "").toString(),
        address: json["address"],
        insuranceNumber: json["insuranceNumber"],
      );

  factory UserInfoModel.fromRawJson(String str) =>
      UserInfoModel.fromJson(json.decode(str));
}
