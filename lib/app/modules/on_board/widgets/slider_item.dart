import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/on_board/on_board_store.dart';
import 'package:pstb/utils/colors.dart';
import 'package:pstb/utils/helper.dart';
import 'package:pstb/utils/styles.dart';
import 'package:pstb/widgets/stateless/image_network.dart';

final String vectorOnBoard = "assets/canvas/vector_on_board.svg";

class SliderItem extends StatelessWidget {
  final OnBoardStore _onBoardStore = Modular.get<OnBoardStore>();

  SliderItem({
    Key? key,
    required this.slider,
  }) : super(key: key);

  final String slider;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int index = _onBoardStore.tutorials.indexOf(slider);
    return Column(
      children: <Widget>[
        SizedBox(
          height: size.height * 15/35,
          width: size.width,
          child: AppImageNetwork(
            imageUri: slider,
            borderRadius: 0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                _onBoardStore.tutorialList[index].title!,
                // textAlign: TextAlign.center,
                style: Styles.titleItem.copyWith(
                  color: AppColors.primary
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  _onBoardStore.tutorialList[index].description!,
                  style: Styles.content,
                  maxLines: 8,
                  overflow: TextOverflow.ellipsis,
                  // textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
