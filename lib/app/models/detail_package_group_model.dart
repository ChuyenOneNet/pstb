class DetailPackageGroupModel {
  int? id;
  String? name;
  String? image;
  int? numberOfMember;
  String? createdTime;
  String? createdBy;
  List<MembersModel>? members;

  DetailPackageGroupModel(
      {this.id,
      this.name,
      this.image,
      this.numberOfMember,
      this.createdTime,
      this.createdBy,
      this.members});

  factory DetailPackageGroupModel.fromJson(
      Map<String, dynamic> json, Function listMembers) {
    final members = json['members'] != null
        ? List<MembersModel>.from(
            json['members'].map((item) => listMembers(item)))
        : <MembersModel>[];
    return DetailPackageGroupModel(
        id: json['id'],
        name: json['name'],
        image: json['image'],
        numberOfMember: json['numberOfMember'],
        createdTime: json['createdTime'],
        createdBy: json['createdBy'],
        members: members);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['numberOfMember'] = numberOfMember;
    data['createdTime'] = createdTime;
    data['createdBy'] = createdBy;
    if (members != null) {
      data['members'] = members!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MembersModel {
  int? id;
  String? name;
  int? packageId;

  MembersModel({this.id, this.name, this.packageId});

  factory MembersModel.fromJson(Map<String, dynamic> json) {
    return MembersModel(
        id: json['id'], name: json['name'], packageId: json['packageId']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['packageId'] = packageId;
    return data;
  }
}
