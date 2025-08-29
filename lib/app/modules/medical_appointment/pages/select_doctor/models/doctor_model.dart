class DoctorPagingItem {
  int? id;
  String? name;
  String? position;
  String? description;
  List<DoctorAttr>? attrs;
  String? image;

  DoctorPagingItem(
      {this.id,
      this.name,
      this.attrs,
      this.position,
      this.image,
      this.description});

  @override
  String toString() {
    return '$name,';
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is DoctorPagingItem && other.name == name;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => Object.hash(name, name);

  DoctorPagingItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    // attrs = (json['children'] as List<dynamic>?)
    //     ?.map((e) => DoctorAttr.fromJson(e as Map<String, dynamic>))
    //     .toList();
    if (json['attrs'] != null) {
      attrs = <DoctorAttr>[];
      json['attrs'].forEach((v) {
        attrs!.add(DoctorAttr.fromJson(v));
      });
    }
    description = json['description'] ?? "";
    image = json['image'] ?? "";
    position = json['position'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    if (attrs != null) {
      data['attrs'] = attrs!.map((v) => v.toJson()).toList();
    }
    return data;
  }

}

class DoctorAttr {
  int? type;
  String? description;
  int? doctorId;

  DoctorAttr({this.description, this.doctorId, this.type});

  DoctorAttr.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    doctorId = json['doctorId'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['doctorId'] = doctorId;
    data['type'] = type;
    return data;
  }
}
