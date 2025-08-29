import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../utils/main.dart';

class ItemSlidableActionWidget extends StatelessWidget {
  const ItemSlidableActionWidget(
      {Key? key,
      this.backgroundColor,
      this.iconSvg,
      this.onAction,
      required this.label})
      : super(key: key);
  final Color? backgroundColor;
  final String? iconSvg;
  final Function()? onAction;
  final String label;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onAction,
      child: Container(
        color: backgroundColor ?? AppColors.success,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconSvg ?? IconEnums.eye,
              color: AppColors.background,
              width: 24,
            ),
            const SizedBox(
              height: 2.0,
            ),
            Text(
              label,
              style:
                  Styles.subtitleSmallest.copyWith(color: AppColors.background),
            )
          ],
        ),
      ),
    );
  }
}
