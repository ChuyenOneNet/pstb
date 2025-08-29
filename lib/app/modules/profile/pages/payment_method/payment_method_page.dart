import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';

class PaymentMethodPage extends StatefulWidget {
  const PaymentMethodPage({Key? key}) : super(key: key);

  @override
  _PaymentMethodPageState createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: l10n(context)!.payment_title!,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: widthConvert(context, 16),
        ),
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                top: widthConvert(context, 10),
              ),
              child: AppButton(
                title: l10n(context)!.payment_add_debit_card!,
                backgroundColor: AppColors.neutral100bg,
                labelStyle: Styles.titleItem.copyWith(
                  color: AppColors.primary500,
                ),
                iconLeft: IconEnums.plusCircle,
                iconLeftColor: AppColors.primary500,
                borderRadius: BorderRadius.circular(8),
                onPressed: () => Modular.to.pushNamed(AppRoutes.debit),
              ),
            ),
            AppButton(
              title: l10n(context)!.payment_add_atm_card!,
              backgroundColor: AppColors.neutral100bg,
              labelStyle: Styles.titleItem.copyWith(
                color: AppColors.primary500,
              ),
              iconLeft: IconEnums.plusCircle,
              iconLeftColor: AppColors.primary500,
              borderRadius: BorderRadius.circular(8),
              onPressed: () => Modular.to.pushNamed(AppRoutes.bankList),
            ),
          ],
        ),
      ),
    );
  }
}
