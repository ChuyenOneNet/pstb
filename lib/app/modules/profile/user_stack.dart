import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/profile/user_header.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';

import '../../user_app_store.dart';

class UserStack extends StatelessWidget {
  final UserAppStore _userAppStore = Modular.get<UserAppStore>();

  UserStack({
    Key? key,
    required this.pushToMyQrCode,
    this.padding,
    this.hello = false,
    this.isLogout = false,
  }) : super(key: key);

  final EdgeInsets? padding;
  final Function pushToMyQrCode;
  final bool? hello;
  final bool? isLogout;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Observer(
            builder: (_) {
              if (_userAppStore.loadingUserData) {
                return Container(
                  alignment: Alignment.center,
                  child: const AppCircleLoading(),
                );
              }
              // return SizedBox();
              return UserInfoHeader(
                userName: isNotEmptyNullString(_userAppStore.user.fullName)
                    ? (hello! ? l10n(context)!.home_userstack_hello! : "") +
                        _userAppStore.user.fullName
                    : (hello! ? l10n(context)!.home_userstack_hello! : "") +
                            _userAppStore.user.username ??
                        '',
                avatarUri: _userAppStore.user.avatar,
              );
            },
          ),
        ),
      ],
    );
  }
}
