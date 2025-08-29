class Prescription {
  final String? id;
  final String? title;
  final String? doctorId;
  final String? type;
  final String? typeName;

  Prescription(
      { this.id,
        this.title,
        this.doctorId,
        this.type,
        this.typeName,});

  factory Prescription.fromJson(Map<String, dynamic> json) {
    return Prescription(
        id: json['id'],
        title: json['title'],
        doctorId: json['doctorId'],
        type: json['type'],
        typeName: json['typeName'],);
  }
}
