import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pstb/app/modules/bottom_nav/bottom_nav_store.dart';
import '../../../../utils/main.dart';

class BackLoginWidget extends StatelessWidget {
  BackLoginWidget({
    Key? key,
  }) : super(key: key);
  final BottomNavStore _bottomNav = Modular.get<BottomNavStore>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _bottomNav.updateCurrentIndex(4);
        Modular.to.popAndPushNamed(AppRoutes.main);
      },
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(194, 198, 201, 0.3),
                    offset: Offset(2, 3),
                  ),
                ],
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(4),
                    bottomRight: Radius.circular(4))),
            padding: const EdgeInsets.only(left: 16, top: 4, bottom: 2),
            margin: const EdgeInsets.only(top: 10, left: 44),
            child: Text(
              'QUAY LẠI TRANG CHỦ ',
              style: Styles.titleItem.copyWith(color: AppColors.primary),
            ),
          ),
          Container(
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(194, 198, 201, 0.3),
                    offset: Offset(0, 5),
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(25))),
            child: Container(
              height: 40,
              width: 40,
              margin: const EdgeInsets.all(6),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: AppColors.primary),
              child: SvgPicture.asset(
                IconEnums.yellowArrow,
                color: AppColors.background,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
