class StatusData {
  bool? status;
  List<DataConfig>? data;
  String? errors;

  StatusData({this.status, this.data, this.errors});

  factory StatusData.fromJson(Map<String, dynamic> json) {
    return StatusData(
      status: json['status'],
      errors: json['errors'],
      data: json['data'].map((e) => DataConfig.fromJson(e)).toList(),
    );
  }
}

class DataConfig {
  int? id;
  String? code;
  String? name;
  String? value;

  DataConfig({this.id, this.code, this.name, this.value});

  factory DataConfig.fromJson(Map<String, dynamic> json) {
    return DataConfig(
      id: json['id'],
      code: json['code'],
      name: json['name'],
      value: json['value'],
    );
  }
  @override
  String toString() {
    return "DataConfig(id : $id,value:$value,name:$name)";
  }
}
