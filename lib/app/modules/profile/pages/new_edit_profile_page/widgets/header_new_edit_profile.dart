import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../../../utils/l10n.dart';
import '../../../../../../widgets/stateful/touchable_opacity.dart';
import '../../../../../../widgets/stateless/bottom_sheets/picker_image_bottomsheet.dart';
import '../../edit_profile_page/edit_profile_store.dart';
import '../../profile_page/widgets/avatar.dart';

class HeaderNewEditProfilePage extends StatefulWidget {
  const HeaderNewEditProfilePage({Key? key}) : super(key: key);

  @override
  State<HeaderNewEditProfilePage> createState() =>
      _HeaderNewEditProfilePageState();
}

class _HeaderNewEditProfilePageState extends State<HeaderNewEditProfilePage> {
  final _editProfileController = Modular.get<EditProfileStore>();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: AvatarProfile(
          urlNetWork: _editProfileController.avatar,
          size: 100,
          localPath: _editProfileController.localAvatarPath,
        ),
      );
    });
  }
}
