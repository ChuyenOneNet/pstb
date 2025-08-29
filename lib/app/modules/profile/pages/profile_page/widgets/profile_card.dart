import 'package:flutter/material.dart';
import 'package:pstb/utils/main.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
    this.title,
    required this.widget,
  }) : super(key: key);

  final String? title;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title ?? "",
              style: Styles.content.copyWith(color: AppColors.primary),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.deepBaseShadow,
                      spreadRadius: -2,
                      blurRadius: 30,
                      offset: Offset(0, 2),
                    ),
                    BoxShadow(
                      color: AppColors.primary30004,
                      spreadRadius: -2,
                      blurRadius: 10,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: widget),
          ],
        ));
  }
}
