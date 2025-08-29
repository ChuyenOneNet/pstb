import 'package:flutter/material.dart';
import 'package:pstb/utils/main.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    this.color,
    required this.title,
    this.seeAll,
    this.onTap,
    this.fontWeight,
  }) : super(key: key);
  final String title;
  final String? seeAll;
  final Color? color;
  final Function()? onTap;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    var style = Styles.titleItem;
    if (fontWeight != null) {
      style = style.copyWith(fontWeight: fontWeight);
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Styles.titleItem.copyWith(fontFamily: 'Snas', fontSize: 16.0),
          textAlign: TextAlign.start,
        ),
        InkWell(
          onTap: onTap,
          child: Text(
            seeAll ?? '',
            style: Styles.content
                .copyWith(color: AppColors.primary, fontSize: 14.0),
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}
