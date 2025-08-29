import 'package:flutter/material.dart';
import 'package:pstb/utils/main.dart';

class ItemTime extends StatelessWidget {
  final double opacity;
  final String? day, month, hour;

  const ItemTime({
    Key? key,
    this.opacity = 1,
    this.day,
    this.month,
    this.hour,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          day!,
          style:
              Styles.titleItem.copyWith(color: AppColors.primary, fontSize: 39),
        ),
        Text(
          month!,
          style: Styles.content.copyWith(color: Colors.black, fontSize: 13),
        ),
        Text(
          hour!,
          style: Styles.content
              .copyWith(color: Colors.black.withOpacity(0.8), fontSize: 13),
        ),
      ],
    );
  }
}
