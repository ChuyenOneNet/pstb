
class QrCodeModel {
  String? code;
  String? qrCode;

  QrCodeModel({this.qrCode,this.code});

  factory QrCodeModel.fromJson(Map<String,dynamic> json){
    return QrCodeModel(
        qrCode: json['qrCode'],
        code: json['code']
    );
  }
}