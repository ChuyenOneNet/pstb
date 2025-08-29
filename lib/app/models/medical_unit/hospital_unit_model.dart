import 'package:intl/intl.dart';

import '../../../utils/constants.dart';

class HospitalModel {
  int? id;
  int? reviewCounter;
  dynamic aveRate;
  String? name, shortName,  code, image, address ;
  DateTime? OpenedTime, ClosedTime;
  bool status = false;
  bool isChoose = false;
  HospitalModel(
      {this.id = 0,
        this.reviewCounter,
        this.aveRate,
        this.name = '',
        this.shortName = '',
        this.code = '',
        this.image = '',
        this.ClosedTime,
        this.OpenedTime,
        this.address = ''});

  factory HospitalModel.fromJson(Map<String, dynamic> json) {
    return HospitalModel(
        id: json['id'],
        reviewCounter: json['reviewCounter'],
        aveRate: json['aveRate'],
        name: json['name'],
        shortName: json['shortName'],
        code: json['code'],
        image: json['image'],
        OpenedTime: json['OpenedTime'] != null
            ? DateFormat(DateTimeFormatPattern.formatHHmm)
            .parse(json['OpenedTime'])
            : null,
        ClosedTime: json['ClosedTime'] != null
            ? DateFormat(DateTimeFormatPattern.formatHHmm)
            .parse(json['ClosedTime'])
            : null,
        address: json['address']);
  }
}