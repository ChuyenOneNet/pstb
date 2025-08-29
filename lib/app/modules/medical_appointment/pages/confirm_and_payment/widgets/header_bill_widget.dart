import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pstb/app/modules/medical_appointment/pages/confirm_and_payment/widgets/qr_code_widget.dart';
import 'package:pstb/utils/main.dart';

class HeaderBillWidget extends StatelessWidget {
  const HeaderBillWidget(
      {Key? key,
      this.codeBill,
      this.name,
      this.status,
      this.imageQr,
      this.idPatient,
      this.timer,
      this.date})
      : super(key: key);
  final String? codeBill;
  final String? name;
  final int? idPatient;
  final String? timer;
  final String? date;
  final String? status;
  final Uint8List? imageQr;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Styles.cardShadow.copyWith(
          color: AppColors.background, borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Thông tin đặt khám',
                style: Styles.titleItem,
              ),
            ],
          ),
          const Divider(
            color: AppColors.primary,
          ),
          if (codeBill != null && codeBill!.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Mã phiếu khám: ',
                  style: Styles.content,
                ),
                Text(
                  codeBill ?? '',
                  style: Styles.titleItem,
                ),
              ],
            ),
          const SizedBox(
            height: 4.0,
          ),
          _SetUser(name: name),
          const SizedBox(
            height: 4.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Ngày khám: ',
                style: Styles.content,
              ),
              Text(
                date ?? '',
                style: Styles.titleItem,
              ),
            ],
          ),
          const SizedBox(
            height: 4.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Giờ khám: ',
                style: Styles.content,
              ),
              Text(
                timer ?? '',
                style: Styles.titleItem.copyWith(color: AppColors.primary),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SetUser extends StatelessWidget {
  const _SetUser({
    Key? key,
    required this.name,
  }) : super(key: key);

  final String? name;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              'Người đặt: ',
              style: Styles.content,
            ),
          ],
        ),
        Text(
          name ?? '',
          style: Styles.titleItem.copyWith(color: AppColors.black),
        )
      ],
    );
  }
}
