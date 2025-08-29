import 'package:flutter/material.dart';

import '../../utils/colors.dart';
class ContentEasyLoadingWidget extends StatelessWidget {
  const ContentEasyLoadingWidget({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(color: AppColors.surfaceLight,);
  }
}
