import 'package:json_annotation/json_annotation.dart';

part 'medicine_order.g.dart';

@JsonSerializable()
class MedicineOrder {
  final String orderText;
  final double available;
  final double total;
  final bool isSelected;

  MedicineOrder({
    required this.orderText,
    required this.available,
    required this.total,
    this.isSelected = false,
  });

  MedicineOrder copyWith({
    String? orderText,
    double? available,
    double? total,
    bool? isSelected,
  }) {
    return MedicineOrder(
      orderText: orderText ?? this.orderText,
      available: available ?? this.available,
      total: total ?? this.total,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  factory MedicineOrder.fromJson(Map<String, dynamic> json) =>
      _$MedicineOrderFromJson(json);
  Map<String, dynamic> toJson() => _$MedicineOrderToJson(this);
}
