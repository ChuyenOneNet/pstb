import 'package:flutter/material.dart';
import 'package:pstb/utils/main.dart';

class PackageDetailTitle extends StatelessWidget {
  const PackageDetailTitle({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 16.0, right: 16, top: 10, bottom: 10),
      child: Row(
        children: [
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  title,
                  softWrap: true,
                  style: Styles.heading4.copyWith(color: AppColors.primary),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 5),
                  child: Divider(
                    color: AppColors.primary,
                    thickness: 2,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
