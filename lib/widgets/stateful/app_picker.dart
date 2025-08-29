import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateful/stateful_widget.dart';

class AppPicker extends StatelessWidget {
  final String? icon;
  final List<FilterObject> list;
  final Function(FilterObject?) selectedValue;
  final Color? selectedColorIcon;
  final String? title;
  final FilterObject? value;
  final String? hint;
  final Function()? onClean;
  final bool? smallPicker;
  final BoxBorder? border;
  final String? validationError;
  final bool? pressedFirstSubmit;
  const AppPicker({
    Key? key,
    this.icon,
    required this.list,
    required this.selectedValue,
    this.title,
    this.value,
    this.hint,
    this.onClean,
    this.selectedColorIcon,
    this.smallPicker = false,
    this.border,
    this.validationError,
    this.pressedFirstSubmit,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool heigher = false;
    if (pressedFirstSubmit == true) {
      heigher = isNotEmptyNullString(validationError);
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title != null
              ? Padding(
                  padding: EdgeInsets.only(
                    left: 6,
                    top: heightConvert(context, 16),
                    bottom: heightConvert(context, 12),
                  ),
                  child: Text(title!, style: Styles.buttonSmallLowercase),
                )
              : const SizedBox(),
          DropdownButtonHideUnderline(
            child: DropdownButton<FilterObject?>(
              itemHeight: heigher == true ? 87 : 64,
              isExpanded: true,
              items:
                  list.map<DropdownMenuItem<FilterObject>>((FilterObject item) {
                return DropdownMenuItem<FilterObject>(
                  value: item,
                  child: Text(item.name!, style: Styles.bodyRegular),
                );
              }).toList(),
              hint: AppInput(
                isDisable: true,
                enabled: value != null && list.contains(value!) ? false : true,
                iconLeft: icon,
                hintText: hint,
                validationError: validationError,
                iconRight: IconEnums.chevron_down,
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                  borderSide: BorderSide(color: AppColors.neutral300),
                ),
              ),
              disabledHint: null,
              value: value != null && list.contains(value!) ? value : null,
              onChanged: (FilterObject? item) => {selectedValue(item!)},
              selectedItemBuilder: (BuildContext context) {
                return list.map<Widget>((FilterObject item) {
                  return AppInput(
                    isDisable: true,
                    enabled:
                        value != null && list.contains(value!) ? false : true,
                    iconLeft: icon,
                    iconLeftWidget: icon != null
                        ? SvgPicture.asset(
                            icon!,
                            width: 16,
                            height: 16,
                            fit: BoxFit.contain,
                          )
                        : null,
                    validationError: validationError,
                    iconRight: IconEnums.chevron_down,
                    textValue: item.name,
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      borderSide: BorderSide(color: AppColors.neutral300),
                    ),
                  );
                }).toList();
              },
              icon: const SizedBox(),
            ),
          )
        ],
      ),
    );
  }
}

class FilterObject {
  const FilterObject({
    this.id,
    this.name,
    this.value,
    this.valueGte,
    this.valueLte,
  });

  final String? name;
  final int? id;
  final String? value;
  final String? valueGte;
  final String? valueLte;

  bool operator ==(o) => o is FilterObject && o.id == id;
  int get hashCode => id.hashCode;
}
