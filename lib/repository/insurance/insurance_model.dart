import 'dart:convert';

class InsuranceModel {
  InsuranceModel({
    this.status,
    this.code,
    this.data,
    this.message,
  });

  String? status;
  int? code;
  Data? data;
  dynamic message;

  factory InsuranceModel.fromRawJson(String str) =>
      InsuranceModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InsuranceModel.fromJson(Map<String, dynamic> json) =>
      InsuranceModel(
        status: json["status"],
        code: json["code"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "data": data == null ? null : data!.toJson(),
        "message": message,
      };
}

class Data {
  Data({
    this.id,
    this.user,
    this.idInsurance,
    this.type,
    this.address,
    this.registerLocation,
    this.expiredDate,
    this.created,
  });

  String? id;
  User? user;
  String? idInsurance;
  int? type;
  String? address;
  String? registerLocation;
  DateTime? expiredDate;
  DateTime? created;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        idInsurance: json["id_insurance"],
        type: json["type"],
        address: json["address"],
        registerLocation: json["register_location"],
        expiredDate: json["expired_date"] == null
            ? null
            : DateTime.parse(json["expired_date"]),
        created:
            json["created"] == null ? null : DateTime.parse(json["created"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user == null ? null : user!.toJson(),
        "id_insurance": idInsurance,
        "type": type,
        "address": address,
        "register_location": registerLocation,
        "expired_date": expiredDate == null
            ? null
            : "${expiredDate!.year.toString().padLeft(4, '0')}-${expiredDate!.month.toString().padLeft(2, '0')}-${expiredDate!.day.toString().padLeft(2, '0')}",
        "created": created == null ? null : created!.toIso8601String(),
      };
}

class User {
  User({
    this.id,
    this.username,
    this.gender,
    this.userAddress,
    this.lastLogin,
    this.isSuperuser,
    this.firstName,
    this.lastName,
    this.email,
    this.isStaff,
    this.isActive,
    this.dateJoined,
    this.name,
    this.phone,
    this.dob,
    this.profilePicture,
    this.province,
    this.district,
    this.address,
  });

  int? id;
  String? username;
  String? gender;
  List<dynamic>? userAddress;
  dynamic lastLogin;
  bool? isSuperuser;
  String? firstName;
  String? lastName;
  String? email;
  bool? isStaff;
  bool? isActive;
  DateTime? dateJoined;
  String? name;
  String? phone;
  dynamic dob;
  dynamic profilePicture;
  dynamic province;
  dynamic district;
  dynamic address;

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        gender: json["gender"],
        userAddress: json["user_address"] == null
            ? null
            : List<dynamic>.from(json["user_address"].map((x) => x)),
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
        name: json["name"],
        phone: json["phone"],
        dob: json["dob"],
        profilePicture: json["profile_picture"],
        province: json["province"],
        district: json["district"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "gender": gender,
        "user_address": userAddress == null
            ? null
            : List<dynamic>.from(userAddress!.map((x) => x)),
        "last_login": lastLogin,
        "is_superuser": isSuperuser,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "is_staff": isStaff,
        "is_active": isActive,
        "date_joined":
            dateJoined == null ? null : dateJoined!.toIso8601String(),
        "name": name,
        "phone": phone,
        "dob": dob,
        "profile_picture": profilePicture,
        "province": province,
        "district": district,
        "address": address,
      };
}
