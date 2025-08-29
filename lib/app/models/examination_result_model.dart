import 'package:pstb/app/models/medical_record_model.dart';

class ExaminationResultModel {
  final Patient? patient;
  InfoExaminations? examination;
  List<Indications>? indications;

  ExaminationResultModel({this.patient, this.examination, this.indications});

  factory ExaminationResultModel.fromJson(Map<String, dynamic> json) {
    return ExaminationResultModel(
        patient: Patient.fromJson(json['patient']),
        examination: InfoExaminations.fromJson(json['examination']),
        indications: json['indications'] == null
            ? []
            : (json['indications'] as List<dynamic>)
                .map((e) => Indications.fromJson(e as Map<String, dynamic>))
                .toList());
  }
}

class InfoExaminations {
  final String? pulse;
  final String? temperature;
  final String? height;
  final String? weight;
  final String? breathing;
  final String? solution;
  final String? doctorName;
  final String? bloodPressure;

  // final String? bmi;
  final String? reason;
  final String? includingDiseases;
  final String? icdDiseases;
  final String? diagnosis;

  InfoExaminations(
      {this.pulse,
      this.temperature,
      this.height,
      this.weight,
      this.breathing,
      this.bloodPressure,
      // this.bmi,
      this.reason,
      this.solution,
      this.doctorName,
      this.includingDiseases,
      this.icdDiseases,
      this.diagnosis});

  factory InfoExaminations.fromJson(Map<String, dynamic> json) {
    return InfoExaminations(
        pulse: json['pulse'],
        temperature: json['temperature'],
        height: json['height'],
        weight: json['weight'],
        breathing: json['breathing'],
        bloodPressure: json['bloodPressure'],
        reason: json['reason'],
        includingDiseases: json['includingDiseases'],
        icdDiseases: json['icdDiseases'],
        diagnosis: json['diagnosis'],
        solution: json['solution'],
        doctorName: json['doctorName']);
  }
}

class Indications {
  final String? id;
  final String? title;
  final String? code;
  final String? time;
  Indications({this.id, this.title, this.code, this.time});

  factory Indications.fromJson(Map<String, dynamic> json) {
    return Indications(
        id: json['id'],
        title: json['title'],
        code: json['code'],
        time: json['time']);
  }
}

class ResultPdfModel {
  final String? content;
  final String? type;
  final String? url;

  ResultPdfModel({this.content, this.type, this.url});

  factory ResultPdfModel.fromJson(Map<String, dynamic> json) {
    return ResultPdfModel(
      content: json['content'],
      type: json['type'],
      url: json['url'],
    );
  }
}
