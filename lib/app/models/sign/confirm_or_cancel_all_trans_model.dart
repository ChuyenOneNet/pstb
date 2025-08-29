import 'package:pstb/app/models/sign/sign_transaction_model.dart';

class ConfirmOrCancelAllTransModel {
  final bool isSuccess;
  final List<SignTransactionModel> successItems;
  final List<SignTransactionModel> failItems;

  ConfirmOrCancelAllTransModel(
      {this.isSuccess = false,
      this.successItems = const [],
      this.failItems = const []});

  factory ConfirmOrCancelAllTransModel.fromJson(Map<String, dynamic> json) =>
      _$ConfirmOrCancelAllTransModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmOrCancelAllTransModelToJson(this);
}

ConfirmOrCancelAllTransModel _$ConfirmOrCancelAllTransModelFromJson(
        Map<String, dynamic> json) =>
    ConfirmOrCancelAllTransModel(
      isSuccess: json['isSuccess'] as bool? ?? false,
      successItems: (json['successItems'] as List<dynamic>?)
              ?.map((e) =>
                  SignTransactionModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      failItems: (json['failItems'] as List<dynamic>?)
              ?.map((e) =>
                  SignTransactionModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ConfirmOrCancelAllTransModelToJson(
        ConfirmOrCancelAllTransModel instance) =>
    <String, dynamic>{
      'isSuccess': instance.isSuccess,
      'successItems': instance.successItems,
      'failItems': instance.failItems,
    };
