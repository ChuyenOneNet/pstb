import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pstb/app/modules/profile/pages/qr_code_personal/qr_code_personal_dialog.dart';
import 'package:pstb/app/modules/profile/profile_store.dart';
import 'package:pstb/app/user_app_store.dart';
import 'package:pstb/utils/helpers/config_helper.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/divider_custom_widget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../pages/profile_page/widgets/login_his_widget.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: 16),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: IconEnums.listIconPersonal.length,
      itemBuilder: (_, index) {
        final icon = IconEnums.listIconPersonal[index];
        final title = Constants.listTitlePersonalScreen[index];
        return InkWell(
          onTap: () {
            final _userStore = Modular.get<UserAppStore>();
            final _profileStore = Modular.get<ProfileStore>();
            if (index != 4 && index != 5 && index != 3) {
              Modular.to.pushNamed(Constants.listRoutes[index]);
              return;
            }
            if (index == 4) {
              final phoneCall = ConfigHelper.instance
                  .getConfigByCodeSync(ConfigHelper.sosLine)
                  ?.value;
              launchUrlString("tel://$phoneCall");
              return;
            }
            // if (index == 6) {
            //   // requestPermission(context);
            //   Modular.to.pushNamed(AppRoutes.profileStepsFood,
            //   );
            //   return;
            // }
            _profileStore.onPushQRCode();
            if (_profileStore.isGenerateQRCode) {
              showDialog(
                  context: context, builder: (_) => QRCodePersonalPage());
            } else {
              Fluttertoast.showToast(msg: 'Bạn cần hoàn tất thông tin cá nhân');
              return;
            }
          },
          child: ListTile(
            leading: SvgPicture.asset(
              icon,
              height: 30,
              width: 30,
              color: Colors.black.withOpacity(0.6),
            ),
            title: Text(title, style: Styles.content),
            trailing: const Icon(
              Icons.chevron_right,
              color: AppColors.lightSilver,
            ),
          ),
        );
      },
      separatorBuilder: (_, index) {
        return const DividerCustomWidget();
      },
    );
  }
}
