import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pstb/utils/main.dart';

class SearchingMedicalWidget extends StatelessWidget {
  const SearchingMedicalWidget({Key? key, this.isShowTime, this.title})
      : super(key: key);
  final bool? isShowTime;
  final String? title;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        border: Border.all(color: AppColors.lightSilver),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            IconEnums.search,
          ),
          const SizedBox(
            width: 4,
          ),
          Expanded(
              child: Text(title ?? 'Tìm kiếm cơ sở y tế',
                  style: Styles.subtitleSmallest)),
          if (isShowTime == null || isShowTime!)
            Container(
              width: 1,
              height: 12,
              color: AppColors.black,
            ),
          const SizedBox(
            width: 8,
          ),
          if (isShowTime == null || isShowTime!)
            Text(
              'Gần nhất',
              style: Styles.subtitleSmallest,
            ),
        ],
      ),
    );
  }
}
