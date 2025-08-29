import 'package:flutter/material.dart';
import 'package:pstb/utils/main.dart';

class ScheduleDetailTitle extends StatelessWidget {
  final String title;
  const ScheduleDetailTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(
        vertical: widthConvert(context, 16),
      ),
      child: Text(
        title,
        style: Styles.content.copyWith(
          color: AppColors.neutral600,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
