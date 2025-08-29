class PackageGroupModel {
  int? id;
  String? name;
  String? image;
  int? numberOfMember;
  String? createdTime;
  String? createdBy;
  String? members;

  PackageGroupModel(
      {this.id,
      this.name,
      this.image,
      this.numberOfMember,
      this.createdTime,
      this.createdBy,
      this.members});

  factory PackageGroupModel.fromJson(Map<String, dynamic> json) {
    return PackageGroupModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      numberOfMember: json['numberOfMember'],
      createdTime: json['createdTime'],
      createdBy: json['createdBy'],
      members: json['members'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['numberOfMember'] = numberOfMember;
    data['createdTime'] = createdTime;
    data['createdBy'] = createdBy;
    data['members'] = members;
    return data;
  }
}
