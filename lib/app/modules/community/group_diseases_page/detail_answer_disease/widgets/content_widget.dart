import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pstb/app/modules/profile/pages/profile_page/widgets/avatar.dart';
import 'package:pstb/utils/colors.dart';
import 'package:pstb/utils/helper.dart';
import 'package:pstb/utils/styles.dart';

import '../../../../../../utils/constants.dart';

class ContentWidget extends StatelessWidget {
  const ContentWidget({
    Key? key,
    this.questionTitle,
    this.requesterName,
    this.question,
    this.topicName,
    this.createdTime,
    this.answer,
  }) : super(key: key);

  final String? questionTitle;
  final String? requesterName;
  final String? question;
  final String? topicName;
  final String? answer;
  final DateTime? createdTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              requesterName ?? '',
              style: Styles.titleItem.copyWith(color: AppColors.primary),
            ),
            Row(
              children: [
                Text(
                  'Ngày: ',
                  style: Styles.content.copyWith(color: AppColors.black),
                ),
                Text(
                  DateFormat(DateTimeFormatPattern.dobddMMyyyy)
                      .format(createdTime!.toLocal()),
                  style: Styles.content.copyWith(color: AppColors.black),
                ),
              ],
            )
          ],
        ),
        const SizedBox(
          height: 4.0,
        ),
        Text(
          questionTitle ?? '',
          style: Styles.titleItem,
        ),
        const SizedBox(
          height: 4.0,
        ),
        Text(
          question ?? '',
          style: Styles.content,
        ),
        const SizedBox(
          height: 4.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(6.0)),
                      border: Border.all(
                        color: Colors.orange,
                      )),
                  child: Text(
                    topicName ?? '',
                    style: Styles.content
                        .copyWith(color: Colors.orange, fontSize: 13.0),
                  ),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                answer == null
                    ? const SizedBox()
                    : Container(
                        padding: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(6.0)),
                            border: Border.all(
                              color: Colors.lightGreen,
                            )),
                        child: Text(
                          'B.s đã trả lời',
                          style: Styles.content.copyWith(
                              color: Colors.lightGreen, fontSize: 13.0),
                        ),
                      ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(4.0),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
              ),
              child: Text(
                'Xem chi tiết',
                style: Styles.content
                    .copyWith(color: AppColors.background, fontSize: 13.0),
              ),
            ),
          ],
        )
      ],
    );
  }
}
