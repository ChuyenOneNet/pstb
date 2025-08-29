// To parse this JSON data, do
//
//     final userAddressModel = userAddressModelFromJson(jsonString);

import 'dart:convert';

class UserAddressModel {
    UserAddressModel({
        this.address,
        this.province,
        this.district,
        this.type,
        this.primary,
    });

    String? address;
    String? province;
    String? district;
    String? type;
    bool? primary;

    factory UserAddressModel.fromRawJson(String str) => UserAddressModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UserAddressModel.fromJson(Map<String, dynamic> json) => UserAddressModel(
        address: json["address"] == null ? null : json["address"],
        province: json["province"] == null ? null : json["province"],
        district: json["district"] == null ? null : json["district"],
        type: json["type"] == null ? null : json["type"],
        primary: json["primary"] == null ? null : json["primary"],
    );

    Map<String, dynamic> toJson() => {
        "address": address == null ? null : address,
        "province": province == null ? null : province,
        "district": district == null ? null : district,
        "type": type == null ? null : type,
        "primary": primary == null ? null : primary,
    };
}
