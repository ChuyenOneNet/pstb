import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pstb/utils/main.dart';

class ScheduleDetailIconText extends StatelessWidget {
  final String icon, title;
  const ScheduleDetailIconText({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          icon,
          color: AppColors.black,
          height: widthConvert(context, 14),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              left: widthConvert(context, 9),
            ),
            child: Text(
              title,
              style: Styles.content.copyWith(
                color: AppColors.neutral800,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
