import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pstb/utils/main.dart';

class DateTimeBookingWidget extends StatelessWidget {
  const DateTimeBookingWidget({Key? key, this.timer, this.date})
      : super(key: key);
  final String? timer;
  final String? date;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          SvgPicture.asset(
            IconEnums.calendar_clock1regular,
            width: 24,
            color: AppColors.black,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text('Giờ hẹn: ',style: Styles.titleItem.copyWith(
              color: Colors.black
            ),),
          ),
          Chip(
            backgroundColor: AppColors.primary.withOpacity(0.2),
            label: Row(
              children: [
                SvgPicture.asset(
                  IconEnums.clock,
                  width: 20,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  date ?? '',
                  style: Styles.content.copyWith(
                    color: AppColors.primary
                  ),                ),
              ],
            ),
          ),
          const SizedBox(
            width: 4,
          ),
          Chip(
              backgroundColor: AppColors.primary.withOpacity(0.2),
              label: Row(
                children: [
                  SvgPicture.asset(
                    IconEnums.clock,
                    width: 20,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    timer ?? '',
                    style: Styles.content.copyWith(
                      color: AppColors.primary
                    ),                  ),
                ],
              )),
        ],
      ),
    );
  }
}
