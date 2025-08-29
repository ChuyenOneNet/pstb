class CovidDeclarationTemplate {
  List<CovidDeclarationTemplateGroup>? groups;

  CovidDeclarationTemplate({this.groups});

  CovidDeclarationTemplate.fromJson(Map<String, dynamic> json) {
    if (json['groups'] != null) {
      groups = <CovidDeclarationTemplateGroup>[];
      json['groups'].forEach((v) {
        groups!.add(CovidDeclarationTemplateGroup.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (groups != null) {
      data['groups'] = groups!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CovidDeclarationTemplateGroup {
  String? title;
  List<CovidDeclarationTemplateField>? fields;

  CovidDeclarationTemplateGroup({this.title, this.fields});

  CovidDeclarationTemplateGroup.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    if (json['fields'] != null) {
      fields = <CovidDeclarationTemplateField>[];
      json['fields'].forEach((v) {
        fields!.add(CovidDeclarationTemplateField.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    if (fields != null) {
      data['fields'] = fields!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CovidDeclarationTemplateField {
  static const typeBool = 1;
  static const typeTime = 2;
  static const typeText = 3;
  static const int typeMulti = 4;
  static const int typeCheckbox = 5;

  String? title;
  int? type;

  CovidDeclarationTemplateField({this.title, this.type});

  CovidDeclarationTemplateField.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['type'] = type;
    return data;
  }
}
