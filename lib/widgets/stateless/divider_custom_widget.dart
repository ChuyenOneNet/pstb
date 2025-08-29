import 'package:flutter/material.dart';
import 'package:pstb/utils/main.dart';

class DividerCustomWidget extends StatelessWidget {
  const DividerCustomWidget(
      {Key? key, this.sizeHorizontalDivider, this.colorDivider})
      : super(key: key);
  final double? sizeHorizontalDivider;
  final Color? colorDivider;
  @override
  Widget build(BuildContext context) {
    return Divider(
      color: colorDivider ?? AppColors.lightSilver,
      indent: sizeHorizontalDivider ?? 8,
      endIndent: sizeHorizontalDivider ?? 8,
    );
  }
}
