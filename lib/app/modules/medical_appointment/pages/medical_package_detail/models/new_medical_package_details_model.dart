import 'package:pstb/extensions/data_extension.dart';

class NewMedicalPackageDetailModel {
  //this is called “model”
  final int? id, count;
  final String? title, description, testedNotice, medicalNotice;
  final String? note, name;
  final bool? insurance;

  // final double? minPrice, maxPrice, price, book;
  final int? type, price, disCount, originalPrice;
  final List<MedicalServices>? services;

  const NewMedicalPackageDetailModel({
    this.id,
    this.count,
    this.title,
    this.note,
    this.insurance,
    this.name,
    // this.minPrice,
    // this.maxPrice,
    this.originalPrice,
    this.disCount,
    this.price,
    this.type,
    this.description,
    this.services,
    this.testedNotice,
    this.medicalNotice,
  });

  factory NewMedicalPackageDetailModel.fromJson(Map<String, dynamic> json) =>
      NewMedicalPackageDetailModel(
        id: json['id'],
        count: json['count'],
        title: json['title'],
        note: json['note'],
        insurance: json['insurance'],
        name: json['name'],
        price: json['price'],
        originalPrice: json['originalPrice'],
        disCount: json['disCount'],
        type: json['type'],
        description: json['description'],
        services:
            json.tryGetList('services', (x) => MedicalServices.fromJson(x)),
        testedNotice: json['testedNotice'],
        medicalNotice: json['medicalNotice'],
      );
}

class MedicalServices {
  final int id;
  final String name;

  MedicalServices({required this.id, required this.name});

  factory MedicalServices.fromJson(Map<String, dynamic> json) =>
      MedicalServices(id: json['id'], name: json['name']);
}
