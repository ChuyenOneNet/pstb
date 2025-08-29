import 'package:json_annotation/json_annotation.dart';

part 'nationality_model.g.dart';

@JsonSerializable()
class Nationality {
  final String id;
  final String name;

  Nationality({
    required this.id,
    required this.name,
  });

  factory Nationality.fromJson(Map<String, dynamic> json) =>
      _$NationalityFromJson(json);
  Map<String, dynamic> toJson() => _$NationalityToJson(this);
}
