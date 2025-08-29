// To parse this JSON data, do
//
//     final scheduleTimeVisitDoctor = scheduleTimeVisitDoctorFromJson(jsonString);

import 'dart:convert';

class ScheduleTimeVisitDoctor {
  ScheduleTimeVisitDoctor({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int? count;
  dynamic next;
  dynamic previous;
  List<Result>? results;

  factory ScheduleTimeVisitDoctor.fromRawJson(String str) =>
      ScheduleTimeVisitDoctor.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ScheduleTimeVisitDoctor.fromJson(Map<String, dynamic> json) =>
      ScheduleTimeVisitDoctor(
        count: json["count"] == null ? null : json["count"],
        next: json["next"],
        previous: json["previous"],
        results: json["results"] == null
            ? null
            : List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count == null ? null : count,
        "next": next,
        "previous": previous,
        "results": results == null
            ? null
            : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.startExaminationTime,
    this.endExaminationTime,
    this.startTestTime,
    this.endTestTime,
    this.status,
  });

  DateTime? startExaminationTime;
  DateTime? endExaminationTime;
  DateTime? startTestTime;
  DateTime? endTestTime;
  int? status;

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        startExaminationTime: json["start_examination_time"] == null
            ? null
            : DateTime.parse(json["start_examination_time"]),
        endExaminationTime: json["end_examination_time"] == null
            ? null
            : DateTime.parse(json["end_examination_time"]),
        startTestTime: json["start_test_time"] == null
            ? null
            : DateTime.parse(json["start_test_time"]),
        endTestTime: json["end_test_time"] == null
            ? null
            : DateTime.parse(json["end_test_time"]),
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "start_examination_time": startExaminationTime == null
            ? null
            : startExaminationTime!.toIso8601String(),
        "end_examination_time": endExaminationTime == null
            ? null
            : endExaminationTime!.toIso8601String(),
        "start_test_time":
            startTestTime == null ? null : startTestTime!.toIso8601String(),
        "end_test_time":
            endTestTime == null ? null : endTestTime!.toIso8601String(),
        "status": status == null ? null : status,
      };
}
