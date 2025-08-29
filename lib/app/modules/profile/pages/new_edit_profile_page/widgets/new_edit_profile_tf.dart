import 'package:flutter/material.dart';
import 'package:pstb/utils/main.dart';

class NewEditProfileTextField extends StatelessWidget {
  final Widget? icon;
  final String? labelText;
  final Function(String)? onChangeValue;
  final bool? isEnable;
  final TextInputType? keyboardType;
  final TextCapitalization? textCapitalization;
  final String? hintText;
  final EdgeInsetsGeometry? padding;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool isPadding;
  final bool readOnly;
  const NewEditProfileTextField({
    Key? key,
    this.icon,
    this.labelText,
    this.onChangeValue,
    this.keyboardType,
    this.textCapitalization,
    this.hintText,
    this.isEnable = true,
    this.padding,
    this.controller,
    this.validator,
    this.isPadding = true,
    this.readOnly = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isPadding
          ? const EdgeInsets.symmetric(horizontal: 16.0)
          : EdgeInsets.zero,
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
                controller: controller,
                enabled: isEnable,
                readOnly: readOnly,
                onTap: () {
                  //_textEditingController.clear();
                },
                validator: validator,
                textCapitalization:
                    textCapitalization ?? TextCapitalization.none,
                keyboardType: keyboardType,
                autocorrect: false,
                autofocus: false,
                onChanged: onChangeValue,
                initialValue: labelText,
                decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: Styles.content,
                    labelText: hintText,
                    errorStyle: Styles.content,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)))),
          )
        ],
      ),
    );
  }
}
