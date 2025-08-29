import 'package:flutter/material.dart';
import 'package:pstb/utils/styles.dart';

class ItemTextRow extends StatelessWidget {
  const ItemTextRow({Key? key, required this.title, required this.content})
      : super(key: key);
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 4.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Styles.content,
          ),
          Flexible(
            child: Text(
              content,
              style: Styles.titleItem,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
