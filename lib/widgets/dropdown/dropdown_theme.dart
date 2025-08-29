import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class DropdownTheme {
  late Color textColor;
  late Color borderColor;
  late Color disableBorderColor;
  late double borderRadius;
  late OutlineInputBorder border;
  late OutlineInputBorder disableBorder;
  late BuildContext context;

  DropdownTheme(this.context) {
    textColor = const Color(0xFF17181C);
    borderColor = const Color(0xFFD8DDE4);
    disableBorderColor = const Color(0xFFBEBEBE);
    double borderRadius = 8;

    border = OutlineInputBorder(
      borderSide: BorderSide(color: borderColor, width: 1),
      borderRadius: BorderRadius.all(
        Radius.circular(borderRadius),
      ),
    );

    disableBorder = OutlineInputBorder(
      borderSide: BorderSide(color: disableBorderColor, width: 1),
      borderRadius: BorderRadius.all(
        Radius.circular(borderRadius),
      ),
    );
  }

  InputDecoration inputDecoration({
    String? hintText,
  }) {
    final inputDecoration = InputDecoration(
      contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      filled: true,
      fillColor: Colors.white,
      focusedErrorBorder: border,
      errorBorder: border,
      focusedBorder: border,
      enabledBorder: border,
      disabledBorder: disableBorder,
      labelStyle: TextStyle(
        fontSize: 14,
        color: textColor,
      ),
      hintText: hintText,
    );
    return inputDecoration;
  }

  DropDownDecoratorProps dropdownDecoratorProps() {
    final dropDownDecoratorProps = DropDownDecoratorProps(
      dropdownSearchDecoration: inputDecoration(),
      baseStyle: TextStyle(
        fontSize: 14,
        color: textColor,
      ),
    );
    return dropDownDecoratorProps;
  }
}
