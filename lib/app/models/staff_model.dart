class StaffModel {
  String? userName;
  String? password;

  StaffModel(
    this.userName,
    this.password,
  );

  factory StaffModel.fromJson(Map<String, dynamic> json) => StaffModel(
        json["userName"],
        json["password"],
      );

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "password": password,
      };
}
