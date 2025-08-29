class NurseModel {
  String? code;
  String? name;
  String? departmentName;
  int? pulse;
  int? breathing;
  String? time;
  String? bloodPressure;
  String? progression;
  String? attentionInformation;
  double? temperature;
  String? staffCode;
  String? patientCode;
  String? id;
  String? bloodPressureMax;
  String? bloodPressureMin;
  String? disease;
  String? unSign;
  String? paSign;
  String? emSign;

  NurseModel({
    this.pulse,
    this.breathing,
    this.id,
    this.temperature,
    this.time,
    this.bloodPressure,
    this.progression,
    this.attentionInformation,
    this.name,
    this.code,
    this.disease,
    this.patientCode,
    this.staffCode,
    this.bloodPressureMax,
    this.bloodPressureMin,
    this.departmentName,
    this.unSign,
    this.paSign,
    this.emSign,
  });

  factory NurseModel.fromJson(Map<String, dynamic> json) {
    return NurseModel(
      code: json['code'],
      name: json['name'],
      time: json['time'],
      id: json["id"],
      disease: json['disease'],
      breathing:
          (json['breathing'] == null || json['breathing'].toString().isEmpty)
              ? null
              : int.tryParse(json['breathing'].toString()),
      temperature: (json['temperature'] == null ||
              json['temperature'].toString().isEmpty)
          ? null
          : double.tryParse(json['temperature'].toString()),
      pulse: (json['pulse'] == null || json['pulse'].toString().isEmpty)
          ? null
          : int.tryParse(json['pulse'].toString()),
      bloodPressureMax: json['bloodPressureMax'],
      bloodPressureMin: json['bloodPressureMin'],
      progression: json['progression'] ?? "",
      attentionInformation: json['attentionInformation'] ?? "",
      departmentName: json['departmentName'],
      unSign: json['userNameBCY'],
      paSign: json['passWordBCY'],
      emSign: json['emSign'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "code": code,
      "name": name,
      "time": time,
      "id": id,
      "disease": disease,
      "breathing": breathing,
      "temperature": temperature,
      "pulse": pulse,
      "bloodPressureMax": bloodPressureMax,
      "bloodPressureMin": bloodPressureMin,
      "progression": progression,
      "attentionInformation": attentionInformation,
      "departmentName": departmentName,
      "patientCode": patientCode,
      "staffCode": staffCode,
      "userNameBCY": unSign,
      "passWordBCY": paSign,
      "emSign": emSign,
    };
  }
}
