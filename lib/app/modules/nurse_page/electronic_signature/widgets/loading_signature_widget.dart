import 'package:flutter/material.dart';
import 'package:pstb/utils/colors.dart';
import 'package:pstb/widgets/stateless/shimmer_loading.dart';

class LoadingSignatureWidget extends StatelessWidget {
  const LoadingSignatureWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShimmerLoadingWidget(
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_, index) {
          return Container(
            width: double.infinity,
            height: 60,
            color: AppColors.lightSilver,
          );
        },
        itemCount: 5,
        separatorBuilder: (_, index) {
          return const Divider();
        },
      ),
    );
  }
}
