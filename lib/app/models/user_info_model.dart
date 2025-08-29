import 'dart:convert';

class UserInfoModel {
  UserInfoModel({
    this.id,
    this.username,
    this.gender,
    this.userAddress,
    this.userVaccine,
    this.lastLogin,
    this.isSuperuser,
    this.firstName,
    this.lastName,
    this.email,
    this.isStaff,
    this.isActive,
    this.dateJoined,
    this.fullName,
    this.phone,
    this.dob,
    this.avatar,
    this.province,
    this.district,
    this.address,
    this.age,
    this.insuranceNumber,
    this.staffCode,
    this.personalId,
  });

  String? id;
  String? username;
  String? gender;
  List<UserAddress>? userAddress;
  List<UserVaccine>? userVaccine;
  dynamic lastLogin;
  bool? isSuperuser;
  String? firstName;
  String? lastName;
  String? email;
  bool? isStaff;
  bool? isActive;
  DateTime? dateJoined;
  String? fullName;
  String? phone;
  String? dob;
  String? avatar;
  String? province;
  String? district;
  String? address;
  int? age;
  String? personalId;
  String? insuranceNumber;
  String? staffCode;

  factory UserInfoModel.fromRawJson(String str) =>
      UserInfoModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
      id: json["id"],
      username: json["username"],
      gender: json["gender"],
      userAddress: json["user_address"] == null
          ? null
          : List<UserAddress>.from(
              json["user_address"].map((x) => UserAddress.fromJson(x))),
      userVaccine: json["user_vaccine"] == null
          ? null
          : List<UserVaccine>.from(
              json["user_vaccine"].map((x) => UserVaccine.fromJson(x))),
      lastLogin: json["last_login"],
      isSuperuser: json["is_superuser"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      email: json["email"],
      isStaff: json["is_staff"],
      isActive: json["is_active"],
      dateJoined: json["date_joined"] == null
          ? null
          : DateTime.parse(json["date_joined"]),
      fullName: json["fullName"],
      phone: json["phone"],
      dob: json["dob"],
      avatar: json["avatar"],
      province: json["province"],
      district: json["district"],
      address: json["address"],
      age: json["age"],
      insuranceNumber: json['insuranceNumber'],
      personalId: json['personalId'],
      staffCode: json['staffCode'],
  );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "gender": gender,
        "fullName": fullName,
        "user_address": userAddress == null
            ? null
            : List<dynamic>.from(userAddress!.map((x) => x.toJson())),
        "user_vaccine": userAddress == null
            ? null
            : List<dynamic>.from(userVaccine!.map((x) => x.toJson())),
        "last_login": lastLogin,
        "is_superuser": isSuperuser,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "is_staff": isStaff,
        "is_active": isActive,
        "date_joined":
            dateJoined == null ? null : dateJoined!.toIso8601String(),
        "name": fullName,
        "phone": phone,
        "dob": dob,
        "avatar": avatar,
        "province": province,
        "district": district,
        "address": address,
        "age": age,
        "insuranceNumber": insuranceNumber,
        "personalId": personalId,
        "staffCode": staffCode,
      };
}

class UserAddress {
  UserAddress({
    this.id,
    this.address,
    this.province,
    this.district,
    this.primary,
    this.type,
    this.created,
  });

  String? id;
  String? address;
  String? province;
  String? district;
  bool? primary;
  String? type;
  DateTime? created;

  factory UserAddress.fromRawJson(String str) =>
      UserAddress.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserAddress.fromJson(Map<String, dynamic> json) => UserAddress(
        id: json["id"],
        address: json["address"],
        province: json["province"],
        district: json["district"],
        primary: json["primary"],
        type: json["type"],
        created:
            json["created"] == null ? null : DateTime.parse(json["created"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "address": address,
        "province": province,
        "district": district,
        "primary": primary,
        "type": type,
        "created": created == null ? null : created!.toIso8601String(),
      };
}

class UserVaccine {
  UserVaccine({
    this.id,
    this.injectionDate,
    this.injectionAddress,
    this.vaccine,
    this.injectionTimes,
    this.created,
  });

  String? id;
  DateTime? injectionDate;
  String? injectionAddress;
  String? vaccine;
  int? injectionTimes;
  DateTime? created;

  factory UserVaccine.fromRawJson(String str) =>
      UserVaccine.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserVaccine.fromJson(Map<String, dynamic> json) => UserVaccine(
        id: json["id"],
        injectionDate: json["injection_date"] == null
            ? null
            : DateTime.parse(json["injection_date"]),
        injectionAddress: json["injection_address"],
        vaccine: json["vaccine"],
        injectionTimes: json["injection_times"],
        created:
            json["created"] == null ? null : DateTime.parse(json["created"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "injection_date":
            injectionDate == null ? null : injectionDate!.toIso8601String(),
        "injection_address": injectionAddress,
        "vaccine": vaccine,
        "injection_times": injectionTimes,
        "created": created == null ? null : created!.toIso8601String(),
      };
}
