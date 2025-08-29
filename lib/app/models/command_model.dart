class CommandModel {
  String? progression;
  String? nameDoctor;
  String? nutrition;
  String? careMode;
  String? prescription;
  List<Medicines>? medicines;
  List<Service>? service;
  String? id;
  String? time;
  String? createDatetime;
  String? textDate;
  String? careLevel;
  CommandModel(
      {this.progression,
      this.nameDoctor,
      this.nutrition,
      this.careMode,
      this.prescription,
      this.createDatetime,
      this.medicines,
      this.service,
      this.id,
        this.careLevel,
      this.textDate,
      this.time});
  factory CommandModel.fromJson(Map<String, dynamic> json) {
    return CommandModel(
        progression: json['progression'],
        nameDoctor: json['nameDoctor'],
        nutrition: json['nutrition'],
        careMode: json['careMode'],
        prescription: json['prescription'],
        careLevel: json['careLevel'],
        medicines: json['medicines'] == null
            ? null
            : (json['medicines'] as List)
            .map((e) => Medicines.fromJson(e))
            .toList(),
        createDatetime: json['createDateTime'],
        id: json['id'],
        textDate: json['textDate'],
        time: json['time'],
        service: json['service'] == null
            ? null
            : (json['service'] as List)
                .map((e) => Service.fromJson(e))
                .toList());
  }
}

class Service {
  String? sevId;
  String? sevText;
  Service({this.sevId, this.sevText});
  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      sevId: json['sevId'],
      sevText: json['sevText'],
    );
  }
}

class Medicines {
  String? medId;
  String? medNumber;
  String? medText;
  String? medUnit;
  String? medUse;

  Medicines(
      {this.medId, this.medNumber, this.medText, this.medUnit, this.medUse});

  factory Medicines.fromJson(Map<String, dynamic> json) {
    return Medicines(
      medId: json['medId'],
      medNumber: json['medNumber'],
      medText: json['medText'],
      medUnit: json['medUnit'],
      medUse: json['medUse'],
    );
  }
}
