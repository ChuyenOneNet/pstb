class DataSignedPatientModel {
  String? transactionId;

  DataSignedPatientModel({this.transactionId});

  factory DataSignedPatientModel.fromJson(Map<String, dynamic> json) {
    return DataSignedPatientModel(
      transactionId: json['transactionId'],
    );
  }
}
// TODO : cấu hình lại model data verify OTP
class DataPatientVerifyOTP {
  String? message;
  List<String>? ids;

  DataPatientVerifyOTP({this.message, this.ids});

  factory DataPatientVerifyOTP.fromJson(Map<String, dynamic> json) {
    return DataPatientVerifyOTP(
      message: json['message'],
      ids: List<String>.from(json['ids'].map((item) => item)),
    );
  }
}