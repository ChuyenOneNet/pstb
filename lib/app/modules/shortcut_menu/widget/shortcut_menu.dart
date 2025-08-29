import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pstb/app/modules/home/home_store.dart';
import 'package:pstb/app/modules/profile/pages/profile_page/widgets/login_his_widget.dart';
import 'package:pstb/app/modules/shortcut_menu/widget/shortcut_menu_customer.dart';
import 'package:pstb/app/modules/shortcut_menu/widget/shortcut_menu_staff.dart';
import 'package:pstb/app/user_app_store.dart';
import 'package:pstb/utils/colors.dart';

class ShortcutMenuWidget extends StatefulWidget {
  ShortcutMenuWidget({Key? key}) : super(key: key);

  @override
  State<ShortcutMenuWidget> createState() => _ShortcutMenuWidgetState();
}

class _ShortcutMenuWidgetState extends State<ShortcutMenuWidget> {
  final controller = Modular.get<HomeStore>();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      if (controller.isStaff) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
              margin: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
              ),
              decoration: BoxDecoration(
                  color: AppColors.background,
                  border: Border.all(color: AppColors.lightSilver),
                  borderRadius: BorderRadius.circular(16.0)),
              child: ShortcutMenuStaff(),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Container(
                padding: const EdgeInsets.only(top: 16.0,),
                margin: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                ),
                decoration: BoxDecoration(
                    color: AppColors.background,
                    border: Border.all(color: AppColors.lightSilver),
                    borderRadius: BorderRadius.circular(16.0)),
                child: ShortcutMenuCustomer()),
          ],
        );
      } else {
        return Container(
            padding: const EdgeInsets.only(top: 16.0,),
            margin: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
            ),
            decoration: BoxDecoration(
                color: AppColors.background,
                border: Border.all(color: AppColors.lightSilver),
                borderRadius: BorderRadius.circular(16.0)),
            child: ShortcutMenuCustomer());
      }
    });
  }
}
