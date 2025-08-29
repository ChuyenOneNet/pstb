import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pstb/utils/icons.dart';
import 'package:pstb/utils/images.dart';
import 'package:pstb/utils/styles.dart';

class CircleStepCountWidget extends StatelessWidget {
  const CircleStepCountWidget({Key? key, required this.step}) : super(key: key);
  final String step;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 30),
            padding: const EdgeInsets.symmetric(vertical: 15),
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.width * 0.5,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(
                color: Colors.grey,
                width: 8.0,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  IconEnums.iconStep,
                  color: Colors.blue,
                  width: 32.0,
                  height: 32.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    step,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    "Mục tiêu",
                    style: Styles.titleItem,
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Text(
                  "0",
                  style: Styles.titleItem,
                ),
              ],
            ),
          ),
        ),
        AspectRatio(aspectRatio: 1.1, child: Image.asset(ImageEnum.stepsfoot)),
      ],
    );
  }
}
