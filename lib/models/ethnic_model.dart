import 'package:json_annotation/json_annotation.dart';

part 'ethnic_model.g.dart';

@JsonSerializable()
class Ethnic {
  final String id;
  final String name;

  Ethnic({
    required this.id,
    required this.name,
  });

  factory Ethnic.fromJson(Map<String, dynamic> json) => _$EthnicFromJson(json);
  Map<String, dynamic> toJson() => _$EthnicToJson(this);
}
