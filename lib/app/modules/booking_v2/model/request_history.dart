class RequestHistory {
  final int? id;
  final String requestId;
  final String patientName;
  final String examTypeName;
  final String roomName;
  final String createdAt;
  final String pdfPath;
  final String userPhone;

  RequestHistory({
    this.id,
    required this.requestId,
    required this.patientName,
    required this.examTypeName,
    required this.roomName,
    required this.createdAt,
    required this.pdfPath,
    required this.userPhone,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'requestId': requestId,
      'patientName': patientName,
      'examTypeName': examTypeName,
      'roomName': roomName,
      'createdAt': createdAt,
      'pdfPath': pdfPath,
      'userPhone': userPhone,
    };
  }

  factory RequestHistory.fromMap(Map<String, dynamic> map) {
    return RequestHistory(
      id: map['id'],
      requestId: map['requestId'],
      patientName: map['patientName'],
      examTypeName: map['examTypeName'],
      roomName: map['roomName'],
      createdAt: map['createdAt'],
      pdfPath: map['pdfPath'],
      userPhone: map['userPhone'],
    );
  }
}
