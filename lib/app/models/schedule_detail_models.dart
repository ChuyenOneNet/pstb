
import 'examination_results_model.dart';

class ScheduleDetailResultModel {
  final String title, diagnose, time, place;

  ScheduleDetailResultModel({
    required this.title,
    required this.diagnose,
    required this.time,
    required this.place,
  });
}

class ScheduleDetailPrescriptionModel {
  final String title, time, presciptionStatus, doctor;

  ScheduleDetailPrescriptionModel({
    required this.title,
    required this.time,
    required this.presciptionStatus,
    required this.doctor,
  });
}

class ScheduleDetailAssignModel {
  final String title, time;
  String? place, pdf;
  List<ChitietCt>? listTestResult;

  ScheduleDetailAssignModel(
      {required this.title,
        required this.time,
        this.listTestResult,
        this.place,
        this.pdf});
}

class ScheduleDetailModel {
  final String title, doctor, scheduleSampleTime, scheduleExamTime, place;
  ScheduleDetailPrescriptionModel? prescription;
  String? symptom, diagnose, conclusion, result;
  List<ScheduleDetailAssignModel>? assign;

  ScheduleDetailModel(
      {required this.title,
        required this.doctor,
        required this.scheduleSampleTime,
        required this.scheduleExamTime,
        required this.place,
        this.result,
        this.prescription,
        this.diagnose,
        this.symptom,
        this.conclusion,
        this.assign});
}