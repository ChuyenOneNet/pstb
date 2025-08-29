import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/route_guard.dart';
import 'package:pstb/utils/format_util.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';

import '../medical_package_detail_store.dart';

class BookNowWidget extends StatelessWidget {
  final MedicalPackageDetailStore _medicalPackageDetailStore =
      Modular.get<MedicalPackageDetailStore>();
  final UserGuard _userGuard = UserGuard();

  BookNowWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String price =
        FormatUtil.formatMoney(_medicalPackageDetailStore.package.packagePrice);
    return Container(
      color: AppColors.background,
      padding: EdgeInsets.symmetric(
        horizontal: widthConvert(context, 16),
        vertical: heightConvert(context, 10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  price,
                  style: Styles.bodyBold.copyWith(color: AppColors.neutral900),
                ),
                Text(
                  formatCurrency(_medicalPackageDetailStore.package.count
                          ?.toString()) +
                      l10n(context)!.medical_detail_booking!,
                  style: Styles.bodyRegular.copyWith(color: AppColors.primary),
                ),
              ],
            ),
          ),
          Expanded(
            child: DecoratedBox(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary500,
                    spreadRadius: -12,
                    blurRadius: 10,
                    offset: Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
              child: AppButton(
                onPressed: () async {
                  UserStatus isLogin = await _userGuard.canActivate();
                  if (isLogin == UserStatus.Signed) {
                    _medicalPackageDetailStore
                        .navigateTo(AppRoutes.selectDoctor);
                  }
                  if (isLogin == UserStatus.NoData) {
                    return Modular.to.pushNamed(AppRoutes.authGuardPage,
                        arguments: {
                          "isNotFromBottomNav": true,
                          "title": l10n(context)!.medical_detail_book_now
                        });
                  }
                },
                iconLeft: IconEnums.calendar,
                title: l10n(context)!.medical_detail_book_now!,
                isLeftGradient: true,
              ),
            ),
          )
        ],
      ),
    );
  }
}
