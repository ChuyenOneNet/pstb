import 'package:pstb/extensions/data_extension.dart';

class Package {
  Package(
      {this.id,
      this.name,
      this.image,
      this.icon,
      this.description,
      this.note,
      this.testIndex,
      this.status,
      this.insurance,
      this.gender,
      this.age,
      this.testAtHome,
      this.prescriptions,
      this.category,
      this.province,
      this.district,
      this.examinationProcedure,
      this.packageServices,
      this.packagePrice,
      this.specializes,
      this.doctors,
      this.count,
      this.categoryId,
      this.categoryName,
      this.categoryGroupCode,
      this.isGetSample,
      this.isSeeDoctor,
      this.isChoiceDoctor,
      this.price});

  bool? isChoiceDoctor;
  int? id;
  String? name;
  String? image;
  String? icon;
  String? description;
  String? note;
  List<String>? testIndex;
  String? status;
  bool? insurance;
  String? gender;
  String? age;
  bool? testAtHome;
  String? prescriptions;
  List<Category>? category;
  dynamic province;
  dynamic district;
  List<ExaminationProcedure>? examinationProcedure;
  List<PackageService>? packageServices;
  int? packagePrice;
  List<Specialize>? specializes;
  List<Doctor>? doctors;
  int? count;
  String? categoryName;
  String? categoryId;
  String? categoryGroupCode;
  bool? isGetSample;
  bool? isSeeDoctor;
  int? price;

  int getCountService() {
    return packageServices?.length ?? 0;
  }

  String getGenderName() {
    if (gender == null) return "Nam";
    return gender!;
  }

  factory Package.fromJson(Map<String, dynamic> json) => Package(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        icon: json["icon"],
        description: json["description"],
        note: json["note"],
        testIndex: json.tryGetList("test_index", (item) => item),
        status: json["status"],
        insurance: json["insurance"],
        gender: json["gender"],
        age: json["age"],
        testAtHome: json["test_at_home"],
        prescriptions: json["prescriptions"],
        category: json.tryGetList<Category>(
            "category", (item) => Category.fromJson(item)),
        province: json["province"],
        district: json["district"],
        examinationProcedure: json.tryGetList(
            'examination_procedure', (x) => ExaminationProcedure.fromJson(x)),
        packageServices:
            json.tryGetList('services', (x) => PackageService.fromJson(x)),
        packagePrice: (json['price'] as int?),
        specializes:
            json.tryGetList('specializes', (x) => Specialize.fromJson(x)),
        doctors: json.tryGetList('doctors', (x) => Doctor.fromJson(x)),
        count: json["count"],
        price: json["price"],
        categoryId: json["categoryId"],
        categoryName: json["categoryName"],
        categoryGroupCode: json["categoryGroupCode"],
        isGetSample: json["isGetSample"],
        isSeeDoctor: json["isSeeDoctor"],
        isChoiceDoctor: json["isChoiceDoctor"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "icon": icon,
        "description": description,
        "note": note,
        "test_index": testIndex == null
            ? null
            : List<dynamic>.from(testIndex!.map((x) => x)),
        "status": status,
        "insurance": insurance,
        "gender": gender,
        "age": age,
        "test_at_home": testAtHome,
        "prescriptions": prescriptions,
        "category": List<dynamic>.from(category!.map((x) => x.toJson())),
        "province": province,
        "district": district,
        "examination_procedure":
            List<dynamic>.from(examinationProcedure!.map((x) => x.toJson())),
        "package_service":
            List<dynamic>.from(packageServices!.map((x) => x.toJson())),
        "price": packagePrice,
        "specializes": List<dynamic>.from(specializes!.map((x) => x.toJson())),
        "doctors": List<dynamic>.from(doctors!.map((x) => x.toJson())),
        "count": count,
      };

  bool isCovidPackage() {
    if (categoryGroupCode == null) return false;
    return categoryGroupCode!.toLowerCase().contains('covid');
  }
}

class PackagePagingItem {
  PackagePagingItem(
      {this.id,
      this.name,
      this.image,
      this.icon,
      this.description,
      this.note,
      this.testIndex,
      this.status,
      this.insurance,
      this.gender,
      this.age,
      this.testAtHome,
      this.prescriptions,
      this.category,
      this.province,
      this.district,
      this.examinationProcedure,
      this.services,
      this.packagePrice,
      this.specializes,
      this.doctors,
      this.count,
      this.categoryId,
      this.categoryName,
      this.isGetSample,
      this.categoryGroupCode,
      this.price});

