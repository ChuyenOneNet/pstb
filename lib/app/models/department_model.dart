class DepartmentModel {
  String? id;
  String? code;
  String? name;

  DepartmentModel({this.id, this.code, this.name});

  factory DepartmentModel.fromJson(Map<String, dynamic> json) {
    return DepartmentModel(
      id: json['id'],
      code: json['code'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['code'] = code;
    data['name'] = name;
    return data;
  }
}
