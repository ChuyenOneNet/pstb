class PackageModel {
  final int? id, price, originalPrice, disCount;
  final String? image,
      icon,
      categoryId,
      categoryName,
      description,
      name,
      gender,
      categoryGroupCode;
  final bool? insurance,
      isGetSample,
      isSeeDoctor,
      isChoiceDoctor,
      testAtHome,
      examAtHome;

  PackageModel(
      {this.id,
      this.price,
      this.originalPrice,
      this.image,
      this.icon,
      this.categoryId,
      this.categoryName,
      this.name,
      this.description,
      this.insurance,
      this.gender,
      this.categoryGroupCode,
      this.disCount,
      this.isGetSample,
      this.isSeeDoctor,
      this.examAtHome,
      this.testAtHome,
      this.isChoiceDoctor});

  @override
  String toString() {
    return '$name,';
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is PackageModel && other.name == name;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => Object.hash(name, name);

  factory PackageModel.fromJson(Map<String, dynamic> json) => PackageModel(
        id: json['id'],
        price: json['price'],
        originalPrice: json['originalPrice'],
        image: json['image'],
        icon: json['icon'],
        categoryId: json['categoryId'],
        categoryName: json['categoryName'],
        name: json['name'],
        description: json['description'],
        insurance: json['insurance'],
        gender: json['gender'],
        categoryGroupCode: json['categoryGroupCode'],
        disCount: json['disCount'],
        isGetSample: json['isGetSample'],
        isSeeDoctor: json['isSeeDoctor'],
        isChoiceDoctor: json['isChoiceDoctor'],
        testAtHome: json['testAtHome'],
        examAtHome: json['examAtHome'],
      );
}
