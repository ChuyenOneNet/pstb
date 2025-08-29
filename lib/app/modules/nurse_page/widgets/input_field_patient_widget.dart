import 'package:avoid_keyboard/avoid_keyboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/nurse_page/nurse_searching_store.dart';
import 'package:pstb/app/modules/nurse_page/widgets/recording_page.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateful/app_input.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class InputFieldPatientWidget extends StatelessWidget {
  final nurse = Modular.get<NurseSearchingStore>();
  final bool enableField;
  final String? textBreath;
  final String? textTemperature;
  final String? textMax;
  final String? textMin;
  final String? textVessel;
  final String? developments;
  final String? takeCare;
  final TextEditingController? controllerTextBreath;
  final TextEditingController? controllerTextTemperature;
  final TextEditingController? controllerTextMax;
  final TextEditingController? controllerTextMin;
  final TextEditingController? controllerTextVessel;
  final TextEditingController? controllerDevelopments;
  final TextEditingController? controllerTakeCare;

  setProgressText(String txt) {
    controllerDevelopments?.text = txt;
  }

  InputFieldPatientWidget({
    Key? key,
    this.enableField = false,
    this.textBreath,
    this.textTemperature,
    this.textMax,
    this.textMin,
    this.textVessel,
    this.developments,
    this.takeCare,
    this.controllerTextBreath,
    this.controllerTextTemperature,
    this.controllerTextMax,
    this.controllerTextMin,
    this.controllerTextVessel,
    this.controllerDevelopments,
    this.controllerTakeCare,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AvoidKeyboard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(
                child: AppInput(
                  autofocus: true,
                  enabled: enableField,
                  controller: controllerTextBreath ??
                      TextEditingController(text: textBreath ?? ""),
                  hintText: '${l10n(context).hint_breathing} (lần/phút)',
                  fillColor: AppColors.surfaceLight,
                  onChangeValue: nurse.setBreathing,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Không được để trống';
                    } else {
                      if (int.parse(value) > 35 || int.parse(value) < 10) {
                        return 'Nhịp thở 10-35 lần/phút}';
                      }
                    }
                    if (num.parse(value).runtimeType != int) {
                      return 'Giá trị là kiểu nguyên';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  listFormat: [
                    RangeTextInputFormatter(min: 0.0, max: 40.0),
                  ],
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Flexible(
                child: AppInput(
                  enabled: enableField,
                  controller: controllerTextTemperature ??
                      TextEditingController(text: textTemperature ?? ""),
                  hintText: '${l10n(context).hint_temperature} (\u{2103})',
                  fillColor: AppColors.surfaceLight,
                  onChangeValue: nurse.setTemperature,
                  keyboardType:
                      const TextInputType.numberWithOptions(signed: true),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Không được để trống';
                    } else {
                      if (double.parse(value) > 43 ||
                          double.parse(value) < 35) {
                        return 'Nhiệt độ từ 36 đến 42\u{2103}';
                      }
                    }
                    return null;
                  },
                  listFormat: [
                    // FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
                    FilteringTextInputFormatter.allow(RegExp(
                        r'^\d+\.?\d{0,1}$')), // Chỉ cho phép nhập số và số thập phân
                    RangeTextInputFormatter(
                        min: 0.0,
                        max: 45.0), // Giới hạn giá trị từ 36.0 đến 42.0
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Flexible(
                child: AppInput(
                  enabled: enableField,
                  controller: controllerTextMax ??
                      TextEditingController(text: textMax ?? ""),
                  keyboardType: TextInputType.number,
                  hintText: '${l10n(context).hint_blood_pressure} Max (mmHg)',
                  fillColor: AppColors.surfaceLight,
                  onChangeValue: nurse.setBloorPressureMax,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Không được để trống';
                    } else {
                      if (int.parse(value) > 120 || int.parse(value) < 90) {
                        return 'Chỉ số huyết áp cao 90-120 mmHg';
                      }
                    }
                    return null;
                  },
                  listFormat: [
                    RangeTextInputFormatter(min: 0.0, max: 120.0),
                  ],
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Flexible(
                child: AppInput(
                  enabled: enableField,
                  controller: controllerTextMin ??
                      TextEditingController(text: textMin ?? ""),
                  keyboardType: TextInputType.number,
                  hintText: '${l10n(context).hint_blood_pressure} Min (mmHg)',
                  fillColor: AppColors.surfaceLight,
                  onChangeValue: nurse.setBloorPressureMin,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Không được để trống';
                    } else {
                      if (int.parse(value) > 80 || int.parse(value) < 60) {
                        return 'Chỉ số huyết áp thấp 60-80 mmHg';
                      }
                    }
                    return null;
                  },
                  listFormat: [
                    RangeTextInputFormatter(min: 0.0, max: 80.0),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppInput(
                      enabled: enableField,
                      controller: controllerTextVessel ??
                          TextEditingController(text: textVessel ?? ""),
                      keyboardType: TextInputType.number,
                      hintText: '${l10n(context).hint_circuit} (lần/phút)',
                      fillColor: AppColors.surfaceLight,
                      onChangeValue: nurse.setCircuit,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Không được để trống';
                        } else {
                          if (int.parse(value) > 140 || int.parse(value) < 60) {
                            return 'Số đo mạch 60-140 lần/phút';
                          }
                        }
                        return null;
                      },
                      listFormat: [
                        RangeTextInputFormatter(min: 0.0, max: 140.0),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              const Spacer(),
            ],
          ),
          //Text('${l10n(context).hint_developments}'),
          AppInput(
            enabled: enableField,
            controller: controllerDevelopments ??
                TextEditingController(text: developments ?? ""),
            contentPadding: const EdgeInsets.all(16),
            hintText: l10n(context).hint_developments,
            fillColor: AppColors.surfaceLight,
            onChangeValue: nurse.setDevelopments,
            keyboardType: TextInputType.multiline,
            maxLine: null,
            iconRight: IconEnums.keyboardVoice,
            sizeIconRight: 24,
            onTapIconRight: () {
              nurse.isProgression = true;
              showBarModalBottomSheet(
                  context: context,
                  builder: (context) => const RecordingPage(),
                  barrierColor: AppColors.black.withOpacity(0.5));
            },
          ),
          AppInput(
            enabled: enableField,
            controller: controllerTakeCare ??
                TextEditingController(text: takeCare ?? ""),
            contentPadding: const EdgeInsets.all(16),
            hintText: l10n(context).hint_take_care_of,
            fillColor: AppColors.surfaceLight,
            onChangeValue: nurse.setHealthCare,
            keyboardType: TextInputType.multiline,
            maxLine: null,
            iconRight: IconEnums.keyboardVoice,
            sizeIconRight: 24,
            onTapIconRight: () {
              nurse.isProgression = false;
              showBarModalBottomSheet(
                  context: context,
                  builder: (context) => const RecordingPage(),
                  barrierColor: AppColors.black.withOpacity(0.5));
            },
          ),
        ],
      ),
    );
  }
}

class RangeTextInputFormatter extends TextInputFormatter {
  final double min;
  final double max;

  RangeTextInputFormatter({required this.min, required this.max});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final double? value = double.tryParse(newValue.text);
    if (value != null && value >= min && value <= max) {
      return newValue;
    }
    return oldValue;
  }
}
