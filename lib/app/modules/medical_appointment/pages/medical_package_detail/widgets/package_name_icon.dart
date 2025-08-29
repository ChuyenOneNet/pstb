import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pstb/utils/main.dart';

class PackageNameIcon extends StatelessWidget {
  const PackageNameIcon({
    Key? key,
    required this.title,
    required this.icon,
    this.titleStyle,
    this.size,
  }) : super(key: key);
  final String title, icon;
  final TextStyle? titleStyle;

  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(),
      child: Row(
        children: [
          SvgPicture.asset(
            icon,
            color: const Color(0xffD9D9D9),
            width: widthConvert(context, size == null ? 24 : size!),
            height: widthConvert(context, size == null ? 24 : size!),
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            title,
            maxLines: 1,
            softWrap: true,
            style: titleStyle ??
                Styles.subtitleSmall.copyWith(color: AppColors.neutral900),
          )
        ],
      ),
    );
  }
}
