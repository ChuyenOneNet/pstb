import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pstb/widgets/stateless/app_bar.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/styles.dart';

class DetailQuestionPage extends StatelessWidget {
  const DetailQuestionPage(
      {Key? key,
      required this.questionTitle,
      required this.requesterName,
      required this.question,
      required this.topicName,
      required this.createdTime,
      required this.replierName,
      required this.answer})
      : super(key: key);

  final String? questionTitle;
  final String? requesterName;
  final String? question;
  final String? topicName;
  final DateTime? createdTime;
  final String? replierName;
  final String? answer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: questionTitle ?? "",
        isBack: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
                      style: Styles.content.copyWith(color: AppColors.primary),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              questionTitle ?? '',
              style: Styles.titleItem,
            ),
            const SizedBox(
              height: 12.0,
            ),
            Text(
              question ?? '',
              style: Styles.content,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
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
                    style: Styles.content.copyWith(
                      color: Colors.orange,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 4.0,
            ),
            const Divider(
              color: AppColors.black,
            ),
            const SizedBox(
              height: 4.0,
            ),
            if (answer != null)
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        replierName ?? 'Tên bác sĩ',
                        style: Styles.titleItem,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Row(
                    children: [
                      Text(
                        answer ?? 'Câu trả lời',
                        style: Styles.content,
                      ),
                    ],
                  ),
                ],
              )
            else
              Center(
                  child: Column(
                children: [
                  Text(
                    'Hiện chưa có câu trả lời cho câu hỏi này.',
                    style: Styles.content,
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  Text(
                    'Vui lòng quay lại sau!',
                    style: Styles.content,
                  ),
                ],
              )),
          ],
        ),
      ),
    );
  }
}
