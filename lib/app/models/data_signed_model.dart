class SignedDoucmentModel {
  String? message;
  List<String>? ids;
  bool? isTempSuccess;

  SignedDoucmentModel({this.message, this.ids, this.isTempSuccess});

  factory SignedDoucmentModel.fromJson(Map<String, dynamic> json) {
    return SignedDoucmentModel(
        message: json['message'],
        ids: List<String>.from(json['ids'].map((item) => item)));
  }
}
