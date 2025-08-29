import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/login/login_store.dart';
import 'package:pstb/utils/main.dart';

class RemovePhoneWidget extends StatelessWidget {
  RemovePhoneWidget({Key? key}) : super(key: key);
  final _store = Modular.get<LoginStore>();
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text("Đăng nhập tài khoản khác"),
      content: const Text(
          "Bạn sẽ thoát tài khoản hiện tại, bạn sẽ phải kích hoạt lại một số chức năng. Bạn có thực sự muốn đổi tài khoản?"),
      actions: <Widget>[
        CupertinoDialogAction(
          child: const Text("Huỷ"),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        CupertinoDialogAction(
          child: const Text(
            "Đồng ý",
            style: TextStyle(color: AppColors.error700),
          ),
          onPressed: () async {
            await _store.clearCache();
            Navigator.pop(context, true);
          },
        )
      ],
    );
  }
}
