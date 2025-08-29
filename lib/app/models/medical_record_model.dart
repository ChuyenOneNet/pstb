
class ResponseRecordModel {
  final bool? status;
  final MedicalRecordModel? data;

  ResponseRecordModel({this.status, this.data});

  factory ResponseRecordModel.fromJson(Map<String, dynamic> json) {
    return ResponseRecordModel(
      status: json['status'],
      data : json['data'] == null ? null : MedicalRecordModel.fromJson(json['data']),
    );
  }
}

class PatientRecordModel {
  final List<Patient>? patients;

  PatientRecordModel({this.patients});

  factory PatientRecordModel.fromJson(List<dynamic> json) {
    return PatientRecordModel(
      patients: (json)
          .map((e) =>
          Patient.fromJson(e)).toList(),
    );
  }
}

class MedicalRecordModel {
  final Patient? patient;
  final List<Examination>? examinations;

  MedicalRecordModel({this.patient, this.examinations});

  factory MedicalRecordModel.fromJson(Map<String, dynamic> json) {
    return MedicalRecordModel(
      patient: Patient.fromJson(json['patient']),
      examinations: (json['examinations'] as List<dynamic>)
          .map((e) =>
          Examination.fromJson(e as Map<String, dynamic>))
          .toList()
    );
  }
}

class Patient {
  final String? name;
  final String? code;
  final String? dateOfBirth;
  final String? phone;
  final String? address;
  final String? id;

  Patient({this.name, this.code, this.dateOfBirth, this.phone, this.address, this.id});

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      name: json['name'],
      code: json['code'],
      dateOfBirth: json['dateOfBirth'],
      phone: json['phone'],
      address: json['address'],
      id: json['id'],
    );
  }
}

class Examination {
  final String? time;
  final String? icd;
  final String? registrationId;

  Examination({this.time, this.icd, this.registrationId});

  factory Examination.fromJson(Map<String, dynamic> json) {
    return Examination(
        time: json['time'],
        icd: json['icd'],
        registrationId: json['registrationId']);
  }
}
