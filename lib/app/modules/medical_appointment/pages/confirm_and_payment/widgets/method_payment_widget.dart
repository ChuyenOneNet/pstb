import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pstb/utils/main.dart';

class MethodPaymentWidget extends StatelessWidget {
  const MethodPaymentWidget({Key? key, this.methodPayment, this.typePayment})
      : super(key: key);
  final String? methodPayment;
  final String? typePayment;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  SvgPicture.asset(
                    IconEnums.moneyWallet1,
                    color: AppColors.black,
                    width: 20,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    'Thanh Toán',
                    style: Styles.content.copyWith(color: AppColors.black),
                  ),
                ],
              ),
            ),
            Text(
              methodPayment ?? 'Tại Cơ sở y tế',
              style: Styles.titleItem,
            ),
          ],
        ),
      ],
    );
  }
}
