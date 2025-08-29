import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/bottom_nav/bottom_nav_store.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';

class LogInBtn extends StatelessWidget {
  final Function? logInBtnOnPressed;

  LogInBtn({Key? key, this.logInBtnOnPressed}) : super(key: key);
  final BottomNavStore _bottomNav = Modular.get<BottomNavStore>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AppButton(
      title: 'Đăng nhập',
      labelStyle: Styles.titleButton.copyWith(fontSize: 16.0),
      onPressed: () {
        print('on press log-in');
        if (logInBtnOnPressed != null) {
          logInBtnOnPressed!();
        } else {
          Modular.to.popAndPushNamed(AppRoutes.login).then(
                (value) => {
                  _bottomNav.updateCurrentIndex(4),
                  Modular.to.popAndPushNamed(AppRoutes.main),
                },
              );
        }
      },
      primaryColor: AppColors.primary,
      borderColor: const Color(0xFAC7C5C5),
    );
  }
}

class SignInBtn extends StatelessWidget {
  final Function? signInBtnOnPressed;

  const SignInBtn({Key? key, this.signInBtnOnPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AppButton(
      title: 'Đăng ký',
      onPressed: () {
        if (signInBtnOnPressed != null) {
          signInBtnOnPressed!();
        } else {
          Modular.to.pushNamed(AppRoutes.signup);
        }
      },
      labelStyle: Styles.titleButton
          .copyWith(fontSize: 16.0, color: const Color(0xFC1D4CC2)),
      primaryColor: Colors.white,
      borderColor: const Color(0xFAC7C5C5),
    );
  }
}
