import 'package:flutter/material.dart';
import 'package:pstb/utils/main.dart';

class PackageName extends StatelessWidget {
  const PackageName({
    Key? key,
    this.name = '',
    this.price = '',
  }) : super(key: key);
  final String name;
  final String? price;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: widthConvert(context, 19),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: Styles.bodyBold,
              softWrap: true,
            ),
            Padding(
              padding: EdgeInsets.only(top: heightConvert(context, 4)),
              child: Text(
                price!,
                style: Styles.subtitleSmall.copyWith(
                  color: AppColors.primary,
                ),
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
