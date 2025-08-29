class CategoryDiseaseModel{
  String? name;
  String? image;
  int? id;

  CategoryDiseaseModel({this.name, this.image, this.id});

  factory CategoryDiseaseModel.fromJson(Map<String, dynamic> json) {
    return CategoryDiseaseModel(
        name: json['name'],
        image: json['image'],
        id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['image'] = image;
    data['id'] = id;
    return data;
  }
}