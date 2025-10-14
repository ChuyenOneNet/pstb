class RequestHistory {
  final int? id;
  final String userPhone;
  final String requestId;
  final String patientName;
  final String? cccd;
  final int? age;
  final int? gender;
  final String? birthDate;
  final String? jobName;
  final String? job;
  final String? addressDetail;
  final String? phone;
  final String? fatherName;
  final String? motherName;
  final String? idIssueDate;
  final String? idIssuePlace;
  final String? nationalId;
  final String? ethnic;
  final String? provinceId;
  final String? communeWardId;
  final String? nationalName;
  final String? ethnicName;
  final String? provinceName;
  final String? communeWardName;
  final String? examTypeId;
  final String? examTypeName;
  final String? clinicRoomCode;
  final String? roomName;
  final String? reason;
  final String? priority;
  final String? arrivalMethod;
  final String createdAt;
  final String pdfPath;
  final bool hasInsurance;
  final String? price;

  RequestHistory({
    this.id,
    required this.userPhone,
    required this.requestId,
    required this.patientName,
    this.cccd,
    this.age,
    this.gender,
    this.birthDate,
    this.jobName,
    this.job,
    this.addressDetail,
    this.phone,
    this.fatherName,
    this.motherName,
    this.idIssueDate,
    this.idIssuePlace,
    this.nationalId,
    this.ethnic,
    this.provinceId,
    this.communeWardId,
    this.nationalName,
    this.ethnicName,
    this.provinceName,
    this.communeWardName,
    this.examTypeId,
    this.examTypeName,
    this.clinicRoomCode,
    this.roomName,
    this.reason,
    this.priority,
    this.arrivalMethod,
    required this.createdAt,
    required this.pdfPath,
    this.hasInsurance = false,
    this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userPhone': userPhone,
      'requestId': requestId,
      'patientName': patientName,
      'cccd': cccd,
      'age': age,
      'gender': gender,
      'birthDate': birthDate,
      'jobName': jobName,
      'job': job,
      'addressDetail': addressDetail,
      'phone': phone,
      'fatherName': fatherName,
      'motherName': motherName,
      'idIssueDate': idIssueDate,
      'idIssuePlace': idIssuePlace,
      'nationalId': nationalId,
      'ethnic': ethnic,
      'provinceId': provinceId,
      'communeWardId': communeWardId,
      'nationalName': nationalName,
      'ethnicName': ethnicName,
      'provinceName': provinceName,
      'communeWardName': communeWardName,
      'examTypeId': examTypeId,
      'examTypeName': examTypeName,
      'clinicRoomCode': clinicRoomCode,
      'roomName': roomName,
      'reason': reason,
      'priority': priority,
      'arrivalMethod': arrivalMethod,
      'createdAt': createdAt,
      'pdfPath': pdfPath,
      'hasInsurance': hasInsurance ? 1 : 0,
      'price': price,
    };
  }

  // helper parsers to be robust when DB returns string/int/bool

  factory RequestHistory.fromMap(Map<String, dynamic> map) {
    return RequestHistory(
      id: map['id'] as int?,
      userPhone: map['userPhone'] ?? '',
      requestId: map['requestId'] ?? '',
      patientName: map['patientName'] ?? '',
      cccd: map['cccd'],
      age: map['age'],
      gender: map['gender'],
      birthDate: map['birthDate'],
      jobName: map['jobName'],
      job: map['job'],
      addressDetail: map['addressDetail'],
      phone: map['phone'],
      fatherName: map['fatherName'],
      motherName: map['motherName'],
      idIssueDate: map['idIssueDate'],
      idIssuePlace: map['idIssuePlace'],
      nationalId: map['nationalId'],
      ethnic: map['ethnic'],
      provinceId: map['provinceId'],
      communeWardId: map['communeWardId'],
      nationalName: map['nationalName'],
      ethnicName: map['ethnicName'],
      provinceName: map['provinceName'],
      communeWardName: map['communeWardName'],
      examTypeId: map['examTypeId'],
      examTypeName: map['examTypeName'],
      clinicRoomCode: map['clinicRoomCode'],
      roomName: map['roomName'],
      reason: map['reason'],
      priority: map['priority'],
      arrivalMethod: map['arrivalMethod'],
      createdAt: map['createdAt'],
      pdfPath: map['pdfPath'],
      hasInsurance: (map['hasInsurance'] ?? 0) == 1,
      price: map['price'],
    );
  }
}
