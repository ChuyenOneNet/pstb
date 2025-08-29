import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:pstb/app/modules/profile/pages/setting/setting_store.dart';
import 'package:pstb/app/modules/profile/pages/setting/widget/alert_dialog_setting_widget.dart';
import 'package:pstb/app/modules/profile/pages/setting/widget/confirm_password_widget.dart';
import 'package:pstb/app/modules/profile/pages/setting/widget/field_icon_widget.dart';
import 'package:pstb/utils/colors.dart';
import 'package:pstb/utils/icons.dart';
import 'package:pstb/utils/l10n.dart';

class FingerPrintWidget extends StatelessWidget {
  FingerPrintWidget({Key? key}) : super(key: key);
  final _settingStore = Modular.get<SettingStore>();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FieldIconWidget(
            svgIcon: Platform.isIOS ? IconEnums.faceId : IconEnums.touch_id,
            title: l10n(context).profile_setting_touch_id,
          ),
        ),
        Observer(builder: (context) {
          return CupertinoSwitch(
            trackColor: AppColors.neutral300,
            activeColor: AppColors.accent500,
            value: _settingStore.isActiveFinger,
            onChanged: (value) async {
              if (_settingStore.isActiveFinger) {
                await _settingStore.authenticateWithBiometrics(
                    l10n(context).verify_identity_to_continue,
                    androidAuthMessages: AndroidAuthMessages(
                      signInTitle: l10n(context).auth_required,
                      biometricHint: l10n(context).verify_identity,
                      cancelButton: l10n(context).cancel,
                    ));
                return;
              }
              if (!_settingStore.notAvailableBiometric) {
                showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      elevation: 0.0,
                      backgroundColor: Colors.transparent,
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10.0,
                              offset: Offset(0.0, 10.0),
                            ),
                          ],
                        ),
                        child: ConfirmPasswordWidget(),
                      ),
                    );
                  },
                );
                return;
              }
              showDialog(
                  context: context,
                  builder: (alertContext) {
                    return const AlertDialogSettingWidget();
                  });
            },
          );
        }),
      ],
    );
  }
}
