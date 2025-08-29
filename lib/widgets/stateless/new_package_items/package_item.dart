import 'package:flutter/material.dart';
import 'package:pstb/app/modules/medical_appointment/pages/medical_package_detail/models/medical_model.dart';
import 'package:pstb/utils/format_util.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateful/stateful_widget.dart';
import 'package:pstb/widgets/stateless/package_items/package_name.dart';
import 'package:pstb/widgets/stateless/package_items/package_picture.dart';

class PackageItemWidget extends StatelessWidget {
  const PackageItemWidget({
    Key? key,
    required this.data,
    required this.isLastItem,
    required this.onTap,
  }) : super(key: key);
  final PackageModel data;
  final bool isLastItem;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.background,
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: widthConvert(context, 14),
            right: widthConvert(context, 16),
            top: heightConvert(context, 12),
            // bottom: heightConvert(context, 10),
          ),
          child: Container(
            padding: EdgeInsets.only(bottom: heightConvert(context, 10)),
            decoration: BoxDecoration(
              color: AppColors.background,
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  style: BorderStyle.solid,
                  color:
                      isLastItem ? AppColors.transparent : AppColors.neutral300,
                ),
              ),
            ),
            child: Row(
              children: [
                PackagePicture(
                  imageUri: data.image,
                  iconUri: data.icon,
                ),
                PackageName(
                  name: data.name!,
                  price: FormatUtil.formatMoney(data.price),
                ),
                // data.insurance!
                //     ? InsuranceWithTooltips(isLastItem: isLastItem)
                //     : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        onTap(data);
      },
    );
  }
}
