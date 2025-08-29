import 'package:flutter/material.dart';
import 'package:pstb/utils/main.dart';

import 'content_widget.dart';

class CardContentWidget extends StatelessWidget {
  const CardContentWidget(
      {Key? key,
      this.requesterName,
      this.requesterImage,
      this.replierName,
      this.replierImage,
      this.question,
      this.answer,
      this.topicName,
      this.createdTime,
      this.questionTitle})
      : super(key: key);

  final String? requesterName;
  final String? question;
  final String? answer;
  final String? requesterImage;
  final String? replierName;
  final String? replierImage;
  final String? topicName;
  final DateTime? createdTime;
  final String? questionTitle;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          ContentWidget(
            requesterName: requesterName,
            questionTitle: questionTitle,
            question: question,
            topicName: topicName,
            createdTime: createdTime,
            answer: answer,
          ),
        ],
      ),
    );
  }
}
