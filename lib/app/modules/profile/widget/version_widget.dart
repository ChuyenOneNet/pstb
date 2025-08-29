import 'package:flutter/material.dart';
import 'package:pstb/utils/constants.dart';
import 'package:pstb/utils/styles.dart';

class VersionWidget extends StatelessWidget {
  const VersionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Phiên bản: ${Constants.versionApp}',
          style: Styles.content,
        ),
        const Text(
          'Sản phẩm phát triển bởi Công ty Onenet',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 14.0,
            color: Colors.black,
          ),
        )
      ],
    );
  }
}
