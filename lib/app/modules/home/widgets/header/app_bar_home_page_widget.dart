import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/home/home_store.dart';
import 'package:pstb/app/modules/home/widgets/header/user_stack.dart';
import 'package:pstb/utils/colors.dart';
import 'package:pstb/utils/images.dart';
import 'package:pstb/utils/styles.dart';

import '../../../../../widgets/stateless/divider_custom_widget.dart';
import '../../../../../widgets/stateless/medical_unit_widget.dart';
import 'header_unauth.dart';

class AppBarHomePageWidget extends StatelessWidget {
  AppBarHomePageWidget({
    Key? key,
  }) : super(key: key);

  final controller = Modular.get<HomeStore>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 70,
                      width: 70,
                      child: ClipOval(
                        child: Image.asset(
                          ImageEnum.logopstbColor,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MedicalUnitWidget(controller: controller),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Observer(
              builder: (context) {
                return controller.isLogin
                    ? const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: UserStack(),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Opacity(
                          opacity: controller.loadingUser ? 0 : 1,
                          child: const HeaderUnAuthorization(),
                        ),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
