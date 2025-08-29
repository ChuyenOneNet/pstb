class ListSignTransactionResponse{
  final bool isSuccess;
  final String? message;
  final List<SignTransactionModel>? data;

  ListSignTransactionResponse({this.isSuccess = false, this.message, this.data});


  factory ListSignTransactionResponse.fromJson(Map<String, dynamic> json) =>
      _$ListSignTransactionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListSignTransactionResponseToJson(this);
}

class SignTransactionModel{
  final String? type;

  final String transactionID;

  final String? createdDt;

  final String? notificationMessage;

  final String? messageCaption;

  final String? rpIconURI;

  final String? expiredDt;

  final String? scaIdentity;

  SignTransactionModel({
    this.type,
    this.transactionID="",
    this.createdDt,
    this.notificationMessage,
    this.messageCaption,
    this.rpIconURI,
    this.expiredDt,
    this.scaIdentity});

  factory SignTransactionModel.fromJson(Map<String, dynamic> json) =>
      _$SignTransactionModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignTransactionModelToJson(this);
}

ListSignTransactionResponse _$ListSignTransactionResponseFromJson(
    Map<String, dynamic> json) =>
ListSignTransactionResponse(
isSuccess: json['isSuccess'] as bool? ?? false,
message: json['message'] as String?,
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => SignTransactionModel.fromJson(Map<String, dynamic>.from(e as Map)))
      .toList(),
);

Map<String, dynamic> _$ListSignTransactionResponseToJson(
    ListSignTransactionResponse instance) =>
    <String, dynamic>{
      'isSuccess': instance.isSuccess,
      'message': instance.message,
      'data': instance.data,
    };

SignTransactionModel _$SignTransactionModelFromJson(Map<String, dynamic> json) =>
    SignTransactionModel(
      type: json['type'] as String?,
      transactionID: json['transactionID'] as String? ?? "",
      createdDt: json['createdDt'] as String?,
      notificationMessage: json['notificationMessage'] as String?,
      messageCaption: json['messageCaption'] as String?,
      rpIconURI: json['rpIconURI'] as String?,
      expiredDt: json['expiredDt'] as String?,
      scaIdentity: json['scaIdentity'] as String?,
    );

Map<String, dynamic> _$SignTransactionModelToJson(SignTransactionModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'transactionID': instance.transactionID,
      'createdDt': instance.createdDt,
      'notificationMessage': instance.notificationMessage,
      'messageCaption': instance.messageCaption,
      'rpIconURI': instance.rpIconURI,
      'expiredDt': instance.expiredDt,
      'scaIdentity': instance.scaIdentity,
    };
