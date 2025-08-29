import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/on_board/on_board_store.dart';
import 'package:pstb/app/modules/on_board/widgets/indicator_dot.dart';
import 'package:pstb/app/modules/on_board/widgets/slider_item.dart';
import 'package:pstb/widgets/stateless/app_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/constants.dart';
import '../../../utils/routes.dart';
import '../../../utils/styles.dart';

class OnBoardPage extends StatefulWidget {
  const OnBoardPage({
    Key? key,
  }) : super(key: key);

  @override
  _OnBoardPageState createState() => _OnBoardPageState();
}

class _OnBoardPageState extends ModularState<OnBoardPage, OnBoardStore> {
  final CarouselSliderController _controllerSlider = CarouselSliderController();

  @override
  void initState() {
    controller.getTutorial();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(bottom: 32.0),
          child: Column(
            children: [
              Observer(
                builder: (context) {
                  return Expanded(
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: size.height,
                        viewportFraction: 1.0,
                        enlargeCenterPage: false,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                        enableInfiniteScroll: false,
                        onPageChanged: (index, reason) {
                          controller.changeSlide(index);
                        },
                      ),
                      carouselController: _controllerSlider,
                      items: List.generate(
                        controller.tutorials.length,
                        (index) => SliderItem(
                          slider: controller.tutorials[index],
                        ),
                      ),
                    ),
                  );
                },
              ),
              IndicatorController(controllerSlider: _controllerSlider),
              Row(
                children: [
                  const Spacer(),
                  Expanded(
                    child: Observer(builder: (context) {
                      return AppButton(
                        title: controller.slideNo ==
                                controller.tutorialList.length - 1
                            ? 'Bắt đầu'
                            : 'Tiếp tục',
                        onPressed: () {
                          _controllerSlider.nextPage();
                          controller.slideNo++;
                          if (controller.slideNo ==
                              controller.tutorialList.length) {
                            controller.onNextPress(_controllerSlider);
                          }
                        },
                      );
                    }),
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Observer(builder: (context) {
                return controller.slideNo == controller.tutorialList.length - 1
                    ? const SizedBox()
                    : Row(
                        children: [
                          const Spacer(),
                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                final SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.setInt(
                                    Constants.firstTimeLoadApp, 1);
                                // Modular.to.popAndPushNamed(AppRoutes.main);
                                Modular.to.popAndPushNamed(
                                    AppRoutes.selectionHospitalModule);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: Constants.buttonHeight,
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                  'Bỏ qua',
                                  style: Styles.content,
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                        ],
                      );
              }),
            ],
          ),
        ),
      ),
      onWillPop: () async => false,
    );
  }
}
