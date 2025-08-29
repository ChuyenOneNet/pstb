import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../utils/colors.dart';
import '../../../utils/helper.dart';
import '../../stateful/touchable_opacity.dart';

class ButtonBackToPrevious extends StatelessWidget {
  const ButtonBackToPrevious({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: 8,
        top: heightConvert(context, MediaQuery.of(context).padding.top + 10),
        child: SizedBox(
          width: 32,
          child: TouchableOpacity(
            onTap: () => Modular.to.pop(),
            child: Container(
              color: AppColors.transparent,
              child: Icon(
                Icons.chevron_left,
                size: 36,
                color: AppColors.primary,
              ),
            ),
          ),
        ));
  }
}
