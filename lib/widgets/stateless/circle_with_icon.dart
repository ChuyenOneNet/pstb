import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pstb/utils/colors.dart';
import 'package:pstb/utils/styles.dart';

class CircleWithIcon extends StatelessWidget {
  static void x() {}

  const CircleWithIcon({
    Key? key,
    required this.boxSize,
    required this.iconSize,
    required this.icon,
    this.titleColor,
    this.color,
    this.title,
    this.onTap = x,
    this.colorIcon,
  }) : super(key: key);
  final double boxSize, iconSize;
  final String icon;
  final String? title;
  final Color? color;
  final Color? titleColor;
  final Function()? onTap;
  final Color? colorIcon;
  bool _isSvg() {
    return icon.endsWith('svg');
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      highlightColor: AppColors.transparent,
      splashColor: AppColors.transparent,
      child: Column(
        children: [
          Container(
            height: boxSize,
            width: boxSize,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.lightSilver, width: 0.5)
                // color: color ?? AppColors.neutral200,
                ),
            child: Padding(
              padding: EdgeInsets.only(
                top: (boxSize - iconSize) / 2,
                left: (boxSize - iconSize) / 2,
                bottom: (boxSize - iconSize) / 2,
                right: (boxSize - iconSize) / 2,
              ),
              child: _isSvg()
                  ? SvgPicture.asset(
                      icon,
                      color: colorIcon,
                      width: iconSize,
                      height: iconSize,
                    )
                  : ColorFiltered(
                      colorFilter: ColorFilter.mode(
                          colorIcon ?? Colors.black, BlendMode.srcIn),
                      child: Image.asset(
                        icon,
                        width: iconSize,
                        height: iconSize,
                      ),
                    ),
            ),
          ),
          if (title != null)
            Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  title ?? "",
                  style: Styles.content,
                  textAlign: TextAlign.center,
                ))
        ],
      ),
    );
  }
}
