import 'package:flutter/material.dart';
import 'package:pstb/utils/colors.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoadingWidget extends StatelessWidget {
  const ShimmerLoadingWidget({Key? key, this.child}) : super(key: key);
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: AppColors.lightSilver,
        highlightColor: AppColors.background,
        child: child ??
            Container(
              width: double.infinity,
              height: 200,
              color: AppColors.error500,
            ));
  }
}