  bool? isGetSample;
  int? id;
  String? name;
  String? image;
  String? icon;
  String? description;
  String? note;
  List<String>? testIndex;
  String? status;
  bool? insurance;
  String? gender;
  String? age;
  bool? testAtHome;
  String? prescriptions;
  List<Category>? category;
  dynamic province;
  dynamic district;
  List<ExaminationProcedure>? examinationProcedure;
  List<PackageService>? services;
  List<Price>? packagePrice;
  List<Specialize>? specializes;
  List<Doctor>? doctors;
  int? count;
  String? categoryName;
  String? categoryId;
  String? categoryGroupCode;
  int? price;

  factory PackagePagingItem.fromJson(Map<String, dynamic> json) =>
      PackagePagingItem(
          id: json["id"],
          name: json["name"],
          image: json["image"],
          icon: json["icon"],
          description: json["description"],
          note: json["note"],
          testIndex: json.tryGetList("test_index", (item) => item),
          status: json["status"],
          insurance: json["insurance"],
          gender: json["gender"],
          age: json["age"],
          testAtHome: json["test_at_home"],
          prescriptions: json["prescriptions"],
          category: json.tryGetList<Category>(
              "category", (item) => Category.fromJson(item)),
          province: json["province"],
          district: json["district"],
          examinationProcedure: json.tryGetList(
              'examination_procedure', (x) => ExaminationProcedure.fromJson(x)),
          services:
              json.tryGetList('services', (x) => PackageService.fromJson(x)),
          packagePrice:
              json.tryGetList('package_price', (x) => Price.fromJson(x)),
          specializes:
              json.tryGetList('specializes', (x) => Specialize.fromJson(x)),
          doctors: json.tryGetList('doctors', (x) => Doctor.fromJson(x)),
          count: json["count"],
          price: json["price"],
          categoryId: json["categoryId"],
          categoryName: json["categoryName"],
          isGetSample: json['isGetSample'],
          categoryGroupCode: json['categoryGroupCode']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "icon": icon,
        "description": description,
        "note": note,
        "test_index": testIndex == null
            ? null
            : List<dynamic>.from(testIndex!.map((x) => x)),
        "status": status,
        "insurance": insurance,
        "gender": gender,
        "age": age,
        "test_at_home": testAtHome,
        "prescriptions": prescriptions,
        "category": List<dynamic>.from(category!.map((x) => x.toJson())),
        "province": province,
        "district": district,
        "examination_procedure":
            List<dynamic>.from(examinationProcedure!.map((x) => x.toJson())),
        "package_service": List<dynamic>.from(services!.map((x) => x.toJson())),
        "package_price":
            List<dynamic>.from(packagePrice!.map((x) => x.toJson())),
        "specializes": List<dynamic>.from(specializes!.map((x) => x.toJson())),
        "doctors": List<dynamic>.from(doctors!.map((x) => x.toJson())),
        "count": count,
      };

  Map<String, List<PackageService>> getGroupServices() {
    var res = Map<String, List<PackageService>>();
    services?.forEach((element) {
      if (!res.containsKey(element.typeName)) res[element.typeName!] = [];
      res[element.typeName]?.add(element);
    });
    return res;
  }
}

class Category {
  Category({
    this.id,
    this.name,
    this.slug,
  });

  int? id;
  String? name;
  String? slug;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
      };
}

class Doctor {
  Doctor({
    this.id,
    this.name,
    this.specialized,
    this.image,
    this.experience,
    this.info,
    this.status,
    this.prices,
    this.workProgress,
    this.nearestBooking,
    this.educateProgress,
    this.specializes,
  });

