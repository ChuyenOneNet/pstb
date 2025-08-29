class PatientModel {
  String? code;
  String? name;
  String? id;
  String? age;
  String? departmentName;
  int? gender;
  PatientModel({this.code, this.name, this.id, this.age, this.gender,this.departmentName});

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      code: json['code'],
      name: json['name'],
      id: json['id'],
      gender: json['gender'],
      age: json['age'],
      departmentName: json["departmentName"],
    );
  }
}

class PatientQrModel extends PatientModel {
  String? qrCode;

  PatientQrModel({
    String? code,
    String? name,
    String? id,
    String? age,
    this.qrCode,
  }) : super(code: code, name: name, id: id, age: age);

  factory PatientQrModel.fromJson(Map<String, dynamic> json) {
    return PatientQrModel(
      code: json['code'],
      name: json['name'],
      id: json['id'],
      age: json['age'],
      qrCode: json['qrCode']
    );
  }
}

class PatientBookingModel {
  String? name;
  String? dob;
  int? gender;
  String? phone;
  String? email;
  String? personalId;
  String? insuranceNumber;
  String? address;

  PatientBookingModel(
      {this.name,
      this.dob,
      this.gender,
      this.phone,
      this.email,
      this.personalId,
      this.insuranceNumber,
      this.address});

  factory PatientBookingModel.fromJson(Map<String, dynamic> json) {
    return PatientBookingModel(
        name: json['name'],
        dob: json['dob'],
        gender: json['gender'],
        phone: json['phone'],
        email: json['email'],
        personalId: json['personalId'],
        insuranceNumber: json['insuranceNumber'],
        address: json['address']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['dob'] = dob;
    data['gender'] = gender;
    data['phone'] = phone;
    data['email'] = email;
    data['personalId'] = personalId;
    data['insuranceNumber'] = insuranceNumber;
    data['address'] = address;
    return data;
  }
}
