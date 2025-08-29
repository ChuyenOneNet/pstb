import 'package:pstb/app/models/department_model.dart';
import 'package:pstb/app/models/patient_model.dart';

class IndicationModel {
  String? id;
  DepartmentModel? departmentModel;

  IndicationModel({this.id, this.departmentModel, this.patientQrModel});

  PatientQrModel? patientQrModel;

  factory IndicationModel.fromJson(Map<String, dynamic> json) {
    return IndicationModel(
        id: json['id'],
        departmentModel: DepartmentModel.fromJson(json['department']),
        patientQrModel: PatientQrModel.fromJson(json['patient']));
  }
}
