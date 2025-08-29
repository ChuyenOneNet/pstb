import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pstb/utils/colors.dart';
import 'package:pstb/utils/styles.dart';
import 'package:pstb/widgets/stateful/stateful_widget.dart';

class TabProfileItem extends StatelessWidget {
  final String title;
  final String icon;
  final Function onTab;
  final bool isLastItem;

  const TabProfileItem(
      {Key? key,
      required this.title,
      required this.icon,
      required this.onTab,
      this.isLastItem = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
              color: AppColors.background,
              border: !isLastItem
                  ? const Border(
                      bottom: BorderSide(
                      color: AppColors.neutral200,
                    ))
                  : null),
          child: Row(
            children: [
              Expanded(
                  child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: SvgPicture.asset(
                      icon,
                      width: 16,
                    ),
                  ),
                  Text(
                    title,
                    style:
                        Styles.titleItem.copyWith(color: AppColors.neutral900),
                  )
                ],
              )),
              const Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: AppColors.primary500,
              )
            ],
          ),
        ),
        onTap: onTab);
  }
}
