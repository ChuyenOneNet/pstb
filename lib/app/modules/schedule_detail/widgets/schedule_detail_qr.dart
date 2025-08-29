import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/home/home_store.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/app_button.dart';

class ScheduleDetailQr extends StatelessWidget {
  ScheduleDetailQr({
    Key? key,
  }) : super(key: key);
  final HomeStore _homeStore = Modular.get<HomeStore>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: widthConvert(context, 16),
        horizontal: widthConvert(context, 12),
      ),
      child: Container(
        decoration: Styles.cardShadow.copyWith(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                top: widthConvert(context, 20),
                bottom: widthConvert(context, 8),
                left: widthConvert(context, 52),
                right: widthConvert(context, 51),
              ),
              child: Text(
                l10n(context)!.schedule_detail_qr_description!,
                style: Styles.content.copyWith(
                  color: AppColors.neutral900,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: widthConvert(context, 16),
              ),
              child: AppButton(
                onPressed: () => _homeStore.pushToMyQrCode(),
                iconLeft: IconEnums.qrCode1,
                title: l10n(context)!.schedule_detail_qr_checkin!,
                isLeftGradient: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
