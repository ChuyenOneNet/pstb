import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pstb/app/modules/profile/pages/setting/setting_store.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/utils/sessions/session_prefs.dart';
import 'package:pstb/widgets/stateful/app_input.dart';
import 'package:pstb/widgets/stateless/app_button.dart';

class ConfirmPasswordWidget extends StatelessWidget {
  ConfirmPasswordWidget({Key? key}) : super(key: key);
  final _settingStore = Modular.get<SettingStore>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Nhập mật khẩu',
                  style: Styles.titleItem
                      .copyWith(color: AppColors.primary, fontSize: 18.0)),
              InkWell(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: AppColors.lightSilver,
                  ),
                  child: SvgPicture.asset(
                    IconEnums.close,
                    width: 24,
                    height: 24,
                    fit: BoxFit.contain,
                    color: AppColors.black,
                  ),
                ),
              ),
            ],
          ),
          const Divider(
            color: AppColors.primary,
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 0.0),
                child: SvgPicture.asset(
                  IconEnums.lock,
                  height: 24,
                ),
              ),
              Expanded(
                child: AppInput(
                  autofocus: true,
                  hintText: 'Nhập mật khẩu',
                  iconLeft: IconEnums.lock,
                  obscureText: true,
                  onChangeValue: _settingStore.setPassword,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 32.0,
          ),
          AppButton(
              title: l10n(context)!.confirm.toString().toUpperCase(),
              onPressed: () async {
                await _settingStore.activeFingerPrint();
                if (_settingStore.isActiveFinger) {
                  await SessionPrefs.setActiveFinger(_settingStore.isActiveFinger);
                  Navigator.pop(context);
                  return;
                }
                Fluttertoast.showToast(
                    msg: 'Mật khẩu chưa chính xác',
                    backgroundColor: AppColors.error500);
              })
        ],
      ),
    );
  }
}
