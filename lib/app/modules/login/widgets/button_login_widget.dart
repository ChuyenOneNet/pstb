import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pstb/app/modules/login/login_store.dart';
import 'package:pstb/utils/colors.dart';
import 'package:pstb/utils/constants.dart';
import 'package:pstb/utils/icons.dart';
import 'package:pstb/utils/l10n.dart';
import 'package:pstb/utils/styles.dart';
import 'package:pstb/widgets/stateful/touchable_opacity.dart';

class ButtonLoginWidget extends StatelessWidget {
  const ButtonLoginWidget({
    Key? key,
    required this.onLogin,
    required this.onBiometric,
  }) : super(key: key);

  final Function() onLogin;
  final Function() onBiometric;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: ViewConstants.defaultBorderRadiusBtn),
      child: Stack(
        children: [
          Observer(builder: (context) {
            final _loginController = Modular.get<LoginStore>();
            if (_loginController.phoneNumberCache.isEmpty) {
              return const SizedBox();
            }
            return TouchableOpacity(
                onTap: onBiometric,
                child: SvgPicture.asset(
                  Platform.isIOS ? IconEnums.faceId : IconEnums.touch_id,
                  height: Constants.buttonHeight - 4,
                  color: AppColors.primary,
                ));
          }),
          Row(
            children: [
              const Spacer(),
              Expanded(
                flex: 3,
                child: InkWell(
                  onTap: onLogin,
                  child: Ink(
                    height: Constants.buttonHeight,
                    child: Center(
                      child: Text(
                        l10n(context).home_login,
                        style: Styles.titleButton,
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(
                          ViewConstants.defaultBorderRadiusBtn),
                    ),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(
            width: 8,
          ),
        ],
      ),
    );
  }
}
