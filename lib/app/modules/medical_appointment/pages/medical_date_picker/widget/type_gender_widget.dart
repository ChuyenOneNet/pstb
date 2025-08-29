import 'package:flutter/material.dart';
import 'package:pstb/utils/main.dart';

enum GenderType { m, f }

List<String> type = ['Nam', 'Nữ'];

class TypeGenderWidget extends StatelessWidget {
  const TypeGenderWidget(
      {Key? key, required this.onChanged, required this.groupValue})
      : super(key: key);
  final Function(GenderType?) onChanged;
  final GenderType? groupValue;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Giới tính *',
          labelStyle: Styles.content,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            GenderType.values.length,
                (index) => RadioButtonType(
              value: GenderType.values[index],
              groupValue: groupValue,
              onChanged: (_) => onChanged(GenderType.values[index]),
              type: type[index],
            ),
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
  final Function(GenderType?) onChanged;
  final GenderType? groupValue;
  final String? type;
  final GenderType value;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(groupValue),
      child: Row(
        children: [
          Radio<GenderType>(
              value: value, groupValue: groupValue, onChanged: onChanged),
          Text(
            type ?? '',
            style: Styles.content,
          )
        ],
      ),
    );
  }
}
