class PromotionNewsModel {
  int? id;
  String? status;
  int? priority;
  String? title;
  String? image;
  String? description;
  String? expiredDate;
  String? created;

  PromotionNewsModel(
      {this.id,
      this.status,
      this.priority,
      this.title,
      this.image,
      this.description,
      this.expiredDate,
      this.created});

  PromotionNewsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    priority = json['priority'];
    title = json['title'];
    image = json['image'];
    description = json['description'];
    expiredDate = json['expiredDate'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['priority'] = priority;
    data['title'] = title;
    data['image'] = image;
    data['description'] = description;
    data['expiredDate'] = expiredDate;
    data['created'] = created;
    return data;
  }
}
