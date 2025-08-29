// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicine_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicineOrder _$MedicineOrderFromJson(Map<String, dynamic> json) =>
    MedicineOrder(
      orderText: json['orderText'] as String,
      available: (json['available'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      isSelected: json['isSelected'] as bool? ?? false,
    );

Map<String, dynamic> _$MedicineOrderToJson(MedicineOrder instance) =>
    <String, dynamic>{
      'orderText': instance.orderText,
      'available': instance.available,
      'total': instance.total,
      'isSelected': instance.isSelected,
    };
