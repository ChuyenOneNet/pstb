import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/profile/pages/profile_page/widgets/avatar.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/app_button.dart';

class UserInfoHeader extends StatelessWidget {
  const UserInfoHeader({
    Key? key,
    this.userName,
    this.avatarUri,
  }) : super(key: key);
  final String? userName;
  final String? avatarUri;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heightConvert(context, 200),
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 4),
                    color: AppColors.shadow,
                  )
                ],
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            height: heightConvert(context, 150),
            padding: const EdgeInsets.only(top: 40),
            margin: const EdgeInsets.only(top: 40),
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    userName!,
                    style: TextStyle(color: AppColors.primary, fontSize: 16),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                AppButton(
                    title: 'Hoàn thiện hồ sơ',
                    height: heightConvert(context, 40),
                    width: widthConvert(context, 160),
                    borderRadius: BorderRadius.circular(20),
                    labelStyle: Styles.content
                        .copyWith(foreground: Styles.defaultGradientPaint),
                    onPressed: () {
                      Modular.to.pushNamed(AppRoutes.profileMainPage);
                    })
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AvatarProfile(
                  size: 80,
                  urlNetWork: avatarUri,
                  showEditAvatar: false,
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: widthConvert(context, 10),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
