import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

part 'medicine_usage_model.g.dart';

@JsonSerializable()
class MedicineUsageModel = _MedicineUsageModel with _$MedicineUsageModel;

abstract class _MedicineUsageModel with Store {
  _MedicineUsageModel({
    required this.medicineName,
    required this.description,
    this.wholeAmount = 0,
    this.partialAmount = 0,
    this.afterMeal = false,
    this.beforeMeal = false,
    this.hasProgress = false,
    this.isOther = false,
    DateTime? usageTime,
  }) : usageTime = usageTime ?? DateTime.now();

  final String medicineName;
  final String description;

  @observable
  double wholeAmount;

  @observable
  double partialAmount;

  @observable
  DateTime usageTime;

  @observable
  bool beforeMeal;

  @observable
  bool afterMeal;

  @observable
  bool hasProgress;

  @observable
  bool isOther;

  @computed
  double get totalUsed => wholeAmount + partialAmount;
}

// ✅ Đặt factory + toJson bên ngoài
MedicineUsageModel medicineUsageModelFromJson(Map<String, dynamic> json) =>
    _$MedicineUsageModelFromJson(json);

Map<String, dynamic> medicineUsageModelToJson(MedicineUsageModel instance) =>
    _$MedicineUsageModelToJson(instance);
