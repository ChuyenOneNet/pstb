import 'package:flutter/material.dart';
import '../../../../../../utils/styles.dart';

class ProfileTextField extends StatelessWidget {
  final Widget? icon;
  final String labelText;
  final String? hintText;
  final String? initValue;
  const ProfileTextField(
      {Key? key,
      this.icon,
      required this.labelText,
      this.hintText,
      this.initValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          if (icon != null)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: icon,
            ),
          Expanded(
            child: TextFormField(
                style: Styles.content,
                initialValue: initValue,
                enableSuggestions: false,
                autocorrect: false,
                autofocus: false,
                enabled: false,
                onTap: () {},
                decoration: InputDecoration(
                    hintText: labelText,
                    hintStyle: Styles.content,
                    labelText: labelText,
                    errorStyle: Styles.content,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)))),
          )
        ],
      ),
    );
  }
}
