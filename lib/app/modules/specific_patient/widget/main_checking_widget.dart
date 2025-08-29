import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pstb/app/modules/community/widgets/box_icon_widget.dart';
import 'package:pstb/app/route_guard.dart';
import 'package:pstb/utils/main.dart';

class MainCheckingWidget extends StatelessWidget {
  const MainCheckingWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BoxIconWidget(
                  onTap: () {
                    Modular.to.pushNamed(AppRoutes.selectDoctor);
                  },
                  title: 'Tìm kiếm\nBác sỹ, Điều dưỡng',
                  svgPicture: IconEnums.iconSearchingNurse),
              BoxIconWidget(
                  onTap: () async {
                    // Fluttertoast.showToast(
                    //     msg: 'Tính năng đang trong giai đoạn phát triển');
                    final status = await UserGuard().canActivate();
                    if (status == UserStatus.Signed) {
                      Modular.to.pushNamed(AppRoutes.checkingSpecific);
                    } else {
                      Modular.to.pushNamed(AppRoutes.authGuardPage, arguments: {
                        "isNotFromBottomNav": true,
                        "title": 'Thông tin chỉ định DVKT'
                      });
                    }
                  },
                  title: 'Thông tin\nchỉ định DVKT',
                  svgPicture: IconEnums.iconSpecificPatient),
            ],
          ),
        ),
      ],
    );
  }
}
