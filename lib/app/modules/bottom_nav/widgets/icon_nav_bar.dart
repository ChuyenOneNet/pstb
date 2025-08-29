import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconNavBar extends StatelessWidget {
  const IconNavBar({
    Key? key,
    required this.assets, this.color,
  }) : super(key: key);
  final String assets;
  final Color? color;
  // final int index, activeIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SvgPicture.asset(
        assets,
        color: color,
      ),
    );
  }
}