import 'package:flutter/material.dart';
import 'package:pstb/utils/main.dart';

class DescriptionWidget extends StatelessWidget {
  final String title;
  final String description;

  const DescriptionWidget(
      {Key? key, required this.title, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            title,
            style: Styles.titleItem,
          ),
        ),
        Text(
          description,
          style: Styles.content,
        )
      ],
    );
  }
}
