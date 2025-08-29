import 'package:intl/intl.dart';

import '../../utils/constants.dart';

class DetailHospitalModel {
  int? id;
  String? name;
  String? image;
  DateTime? openTime;
  DateTime? closedTime;
  String? description;
  int? numberExamination;
  int? rating;
  String? code;
  String? address;
  int? reviewCounter;
  dynamic aveRate;

  DetailHospitalModel(
      {this.id,
        this.name,
        this.image,
        this.openTime,
        this.closedTime,
        this.description,
        this.numberExamination,
        this.code,
        this.address,
        this.rating,
        this.reviewCounter,
        this.aveRate,
      });

  DetailHospitalModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    openTime = json['openTime'] != null
        ? DateFormat(DateTimeFormatPattern.formatHHmm)
        .parse(json['openTime'])
        : null;
    closedTime = json['closedTime'] != null
        ? DateFormat(DateTimeFormatPattern.formatHHmm)
        .parse(json['closedTime'])
        : null;
    description = json['description'];
    numberExamination = json['numberExamination'];
    rating = json['rating'];
    code = json['code'];
    address = json['address'];
    reviewCounter = json['reviewCounter'];
    aveRate = json['aveRate'];
  }
}