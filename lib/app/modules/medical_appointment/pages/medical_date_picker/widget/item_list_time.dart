import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateful/stateful_widget.dart';

import '../model/TimeObject.dart';

class BuildTimeItem extends StatelessWidget {
  const BuildTimeItem({
    Key? key,
    required this.list,
    required this.index,
    required this.onTap,
    this.idTimePicked,
    this.specialLastItem,
  }) : super(key: key);

  final List<TimeObject> list;
  final int index;
  final int? idTimePicked;
  final Function(int) onTap;
  final bool? specialLastItem;

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: idTimePicked == list[index].id
              ? AppColors.primary
              : AppColors.background,
          borderRadius: BorderRadius.circular(4),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadowBaseShadow,
              spreadRadius: 4,
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
          border: Border.all(color: AppColors.lightSilver),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 2),
        width: widthConvert(context, 100),
        height: heightConvert(context, 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              DateFormat(DateTimeFormatPattern.formatHHmm)
                  .format(list[index].date),
              style: Styles.subtitleSmallest.copyWith(
                  color: (idTimePicked == list[index].id)
                      ? AppColors.background
                      : AppColors.black,
                  fontSize: 16),
            ),
          ],
        ),
      ),
      onTap: () {
        onTap(list[index].id);
      },
      disabled: list[index].booked,
    );
  }
}
