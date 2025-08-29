import 'package:pstb/app/models/covid_declaration_template_model.dart';

class CovidDeclaration {
  List<CovidDeclarationGroup>? groups;

  CovidDeclaration({this.groups});

  factory CovidDeclaration.fromTemplate(CovidDeclarationTemplate template) {
    return CovidDeclaration(
        groups: template.groups!
            .map((e) => CovidDeclarationGroup.fromTemplate(e))
            .toList());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['groups'] = groups?.map((v) => v.toJson()).toList();
    return data;
  }
}

class CovidDeclarationGroup {
  String title;
  List<CovidDeclarationField> fields;

  CovidDeclarationGroup({required this.title, required this.fields});

  factory CovidDeclarationGroup.fromTemplate(
      CovidDeclarationTemplateGroup group) {
    return CovidDeclarationGroup(
        title: group.title ?? '',
        fields: group.fields!
            .map((e) => CovidDeclarationField.fromTemplate(e))
            .toList());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['fields'] = fields.map((v) => v.toJson()).toList();
    return data;
  }
}

class CovidDeclarationField {
  static const int typeBool = 1;
  static const int typeTime = 2;
  static const int typeText = 3;
  static const int typeMulti = 4;

  String title;
  dynamic value;
  int type;

  CovidDeclarationField({
    required this.title,
    required this.type,
    this.value,
  });

  dynamic getValue() {
    if (type == typeBool) {
      return value ?? false;
    }
    return value;
  }

  factory CovidDeclarationField.fromTemplate(
      CovidDeclarationTemplateField field) {
    return CovidDeclarationField(
        title: field.title ?? '', type: field.type ?? 1);
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'type': type,
      'value': value,
    };
  }
}
