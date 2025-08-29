import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:pstb/utils/colors.dart';
import 'package:pstb/utils/styles.dart';

class GreetingWidget extends StatefulWidget {
  @override
  State<GreetingWidget> createState() => _GreetingWidget();
}

class _GreetingWidget extends State<GreetingWidget> {
  String greeting = '';

  @override
  void initState() {
    super.initState();
    updateGreeting();
  }

  void updateGreeting() {
    var currentTime = DateTime.now();
    if (currentTime.hour >= 1 && currentTime.hour <= 10) {
      setState(() {
        greeting = 'Chào buổi sáng , hôm nay bạn có khỏe không';
      });
    } else if (currentTime.hour >= 11 && currentTime.hour <= 12) {
      setState(() {
        greeting = 'Chào buổi trưa , hôm nay bạn có khỏe không';
      });
    } else if (currentTime.hour >= 13 && currentTime.hour <= 17) {
      setState(() {
        greeting = 'Chào buổi chiều , hôm nay bạn có khỏe không';
      });
    } else {
      setState(() {
        greeting = ''
            'Chào buổi tối , hôm nay bạn có khỏe không';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      child: AnimatedTextKit(
        totalRepeatCount: 1,
        animatedTexts: [
          TyperAnimatedText(
            greeting,
            textStyle: Styles.titleItem.copyWith(
              fontSize: 15,
              color: AppColors.background,
            ),
            speed: const Duration(milliseconds: 40),
          ),
        ],
      ),
    );
  }
}
