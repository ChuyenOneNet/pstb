import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/circle_with_icon.dart';

class BoxIconWidget extends StatelessWidget {
  const BoxIconWidget(
      {Key? key, required this.title, required this.svgPicture, this.onTap})
      : super(key: key);
  final String title;
  final String svgPicture;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: InkWell(
        onTap: onTap,
        splashColor: AppColors.transparent,
        highlightColor: AppColors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              CircleIcon(
                boxSize: widthConvert(context, 64),
                iconSize: 64,
                onTap: onTap,
                icon: svgPicture,
                colorIcon: AppColors.primary,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                title,
                style: Styles.content,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CircleIcon extends StatelessWidget {
  static void x() {}

  const CircleIcon({
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
              padding: EdgeInsets.all(8).subtract(
                EdgeInsets.only(
                  top: (boxSize - iconSize) / 2,
                  left: (boxSize - iconSize) / 2,
                  bottom: (boxSize - iconSize) / 2,
                  right: (boxSize - iconSize) / 2,
                ).clamp(EdgeInsets.zero, EdgeInsets.all(8)),
              ),
              child: _isSvg()
                  ? SvgPicture.asset(
                      icon,
                      color: colorIcon,
                      width: iconSize,
                      height: iconSize,
                    )
                  : Image.asset(
                      icon,
                      width: iconSize,
                      height: iconSize,
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
