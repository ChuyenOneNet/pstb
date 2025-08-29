import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pstb/app/models/registration_model.dart';
import 'package:pstb/utils/date_time_custom_utils.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/item_text_row.dart';

class ItemSpecificWidget extends StatelessWidget {
  ItemSpecificWidget({Key? key, required this.registration, this.onTap})
      : super(key: key);
  final RegistrationModel registration;
  final Function()? onTap;
  final random = Random();

  @override
  Widget build(BuildContext context) {
    int randomNumber = random.nextInt(20);
    int randomNumber1 = random.nextInt(60);
    final check =
        registration.status == Constants.listStatusSpecific['Chờ thực hiện'];
    return Container(
      decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.lightSilver)),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          if (check)
            ItemTextRow(
              title: 'STT: ',
              content: randomNumber.toString(),
            ),
          if (check)
            ItemTextRow(
                title: 'Thời gian chờ: ',
                content: '${randomNumber1.toString()} phút'),
          ItemTextRow(title: 'Dịch vụ: ', content: registration.name ?? ""),
          ItemTextRow(
              title: 'Phòng: ', content: registration.departmentName ?? ""),
          ItemTextRow(
            title: 'Thời gian: ',
            content:
                DateTimeCustomUtils.parseDateIso(dateTime: registration.time),
          ),
        ],
      ),
    );
  }
}
