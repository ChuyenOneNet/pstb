import 'package:flutter/material.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/helper.dart';


class EHRDialog extends StatelessWidget {
  final Widget child;

  const EHRDialog({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            width: widthConvert(context, 375),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.shadowBaseShadow,
                  spreadRadius: 4,
                  blurRadius: 4,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: child),
      ],
    );
  }
}
