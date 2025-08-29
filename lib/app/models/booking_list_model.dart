import 'package:pstb/utils/constants.dart';
import 'package:intl/intl.dart';

class BookingItem {
  BookingItem({
    this.id,
    this.status,
    this.packageId,
    this.packageName,
    this.notes,
    this.address,
    this.created,
    this.doctor,
    this.doctorName,
    this.maHoSo,
    this.seen,
    this.timeSeeDoctor,
    this.timeGetSample,
  });

  int? id;
  int? packageId;
  String? packageName;
  int? status;
  String? notes;
  String? address;
  // DateTime? startExaminationTime;
  // DateTime? endExaminationTime;
  DateTime? timeSeeDoctor;
  // dynamic startTestTime;
  // dynamic endTestTime;
  DateTime? created;
  String? doctor;
  String? doctorName;
  int? maHoSo;
  bool? seen;
  DateTime? timeGetSample;

  factory BookingItem.fromJson(Map<String, dynamic> json) => BookingItem(
        id: json["id"],
        status: json["status"],
        notes: json["notes"],
        address: json["address"],
        created:
            json["created"] == null ? null : DateTime.parse(json["created"]),
        doctor: json["doctor"],
        doctorName: json["doctorName"],
        packageName: json["packageName"],
        maHoSo: json["ma_ho_so"],
        seen: json["seen"],
        timeSeeDoctor: json['timeSeeDoctor'] == null
            ? null
            : DateFormat(DateTimeFormatPattern.backendTimeFormat)
                .parse(json['timeSeeDoctor']),
        timeGetSample: json['timeGetSample'] == null
            ? null
            : DateFormat(DateTimeFormatPattern.backendTimeFormat)
                .parse(json['timeGetSample']),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "notes": notes,
        "address": address,
        "created": created == null ? null : created!.toIso8601String(),
        "doctor": doctor,
        "doctor_name": doctorName,
        "ma_ho_so": maHoSo,
        "seen": seen,
      };
}
