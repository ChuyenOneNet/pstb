import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/on_board/on_board_store.dart';
import 'package:pstb/utils/colors.dart';

const String nextBtn = "assets/icons/button_next_slider.svg";

class IndicatorController extends StatelessWidget {
  final OnBoardStore controller = Modular.get<OnBoardStore>();

  IndicatorController({Key? key, required this.controllerSlider})
      : super(key: key);

  final CarouselSliderController controllerSlider;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 50, width: 50),
        Observer(
          builder: (context) {
            return Wrap(
              children: List.generate(
                controller.tutorials.length,
                (index) => Container(
                  width: index == controller.slideNo ? 12.0 : 8.0,
                  height: index == controller.slideNo ? 12.0 : 8.0,
                  margin: EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: index == controller.slideNo ? 0 : 2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index == controller.slideNo
                        ? AppColors.primary
                        : AppColors.primary.withOpacity(0.5),
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 50, width: 50)
      ],
    );
  }
}
