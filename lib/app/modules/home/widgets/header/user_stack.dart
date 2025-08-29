import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/home/widgets/greeting/greeting_widget.dart';
import 'package:pstb/app/modules/home/widgets/header/user_info_header.dart';
import 'package:pstb/app/user_app_store.dart';

class UserStack extends StatelessWidget {
  const UserStack({
    Key? key,
    this.padding,
    this.isLogout = false,
  }) : super(key: key);

  final EdgeInsets? padding;
  final bool? isLogout;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ??
          const EdgeInsets.symmetric(
            horizontal: 0,
          ).copyWith(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GreetingWidget(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Observer(
                  builder: (_) {
                    final _appStore = Modular.get<UserAppStore>();
                    if (_appStore.loadingUserData) {
                      return const SizedBox.shrink();
                    }
                    return UserInfoHeader(
                      userName: _appStore.getUserName,
                      avatarUri: _appStore.user.avatar,
                    );
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
