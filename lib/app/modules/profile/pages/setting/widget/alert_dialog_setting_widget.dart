import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:pstb/utils/colors.dart';
import 'package:pstb/utils/styles.dart';

class AlertDialogSettingWidget extends StatelessWidget {
  const AlertDialogSettingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Chưa cài đặt mật khẩu', style: Styles.content),
      content: const Text('Hãy cài đặt sinh trắc học'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Huỷ',
              style: Styles.content.copyWith(color: AppColors.primary)),
        ),
        TextButton(
          onPressed: () async {
            Navigator.pop(context);
            // Use openAppSettings instead of openSecuritySettings
            await AppSettings.openAppSettings(); // This opens the app settings
          },
          child: Text(
            'Tới cài đặt',
            style: Styles.content.copyWith(color: AppColors.primary),
          ),
        ),
      ],
    );
  }
}
