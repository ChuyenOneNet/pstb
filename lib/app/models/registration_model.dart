class RegistrationModel {
  String? name;
  String? departmentName;
  String? time;
  int? status;

  RegistrationModel({this.name, this.departmentName, this.time, this.status});

  factory RegistrationModel.fromJson(Map<String, dynamic> json) {
    return RegistrationModel(
      name: json['name'],
      departmentName: json['departmentName'],
      time: json['time'],
      status: json['status'],
    );
  }

  @override
  String toString() {
    return 'RegistrationModel{name: $name, departmentName: $departmentName, time: $time, status: $status}';
  }
}
