import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pstb/app/modules/home/home_store.dart';
import 'package:pstb/utils/icon_tabbar.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';

class HeaderUnAuthorization extends StatelessWidget {
  const HeaderUnAuthorization({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Xin chào!',
            style: Styles.titleAppbar.copyWith(
              color: AppColors.background,
            ),
          ),
          Text(
            'Hãy đăng nhập để sử dụng toàn bộ tiện ích',
            style: Styles.content.copyWith(
              color: AppColors.background,
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 15.0),
          //   child: Row(
          //     children: [
          //       const Spacer(),
          //       Expanded(
          //         flex: 5,
          //         child: AppButton(
          //           height: 45,
          //           primaryColor: AppColors.background,
          //           title: l10n(context).home_login,
          //           onPressed: () {
          //             Modular.to.pushNamed(AppRoutes.login);
          //           },
          //           borderRadius: const BorderRadius.all(
          //             Radius.circular(8),
          //           ),
          //           labelStyle: Styles.titleButton.copyWith(
          //             color: AppColors.primary,
          //           ),
          //         ),
          //       ),
          //       const SizedBox(width: 8,),
          //       Expanded(
          //         flex: 5,
          //         child: AppButton(
          //           height: 45,
          //           borderRadius: const BorderRadius.all(
          //             Radius.circular(8),
          //           ),
          //           onPressed: () {
          //             Modular.to.pushNamed(AppRoutes.signup);
          //           },
          //           title: l10n(context)!.home_signup,
          //           primaryColor: AppColors.background,
          //           labelStyle: Styles.titleButton.copyWith(
          //               color: AppColors.primary,
          //           ),
          //         ),
          //       ),
          //       const Spacer(),
          //       // GestureDetector(
          //       //   onTap: () {
          //       //     final homeStore = Modular.get<HomeStore>();
          //       //     if (!homeStore.isLogin) {
          //       //       Fluttertoast.showToast(msg: 'Bạn cần đăng nhập');
          //       //     }
          //       //   },
          //       //   child: SvgPicture.asset(
          //       //     TabIcon.notificationActive,
          //       //   ),
          //       // ),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
