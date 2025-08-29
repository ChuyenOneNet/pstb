class SignRolesModel {
  String? name;
  String? code;
  String? id;
  SignRolesModel({
    this.name,
    this.code,
    this.id,
  });

  factory SignRolesModel.fromJson(Map<String, dynamic> json) {
    return SignRolesModel(
      code: json['code'],
      name: json['name'],
      id: json['id'],
    );
  }
}
