import 'package:flutter/material.dart';
import 'package:pstb/utils/format_util.dart';
import 'package:pstb/widgets/stateless/divider_custom_widget.dart';
import 'package:pstb/widgets/stateless/new_package_items/package_name.dart';
import 'package:pstb/widgets/stateless/new_package_items/package_picture.dart';

import '../../../app/modules/medical_appointment/pages/medical_package_detail/models/medical_model.dart';
import '../../../utils/l10n.dart';

class PackageItemWidget extends StatelessWidget {
  const PackageItemWidget({
    Key? key,
    required this.data,
    required this.isLastItem,
    required this.onTap,
    required this.index,
  }) : super(key: key);
  final PackageModel data;
  final bool isLastItem;
  final Function onTap;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: AspectRatio(
                    aspectRatio: 1.2,
                    child: PackagePicture(
                      imageUri: data.image,
                      iconUri: data.icon,
                    ),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: PackageName(
                    name: data.name ?? "",
                    description:
                        data.description ?? l10n(context)!.medical_description,
                    sale: data.disCount,
                    price: FormatUtil.formatMoney(data.price),
                    onClickDetailBtn: onTap,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
