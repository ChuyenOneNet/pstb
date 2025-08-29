// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicine_usage_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicineUsageModel _$MedicineUsageModelFromJson(Map<String, dynamic> json) =>
    MedicineUsageModel(
      medicineName: json['medicineName'] as String,
      description: json['description'] as String,
      wholeAmount: (json['wholeAmount'] as num?)?.toDouble() ?? 0,
      partialAmount: (json['partialAmount'] as num?)?.toDouble() ?? 0,
      afterMeal: json['afterMeal'] as bool? ?? false,
      beforeMeal: json['beforeMeal'] as bool? ?? false,
      hasProgress: json['hasProgress'] as bool? ?? false,
      isOther: json['isOther'] as bool? ?? false,
      usageTime: json['usageTime'] == null
          ? null
          : DateTime.parse(json['usageTime'] as String),
    );

Map<String, dynamic> _$MedicineUsageModelToJson(MedicineUsageModel instance) =>
    <String, dynamic>{
      'medicineName': instance.medicineName,
      'description': instance.description,
      'wholeAmount': instance.wholeAmount,
      'partialAmount': instance.partialAmount,
      'usageTime': instance.usageTime.toIso8601String(),
      'beforeMeal': instance.beforeMeal,
      'afterMeal': instance.afterMeal,
      'hasProgress': instance.hasProgress,
      'isOther': instance.isOther,
    };

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MedicineUsageModel on _MedicineUsageModel, Store {
  Computed<double>? _$totalUsedComputed;

  @override
  double get totalUsed =>
      (_$totalUsedComputed ??= Computed<double>(() => super.totalUsed,
              name: '_MedicineUsageModel.totalUsed'))
          .value;

  late final _$wholeAmountAtom =
      Atom(name: '_MedicineUsageModel.wholeAmount', context: context);

  @override
  double get wholeAmount {
    _$wholeAmountAtom.reportRead();
    return super.wholeAmount;
  }

  @override
  set wholeAmount(double value) {
    _$wholeAmountAtom.reportWrite(value, super.wholeAmount, () {
      super.wholeAmount = value;
    });
  }

  late final _$partialAmountAtom =
      Atom(name: '_MedicineUsageModel.partialAmount', context: context);

  @override
  double get partialAmount {
    _$partialAmountAtom.reportRead();
    return super.partialAmount;
  }

  @override
  set partialAmount(double value) {
    _$partialAmountAtom.reportWrite(value, super.partialAmount, () {
      super.partialAmount = value;
    });
  }

  late final _$usageTimeAtom =
      Atom(name: '_MedicineUsageModel.usageTime', context: context);

  @override
  DateTime get usageTime {
    _$usageTimeAtom.reportRead();
    return super.usageTime;
  }

  @override
  set usageTime(DateTime value) {
    _$usageTimeAtom.reportWrite(value, super.usageTime, () {
      super.usageTime = value;
    });
  }

  late final _$beforeMealAtom =
      Atom(name: '_MedicineUsageModel.beforeMeal', context: context);

  @override
  bool get beforeMeal {
    _$beforeMealAtom.reportRead();
    return super.beforeMeal;
  }

  @override
  set beforeMeal(bool value) {
    _$beforeMealAtom.reportWrite(value, super.beforeMeal, () {
      super.beforeMeal = value;
    });
  }

  late final _$afterMealAtom =
      Atom(name: '_MedicineUsageModel.afterMeal', context: context);

  @override
  bool get afterMeal {
    _$afterMealAtom.reportRead();
    return super.afterMeal;
  }

  @override
  set afterMeal(bool value) {
    _$afterMealAtom.reportWrite(value, super.afterMeal, () {
      super.afterMeal = value;
    });
  }

  late final _$hasProgressAtom =
      Atom(name: '_MedicineUsageModel.hasProgress', context: context);

  @override
  bool get hasProgress {
    _$hasProgressAtom.reportRead();
    return super.hasProgress;
  }

  @override
  set hasProgress(bool value) {
    _$hasProgressAtom.reportWrite(value, super.hasProgress, () {
      super.hasProgress = value;
    });
  }

  late final _$isOtherAtom =
      Atom(name: '_MedicineUsageModel.isOther', context: context);

  @override
  bool get isOther {
    _$isOtherAtom.reportRead();
    return super.isOther;
  }

  @override
  set isOther(bool value) {
    _$isOtherAtom.reportWrite(value, super.isOther, () {
      super.isOther = value;
    });
  }

  @override
  String toString() {
    return '''
wholeAmount: ${wholeAmount},
partialAmount: ${partialAmount},
usageTime: ${usageTime},
beforeMeal: ${beforeMeal},
afterMeal: ${afterMeal},
hasProgress: ${hasProgress},
isOther: ${isOther},
totalUsed: ${totalUsed}
    ''';
  }
}
