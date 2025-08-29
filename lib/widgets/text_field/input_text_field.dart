import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constant/color.dart';

class InputTextField extends StatelessWidget {
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final String? label;
  final String? errorText;
  final bool obscureText;
  final Icon? prefixIcon;
  final String? hintText;
  final TextAlign? textAlign;
  final IconButton? iconButton;
  final int? maxLine;
  final int? maxLength;
  final int? minLine;
  final TextEditingController? textController;
  final bool enabled;
  final String? Function(String?)? validator;
  final Function(String?)? onSaved;
  final InputDecoration? decoration;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? ontap;
  final TextInputType? keyboardType;
  final AutovalidateMode autovalidateMode;
  const InputTextField({
    Key? key,
    this.onChanged,
    this.focusNode,
    this.obscureText = false,
    this.prefixIcon,
    this.errorText,
    this.textController,
    this.iconButton,
    this.hintText,
    this.maxLine,
    this.minLine,
    this.label,
    this.enabled = true,
    this.validator,
    this.inputFormatters,
    this.onSaved,
    this.ontap,
    this.textAlign,
    this.decoration,
    this.padding,
    this.maxLength,
    this.keyboardType,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: autovalidateMode,
      focusNode: focusNode,
      inputFormatters: inputFormatters,
      onTap: ontap,
      controller: textController,
      onChanged: onChanged,
      //style: PrimaryFont.medium(15).copyWith(color: AppColors.greyColor),
      maxLines: maxLine,
      minLines: minLine,
      enabled: enabled,
      textAlign: textAlign ?? TextAlign.center,
      validator: validator,
      maxLength: maxLength,
      onSaved: onSaved,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: decoration ??
          InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: hintText,
              filled: true,
              fillColor: Colors.white,
              // hintStyle:
              //     textTheme.t16R.copyWith(color: colorApp.labelSecondary),
              prefixIcon: prefixIcon,
              label: label == null
                  ? null
                  : Text(
                      label ?? '',
                    ),
              suffixIcon: iconButton,
              errorText: errorText,
              errorMaxLines: 2,
              focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(8))),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade500, width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(8))),
              disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade500, width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(8)))),
    );
  }
}
