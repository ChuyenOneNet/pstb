import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pstb/utils/main.dart';

class ScheduleDetailPlace extends StatelessWidget {
  final String? place;
  final bool isUpcoming;
  const ScheduleDetailPlace({
    Key? key,
    required this.place,
    required this.isUpcoming,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: widthConvert(context, 12),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: widthConvert(context, 16),
        ),
        decoration: const BoxDecoration(
          color: AppColors.background,
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: AppColors.neutral200,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    bottom: widthConvert(context, 12),
                  ),
                  child: Text(
                    isUpcoming
                        ? l10n(context)!.schedule_detail_sample_addr
                        : l10n(context)!.schedule_detail_exam_addr,
                    style: Styles.content.copyWith(
                      color: AppColors.neutral900,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    // top: widthConvert(context, 4),
                    right: widthConvert(context, 6),
                  ),
                  child: SvgPicture.asset(
                    IconEnums.mapPin,
                    color: AppColors.primary500,
                    height: widthConvert(context, 24),
                    width: widthConvert(context, 20),
                  ),
                ),
                Expanded(
                  child: Text(
                    place ?? "",
                    style: Styles.content.copyWith(
                      color: AppColors.primary500,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
