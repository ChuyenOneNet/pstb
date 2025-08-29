import 'package:flutter/material.dart';
import 'package:pstb/utils/main.dart';

class GradientButtonWidget extends StatelessWidget {
  const GradientButtonWidget(
      {Key? key, this.onTap, required this.titleButton, this.radius})
      : super(key: key);
  final Function()? onTap;
  final String titleButton;
  final double? radius;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: heightConvert(context, 16)),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(radius ?? 6),
        ),
        alignment: Alignment.center,
        child: Text(
          titleButton,
          style: Styles.heading4.copyWith(color: AppColors.background),
        ),
      ),
    );
  }
}
