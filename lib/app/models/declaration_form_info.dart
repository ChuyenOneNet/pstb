import 'dart:convert';

class DeclarationFormInfo {
  String? name;
  String? dob;
  String? phone;
  String? gender;
  String? relative;
  String? province;
  String? district;
  String? address;
  String? symptom;

  DeclarationFormInfo(
      {this.name,
      this.dob,
      this.phone,
      this.gender,
      this.relative,
      this.province,
      this.district,
      this.address,
      this.symptom});

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "name": name,
        "dob": dob,
        "phone": phone,
        "gender": gender,
        "relative": relative,
        "province": province,
        "district": district,
        "address": address,
        "symptom": symptom,
      };
}
