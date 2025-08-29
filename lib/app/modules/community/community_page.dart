import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pstb/app/modules/auth_guard/auth_guard_page.dart';
import 'package:pstb/app/modules/community/community_page_store.dart';
import 'package:pstb/app/modules/community/widgets/box_icon_widget.dart';
import 'package:pstb/utils/main.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({Key? key}) : super(key: key);

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  final _controller = Modular.get<CommunityPageStore>();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      if (!_controller.isLogin) {
        return AuthGuardPage();
      }
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BoxIconWidget(
                        title: Constants.questionHYH,
                        svgPicture: CanvasEnum.personal,
                        onTap: () async {
                          await _controller.getListQuestion();
                          Modular.to.pushNamed(AppRoutes.myQuestion);
                        },
                      ),
                      BoxIconWidget(
                        title: Constants.informationPublic,
                        svgPicture: CanvasEnum.community,
                        onTap: () {
                          Modular.to.pushNamed(AppRoutes.diseases);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: SvgPicture.asset(IconEnums.iconCommunity),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
