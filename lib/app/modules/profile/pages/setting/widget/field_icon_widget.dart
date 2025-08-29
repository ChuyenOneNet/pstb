import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pstb/utils/colors.dart';
import 'package:pstb/utils/styles.dart';

class FieldIconWidget extends StatelessWidget {
  const FieldIconWidget(
      {Key? key,
      required this.svgIcon,
      required this.title,
      this.onTap,
      this.child})
      : super(key: key);
  final String svgIcon;
  final String title;
  final Function()? onTap;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: SvgPicture.asset(
        svgIcon,
        color: Colors.black.withOpacity(0.4),
        width: 25,
      ),
      title: Text(
        title,
        style: Styles.content,
      ),
      trailing: child,
    );
  }
}
