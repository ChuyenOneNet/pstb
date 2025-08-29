class LandingUnitModel {
  int? medicalUnitId;
  String? slogan;
  String? name;
  String? shortName;
  String? image;
  Theme? theme;

  LandingUnitModel(
      {this.medicalUnitId,
        this.slogan,
        this.name,
        this.shortName,
        this.image,
        this.theme});

  LandingUnitModel.fromJson(Map<String, dynamic> json) {
    medicalUnitId = json['medicalUnitId'];
    slogan = json['slogan'];
    name = json['name'];
    shortName = json['shortName'];
    image = json['image'];
    theme = json['theme'] != null ? Theme.fromJson(json['theme']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['medicalUnitId'] = medicalUnitId;
    data['slogan'] = slogan;
    data['name'] = name;
    data['shortName'] = shortName;
    data['image'] = image;
    if (theme != null) {
      data['theme'] = theme!.toJson();
    }
    return data;
  }
}

class Theme {
  String? primaryColor;

  Theme({this.primaryColor});

  Theme.fromJson(Map<String, dynamic> json) {
    primaryColor = json['primaryColor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['primaryColor'] = primaryColor;
    return data;
  }
}