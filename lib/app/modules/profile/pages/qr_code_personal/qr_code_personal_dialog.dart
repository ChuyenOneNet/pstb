import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/user_app_store.dart';
import 'package:pstb/utils/gender_utils.dart';
import 'package:pstb/utils/main.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodePersonalPage extends StatelessWidget {
  QRCodePersonalPage({Key? key}) : super(key: key);
  final _userAppStore = Modular.get<UserAppStore>();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Mã QR cá nhân',
              style: Styles.content,
            ),
            QrImageView(
              data: '''
              Họ và tên: ${_userAppStore.getUserName},
              Giới tính: ${GenderUtils.parseGenderString(_userAppStore.getUserGender)},
              Số điện thoại: ${_userAppStore.getUserPhone},
              Sinh nhật: ${_userAppStore.getUserDob.split(" ")[0]},
              CMND/CCCD: ${_userAppStore.user.personalId},
              BHYT: ${_userAppStore.user.insuranceNumber},
                  ''',
              version: QrVersions.auto,
            ),
          ],
        ),
      ),
    );
  }
}
