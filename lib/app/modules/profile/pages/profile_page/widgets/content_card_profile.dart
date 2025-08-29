import 'package:flutter/material.dart';
import 'package:pstb/utils/main.dart';

class ContentCardProfile extends StatelessWidget {
  const ContentCardProfile({
    Key? key,
    required this.title1,
    required this.title2,
    required this.context1,
    required this.context2,
  }) : super(key: key);

  final String title1;
  final String title2;
  final String context1;
  final String context2;

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
            flex: 9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title1,
                    style:
                        Styles.content.copyWith(color: AppColors.neutral600)),
                Text(context1,
                    style: Styles.titleItem.copyWith(
                        color: AppColors.neutral900,
                        overflow: TextOverflow.ellipsis))
              ],
            )),
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(title2,
                  style: Styles.content.copyWith(color: AppColors.neutral600)),
              Text(context2,
                  style: Styles.titleItem.copyWith(color: AppColors.neutral900))
            ],
          ),
        )
      ],
    );
  }
}
