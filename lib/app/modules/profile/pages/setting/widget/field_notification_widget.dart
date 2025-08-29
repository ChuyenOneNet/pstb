import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/profile/pages/setting/setting_store.dart';
import 'package:pstb/app/modules/profile/pages/setting/widget/field_icon_widget.dart';
import 'package:pstb/utils/colors.dart';
import 'package:pstb/utils/icons.dart';
import 'package:pstb/utils/l10n.dart';
import 'package:pstb/utils/styles.dart';

class FieldNotificationWidget extends StatelessWidget {
  FieldNotificationWidget({Key? key}) : super(key: key);
  final _settingStore = Modular.get<SettingStore>();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: FieldIconWidget(
                  svgIcon: IconEnums.notificationBell,
                  title: l10n(context).bottom_bar_notification,
                ),
              ),
              CupertinoSwitch(
                trackColor: AppColors.neutral300,
                activeColor: AppColors.accent500,
                value: _settingStore.isNotification,
                onChanged: (isActive) async {
                  await _settingStore.activeNotification();
                },
              ),
            ],
          ),
          if (_settingStore.isShowAlertNotification)
            Text(
              'Thông báo chưa được mở hãy vào cài đặt',
              style: Styles.content.copyWith(color: AppColors.error700),
            ),
          if (_settingStore.isShowAlertNotification)
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                child: Text(
                  'Cài đặt',
                  style: Styles.content,
                ),
                onPressed: () async {
                  // Use openAppSettings if openNotificationSettings is not available
                  await AppSettings.openAppSettings();
                },
              ),
            )
        ],
      );
    });
  }
}
