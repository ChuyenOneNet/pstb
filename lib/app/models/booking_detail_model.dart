import 'package:intl/intl.dart';
import 'package:pstb/utils/constants.dart';

class Booking {
  int? patientId;
  String? patientPhone;
  int? patientGender;
  DateTime? patientDob;
  int? id;
  String? doctorName;
  int? doctorId;
  String? packageName;
  String? packageImage;
  String? packageId;
  int? discount;
  int? originalPrice;
  int? price;
  DateTime? timeSeeDoctor;
  DateTime? timeGetSample;
  String? qrCode;
  String? code;

  Booking({
    this.id,
    this.doctorName,
    this.doctorId,
    this.packageName,
    this.packageImage,
    this.packageId,
    this.discount,
    this.originalPrice,
    this.price,
    this.timeSeeDoctor,
    this.timeGetSample,
    this.qrCode,
    this.code,
    this.patientDob,
    this.patientId,
    this.patientPhone,
    this.patientGender,
  });

  Booking.fromJson(Map<String, dynamic> json) {
    patientId = json['patientId'];
    patientPhone = json['patientPhone'];
    patientGender = json['patientGender'];
    patientDob = json['patientDob'] != null
        ? DateFormat(DateTimeFormatPattern.backendTimeFormat)
            .parse(json['patientDob'])
        : null;
    id = json['id'];
    doctorName = json['doctorName'];
    doctorId = json['doctorId'];
    packageName = json['packageName'];
    packageImage = json['packageImage'];
    packageId = json['packageId'];
    discount = json['discount'];
    originalPrice = json['originalPrice'];
    price = json['price'];
    timeSeeDoctor = json['timeSeeDoctor'] != null
        ? DateFormat(DateTimeFormatPattern.backendTimeFormat)
            .parse(json['timeSeeDoctor'])
        : null;
    timeGetSample = json['timeGetSample'] != null
        ? DateFormat(DateTimeFormatPattern.backendTimeFormat)
            .parse(json['timeGetSample'])
        : null;
    qrCode = json['qrCode'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['patientId'] = patientId;
    data['patientPhone'] = patientPhone;
    data['patientGender'] = patientGender;
    data['patientDob'] = patientDob;
    data['id'] = id;
    data['doctorName'] = doctorName;
    data['doctorId'] = doctorId;
    data['packageName'] = packageName;
    data['packageImage'] = packageImage;
    data['packageId'] = packageId;
    data['discount'] = discount;
    data['originalPrice'] = originalPrice;
    data['price'] = price;
    data['timeSeeDoctor'] = timeSeeDoctor;
    data['timeGetSample'] = timeGetSample;
    data['qrCode'] = qrCode;
    data['code'] = code;
    return data;
  }
}
