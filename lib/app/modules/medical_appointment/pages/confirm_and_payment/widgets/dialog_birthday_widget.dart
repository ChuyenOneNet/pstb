import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/profile/pages/edit_profile_page/edit_profile_store.dart';
import 'package:pstb/app/modules/profile/pages/new_edit_profile_page/widgets/dob_edit_profile.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';

class DialogBirthdayWidget extends StatelessWidget {
  DialogBirthdayWidget({Key? key}) : super(key: key);
  final editController = Modular.get<EditProfileStore>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Nhập ngày sinh',
          style: Styles.titleItem,
        ),
        const SizedBox(
          height: 10,
        ),
        DobEditProfile(),
        Row(
          children: [
            Flexible(
                child: AppButton(
              title: 'Huỷ',
              onPressed: () {
                Navigator.pop(context);
                editController.dobController.text = '';
                Modular.dispose<EditProfileStore>();
              },
              primaryColor: AppColors.error700,
            )),
            const SizedBox(
              width: 4,
            ),
            Flexible(
                child: AppButton(
                    title: 'Xác nhận',
                    onPressed: () async {
                      if (editController.dobController.text.isEmpty) {
                        Flushbar(
                          backgroundColor: AppColors.error700,
                          message: 'Hãy nhập ngày sinh',
                          duration: const Duration(seconds: 1),
                        ).show(context);
                      } else {
                        final profile = Modular.get<EditProfileStore>();
                        profile.mContext = context;
                        await profile.onUpdateUser(
                            birthday: editController.dobController.text);
                      }
                    })),
          ],
        )
      ],
    );
  }
}
