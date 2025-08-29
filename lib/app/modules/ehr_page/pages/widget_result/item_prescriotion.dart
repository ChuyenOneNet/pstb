import 'package:flutter/material.dart';
import 'package:pstb/utils/colors.dart';
import 'package:pstb/utils/styles.dart';

class ItemPrescriptionWidget extends StatelessWidget {
  const ItemPrescriptionWidget(
      {Key? key, required this.prescriptions, this.onTap})
      : super(key: key);
  final String prescriptions;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.lightSilver,
            borderRadius: BorderRadius.circular(4)),
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Text(
              prescriptions,
              style: Styles.content,
            )),
            const Icon(
              Icons.chevron_right,
              color: AppColors.gray500,
            ),
          ],
        ),
      ),
    );
  }
}
