import 'package:flutter/material.dart';
import 'package:pstb/utils/main.dart';

enum PersonalType { personal, others }

List<String> type = ['Cá nhân', 'Người thân'];

class TypePersonalWidget extends StatelessWidget {
  const TypePersonalWidget(
      {Key? key, required this.onChanged, required this.groupValue})
      : super(key: key);
  final Function(PersonalType?) onChanged;
  final PersonalType? groupValue;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          PersonalType.values.length,
          (index) => RadioButtonType(
            value: PersonalType.values[index],
            groupValue: groupValue,
            onChanged: (_) => onChanged(PersonalType.values[index]),
            type: type[index],
          ),
        ),
      ),
    );
  }
}

class RadioButtonType extends StatelessWidget {
  const RadioButtonType(
      {Key? key,
      required this.onChanged,
      required this.groupValue,
      this.type,
      required this.value})
      : super(key: key);
  final Function(PersonalType?) onChanged;
  final PersonalType? groupValue;
  final String? type;
  final PersonalType value;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: AppColors.transparent,
      splashColor: AppColors.transparent,
      onTap: () => onChanged(groupValue),
      child: Row(
        children: [
          Radio<PersonalType>(
              value: value, groupValue: groupValue, onChanged: onChanged),
          Text(
            type ?? '',
            style: Styles.titleItem,
          )
        ],
      ),
    );
  }
}
