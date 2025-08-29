import 'package:flutter/material.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/package_items/package_item.dart';

import '../../../app/modules/medical_appointment/pages/medical_package_detail/models/medical_model.dart';

class MedicalPackageGroup extends StatelessWidget {
  const MedicalPackageGroup(
      {Key? key, this.title = '', required this.data, required this.onPress})
      : super(key: key);
  final String title;
  final List<PackageModel> data;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      margin: EdgeInsets.only(
        top: heightConvert(context, 16),
      ),
      padding: EdgeInsets.only(
        top: heightConvert(context, 8),
        bottom: heightConvert(context, 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: widthConvert(context, 16),
            ),
            child: Text(
              title,
              textAlign: TextAlign.left,
              softWrap: true,
              style: Styles.subtitleLarge.copyWith(
                color: AppColors.neutral700,
              ),
            ),
          ),
          Wrap(
            children: List.generate(
              data.length,
              (index) => PackageItemWidget(
                index: index,
                onTap: (data) {
                  onPress(data);
                },
                data: data[index],
                isLastItem: data.length - 1 == index,
              ),
            ),
          )
        ],
      ),
    );
  }
}
