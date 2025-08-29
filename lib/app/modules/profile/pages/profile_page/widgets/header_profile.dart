import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/profile/pages/edit_profile_page/edit_profile_store.dart';
import 'package:pstb/app/modules/profile/pages/profile_page/widgets/avatar.dart';
import 'package:pstb/app/modules/profile/profile_store.dart';
import 'package:pstb/utils/l10n.dart';
import 'package:pstb/widgets/stateless/bottom_sheets/picker_image_bottomsheet.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../../user_app_store.dart';

class HeaderProfilePage extends StatefulWidget {
  HeaderProfilePage({Key? key}) : super(key: key);

  @override
  State<HeaderProfilePage> createState() => _HeaderProfilePageState();
}

class _HeaderProfilePageState extends State<HeaderProfilePage> {
  // final _controller = Modular.get<AppStore>();
  final UserAppStore _userAppStore = Modular.get<UserAppStore>();

  final _profileController = Modular.get<ProfileStore>();

  Future<void> _askCameraPermission() async {
    //final permissionStatus = await Permission.camera.request();

    // if (permissionStatus == PermissionStatus.granted ||
    //     permissionStatus == PermissionStatus.permanentlyDenied) {
    PickerImageBottomSheet.show(
        context: context,
        title: l10n(context)!.update_avatar,
        checkOpenFile: false,
        cameraPurposeMessage:
            "Ứng dụng cần truy cập camera để chụp ảnh cập nhật ảnh đại diện.",
        photoPurposeMessage:
            "Ứng dụng cần truy cập thư viện để chọn ảnh cập nhật ảnh đại diện.",
        onDone: (image) {
          _profileController.onChangeAvatar(image);
        },
        onDoneFile: (file) {});
    // } else {
    //   showDialog(
    //       context: context,
    //       builder: (BuildContext context) => CupertinoAlertDialog(
    //             title: Text(l10n(context).camera_permission),
    //             content: Text(l10n(context).camera_permission_content),
    //             actions: <Widget>[
    //               CupertinoDialogAction(
    //                 child: Text(l10n(context)!.deny),
    //                 onPressed: () => Navigator.of(context).pop(),
    //               ),
    //               CupertinoDialogAction(
    //                   child: Text(l10n(context)!.setting),
    //                   onPressed: () {
    //                     openAppSettings();
    //                     Navigator.of(context).pop();
    //                   }),
    //             ],
    //           ));
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return Align(
          alignment: Alignment.center,
          child: InkWell(
            onTap: () {
              _askCameraPermission();
            },
            child: AvatarProfile(
              urlNetWork: _profileController.avatar,
              size: 100,
              localPath: _profileController.localAvatarPath,
            ),
          ),
        );
      },
    );
  }
}
