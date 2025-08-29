import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pstb/app/modules/bottom_nav/bottom_nav_store.dart';
import 'package:pstb/app/modules/home/home_store.dart';
import 'package:pstb/utils/colors.dart';
import 'package:pstb/utils/icon_tabbar.dart';
import 'package:pstb/utils/l10n.dart';
import 'package:pstb/utils/routes.dart';
import 'package:pstb/utils/styles.dart';

class UserInfoHeader extends StatelessWidget {
  UserInfoHeader({
    Key? key,
    this.userName,
    this.avatarUri,
  }) : super(key: key);
  final String? userName;
  final String? avatarUri;
  final BottomNavStore _bottomNav = Modular.get<BottomNavStore>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Modular.to.pushNamed(AppRoutes.profileMainPage);
      },
      child: Row(
        children: [
          CircleAvatar(
            // backgroundImage: (avatarUri != null && avatarUri!.isNotEmpty)
            //     ? NetworkImage(avatarUri!)
            //     : null,
            child: (avatarUri == null || avatarUri!.isEmpty)
                ? const Icon(Icons.person)
                : null,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(l10n(context).home_userstack_hello,
                                style: Styles.titleItem
                                    .copyWith(color: AppColors.background)),
                            Text(', ',
                                style: Styles.titleItem
                                    .copyWith(color: AppColors.background)),
                            Text(
                              userName ?? '',
                              style: Styles.titleItem
                                  .copyWith(color: AppColors.background),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  GestureDetector(
                    onTap: () {
                      final homeStore = Modular.get<HomeStore>();
                      if (homeStore.isLogin) {
                        _bottomNav.updateCurrentIndex(5);
                      }
                    },
                    child: SvgPicture.asset(
                      TabIcon.notificationActive,
                      color: AppColors.background,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
