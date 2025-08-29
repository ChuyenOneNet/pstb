import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateful/touchable_opacity.dart';

class ScheduleDetailTimeWidget extends StatelessWidget {
  final String title, description;
  final Function? onPressNotify;
  final bool hasNoti;
  final Color? titleColor;
  const ScheduleDetailTimeWidget({
    Key? key,
    required this.title,
    required this.description,
    this.onPressNotify,
    required this.hasNoti,
    this.titleColor = AppColors.grayLight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  title,
                  style: Styles.content.copyWith(
                    color: titleColor!,
                  ),
                ),
              ),
              Text(
                description,
                style: Styles.content.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.neutral900,
                ),
              ),
            ],
          ),
        ),
        hasNoti
            ? TouchableOpacity(
                onTap: () => onPressNotify!(),
                child: Container(
                  height: widthConvert(context, 32),
                  width: widthConvert(context, 32),
                  decoration: BoxDecoration(
                    color: AppColors.warning100,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: SvgPicture.asset(
                          IconEnums.notiBell,
                          color: AppColors.warning900,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: widthConvert(context, 9),
                          width: widthConvert(context, 9),
                          decoration: BoxDecoration(
                            color: AppColors.primary500,
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: Icon(
                            Icons.add,
                            size: widthConvert(context, 8),
                            color: AppColors.background,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