  String? id;
  String? name;
  String? specialized;
  String? image;
  String? experience;
  String? info;
  int? status;
  List<Price>? prices;
  List<Progress>? workProgress;
  dynamic nearestBooking;
  List<Progress>? educateProgress;
  List<Specialize>? specializes;

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
        id: json["id"],
        name: json["name"],
        specialized: json["specialized"],
        image: json["image"],
        experience: json["experience"],
        info: json["info"],
        status: json["status"],
        prices: List<Price>.from(json["prices"].map((x) => Price.fromJson(x))),
        workProgress: List<Progress>.from(
            json["work_progress"].map((x) => Progress.fromJson(x))),
        nearestBooking: json["nearest_booking"],
        educateProgress: List<Progress>.from(
            json["educate_progress"].map((x) => Progress.fromJson(x))),
        specializes: List<Specialize>.from(
            json["specializes"].map((x) => Specialize.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "specialized": specialized,
        "image": image,
        "experience": experience,
        "info": info,
        "status": status,
        "prices": List<dynamic>.from(prices!.map((x) => x.toJson())),
        "work_progress":
            List<dynamic>.from(workProgress!.map((x) => x.toJson())),
        "nearest_booking": nearestBooking,
        "educate_progress":
            List<dynamic>.from(educateProgress!.map((x) => x.toJson())),
        "specializes": List<dynamic>.from(specializes!.map((x) => x.toJson())),
      };
}

class Progress {
  Progress({
    this.id,
    this.fromTime,
    this.endTime,
    this.description,
    this.created,
    this.doctor,
  });

  int? id;
  DateTime? fromTime;
  DateTime? endTime;
  String? description;
  DateTime? created;
  String? doctor;

  factory Progress.fromJson(Map<String, dynamic> json) => Progress(
        id: json["id"],
        fromTime: DateTime.parse(json["from_time"]),
        endTime: DateTime.parse(json["end_time"]),
        description: json["description"],
        created: DateTime.parse(json["created"]),
        doctor: json["doctor"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "from_time":
            "${fromTime!.year.toString().padLeft(4, '0')}-${fromTime!.month.toString().padLeft(2, '0')}-${fromTime!.day.toString().padLeft(2, '0')}",
        "end_time":
            "${endTime!.year.toString().padLeft(4, '0')}-${endTime!.month.toString().padLeft(2, '0')}-${endTime!.day.toString().padLeft(2, '0')}",
        "description": description,
        "created": created!.toIso8601String(),
        "doctor": doctor,
      };
}

class Price {
  Price({
    this.id,
    this.status,
    this.priceCurrency,
    this.price,
    this.created,
    this.doctors,
    this.packages,
  });

  String? id;
  String? status;
  String? priceCurrency;
  String? price;
  DateTime? created;
  List<String>? doctors;
  String? packages;

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        id: json["id"],
        status: json["status"],
        priceCurrency: json["price_currency"],
        price: json["price"],
        created: DateTime.parse(json["created"]),
        doctors: json["doctors"] == null
            ? null
            : List<String>.from(json["doctors"].map((x) => x)),
        packages: json["packages"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "price_currency": priceCurrency,
        "price": price,
        "created": created!.toIso8601String(),
        "doctors":
            doctors == null ? null : List<dynamic>.from(doctors!.map((x) => x)),
        "packages": packages,
      };
}

class Specialize {
  Specialize({
    this.id,
    this.name,
  });

  String? id;
  String? name;

  factory Specialize.fromJson(Map<String, dynamic> json) => Specialize(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class ExaminationProcedure {
  ExaminationProcedure({
    this.number,
    this.name,
    this.description,
  });

  int? number;
  String? name;
  String? description;

  factory ExaminationProcedure.fromJson(Map<String, dynamic> json) =>
      ExaminationProcedure(
        number: json["number"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "name": name,
        "description": description,
      };
}

class PackageService {
  int? id;
  String? name;
  String? description;
  String? typeName;
  String? typeCode;
  int? gender;

  PackageService(
      {this.id,
      this.name,
      this.description,
      this.typeName,
      this.gender,
      this.typeCode});

  PackageService.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    typeName = json['typeName'];
    gender = json['gender'];
    typeCode = json['typeCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['typeName'] = typeName;
    data['gender'] = gender;
    data['typeCode'] = typeCode;
    return data;
  }
}
