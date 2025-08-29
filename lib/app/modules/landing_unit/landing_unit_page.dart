import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pstb/utils/hex_color.dart';
import 'package:pstb/utils/main.dart';

import '../../../utils/canvas.dart';
import '../../../utils/colors.dart';
import '../../../utils/helper.dart';
import '../../../utils/images.dart';
import '../../../utils/l10n.dart';
import '../../../utils/styles.dart';
import '../../app_store.dart';

class LandingUnitPage extends StatefulWidget {
  LandingUnitPage({Key? key}) : super(key: key);

  @override
  State<LandingUnitPage> createState() => _LandingUnitPageState();
}

class _LandingUnitPageState extends State<LandingUnitPage> {
  final AppStore _appStore = Modular.get<AppStore>();

  @override
  void initState() {
    // TODO: implement initStat
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var model = _appStore.landingUnitModel;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: SvgPicture.asset(
              CanvasEnum.canvasBottom,
              width: MediaQuery.of(context).size.width,
              color: AppColors.primary,
              fit: BoxFit.fitWidth,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: SizedBox(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    child: AnimatedTextKit(
                      totalRepeatCount: 1,
                      animatedTexts: [
                        TyperAnimatedText(
                          //'Chào mừng bạn đến \n${model.name!}',
                          'Chào mừng bạn đến \nBệnh viện Phụ Sản Thái Bình',
                          textStyle: Styles.content.copyWith(
                            fontSize: 25,
                            color: AppColors.primary,
                          ),
                          speed: const Duration(milliseconds: 20),
                        ),
                      ],
                      onTap: () {},
                      onFinished: () {
                        Modular.to.popAndPushNamed(AppRoutes.main);
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(32.0),
                        child: AspectRatio(
                          aspectRatio: 2,
                          child: Image.asset(
                            "assets/images/ic_launcher_2.png",
                            fit: BoxFit.fitHeight,
                            // width: 500,
                          ),
                          // Image.network(
                          //   model.image!,
                          //   fit: BoxFit.fitHeight,
                          //   // width: 500,
                          // ),
                        ),
                      ),
                      // const SizedBox(
                      //   height: 16,
                      // ),
                      Text(
                        model.slogan!,
                        style: Styles.titleItem
                            .copyWith(color: AppColors.primary, fontSize: 22),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: heightConvert(context, 46),
                      ),
                      child: Text(
                        l10n(context).landing_company,
                        style: Styles.content.copyWith(
                          color: AppColors.background,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
