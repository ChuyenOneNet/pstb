// === CleanInputField: input tối giản, support icon trái/phải, validator, formatter, toggle ẩn/hiện mật khẩu ===
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constant/color.dart';
import '../../utils/styles.dart';

class CleanInputField extends StatefulWidget {
  const CleanInputField({
    Key? key,
    this.controller,
    this.hintText,
    this.maxLine = 1,
    this.prefix, // ví dụ: SvgPicture.asset(IconEnums.phone, width: 16, height: 16, color: AppColors.primary)
    this.trailing, // icon/phím tắt tùy ý
    this.validationError, // String? Function(String?)
    this.onChangeValue, // ValueChanged<String>
    this.obscureText = false,
    this.enableObscureToggle = false, // true -> hiện nút mắt để toggle
    this.keyboardType,
    this.listFormat,
    this.textCapitalization = TextCapitalization.none,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.errorText, // ưu tiên hiển thị nếu có error ngoại (vd: _store.phoneValidResponse)
    this.textInputAction,
    this.focusNode,
    this.enabled = true,
    this.contentPadding,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? hintText;
  final int maxLine;

  final Widget? prefix;
  final Widget? trailing;

  final FormFieldValidator<String>? validationError;
  final ValueChanged<String>? onChangeValue;

  final bool obscureText;
  final bool enableObscureToggle;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? listFormat;
  final TextCapitalization textCapitalization;
  final AutovalidateMode autovalidateMode;
  final String? errorText;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final bool enabled;
  final EdgeInsetsGeometry? contentPadding;

  @override
  State<CleanInputField> createState() => _CleanInputFieldState();
}

class _CleanInputFieldState extends State<CleanInputField> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
  }

  @override
  void didUpdateWidget(covariant CleanInputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.obscureText != widget.obscureText) {
      _obscure = widget.obscureText;
    }
  }

  @override
  Widget build(BuildContext context) {
    final suffix = widget.enableObscureToggle
        ? IconButton(
            onPressed: () => setState(() => _obscure = !_obscure),
            icon: Icon(
              _obscure
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
            ),
            color: AppColors.primaryColor,
            splashRadius: 20,
          )
        : (widget.trailing != null
            ? Padding(
                padding: const EdgeInsets.only(right: 8),
                child: widget.trailing!,
              )
            : null);

    return TextFormField(
      enabled: widget.enabled,
      focusNode: widget.focusNode,
      controller: widget.controller,
      obscureText: _obscure,
      maxLines: _obscure ? 1 : widget.maxLine,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.listFormat,
      textCapitalization: widget.textCapitalization,
      autovalidateMode: widget.autovalidateMode,
      textInputAction: widget.textInputAction,
      style: Styles.bodyRegular.copyWith(color: AppColors.neutral),
      onChanged: widget.onChangeValue,
      validator: (value) {
        // Ưu tiên error ngoại (nếu có), nếu không thì chạy validator truyền vào
        return widget.errorText ?? widget.validationError?.call(value);
      },
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: Styles.bodyRegular.copyWith(color: AppColors.grayColor),
        filled: true,
        fillColor: Colors.white,
        contentPadding: widget.contentPadding ??
            const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        prefixIcon: widget.prefix != null
            ? Padding(
                padding: const EdgeInsets.only(left: 12, right: 8),
                child: widget.prefix!,
              )
            : null,
        prefixIconConstraints:
            const BoxConstraints(minWidth: 32, minHeight: 32),
        suffixIcon: suffix,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.neutral, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
        ),
      ),
    );
  }
}
