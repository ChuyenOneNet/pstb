class SlideUnitModel {
  bool? status;
  List<Data>? data;
  String? errors;

  SlideUnitModel({this.status, this.data, this.errors});

  SlideUnitModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    errors = json['errors'];
  }
}

class Data {
  String? path;

  Data({this.path});

  Data.fromJson(Map<String, dynamic> json) {
    path = json['path'];
  }
}
