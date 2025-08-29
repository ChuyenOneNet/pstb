import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pstb/utils/colors.dart';
import 'package:pstb/utils/styles.dart';
import 'package:pstb/widgets/stateless/item_text_row.dart';

import '../../../../../../utils/constants.dart';

class CardPersonalWidget extends StatelessWidget {
  const CardPersonalWidget(
      {Key? key,
      this.name,
      this.patientId,
      this.dob,
      this.gender,
      this.personalId,
      this.phoneNumber,
      this.insuranceNumber})
      : super(key: key);
  final String? name;
  final int? patientId;
  final String? dob;
  final String? gender;
  final String? personalId;
  final String? phoneNumber;
  final String? insuranceNumber;

  @override
  Widget build(BuildContext context) {
    String dobNow =
        DateFormat(DateTimeFormatPattern.formatddMMyyyy).format(DateTime.now());
    return Container(
      width: double.infinity,
      decoration: Styles.cardShadow.copyWith(
          color: AppColors.background, borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Thông tin bệnh nhân',
                style: Styles.titleItem,
              ),
            ],
          ),
          const Divider(
            color: AppColors.primary,
          ),
          if (name != null && name!.isNotEmpty)
            Column(
              children: [
                Text(
                  'Tên: $name',
                  style: Styles.content,
                ),
                const SizedBox(
                  height: 4,
                ),
              ],
            ),
          const SizedBox(
            height: 4.0,
          ),
          ItemTextRow(
            title: 'Mã bệnh nhân',
            content: '${patientId ?? ""}',
          ),
          ItemTextRow(
            title: 'Số điện thoại',
            content: phoneNumber ?? "",
          ),
          ItemTextRow(
            title: 'Ngày sinh',
            content: dob ?? "",
          ),
          ItemTextRow(
            title: 'Giới tính',
            content: gender ?? "",
          ),
          if (personalId != null && personalId!.isNotEmpty)
            ItemTextRow(
              title: 'CMT/CCCD',
              content: personalId ?? "",
            ),
          if (insuranceNumber != null && insuranceNumber!.isNotEmpty)
            ItemTextRow(
              title: 'Bảo hiểm y tế',
              content: insuranceNumber ?? "",
            ),
        ],
      ),
    );
  }
}
