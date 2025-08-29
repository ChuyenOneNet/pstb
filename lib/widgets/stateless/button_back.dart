import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/utils/colors.dart';

class ButtonBackWidget extends StatelessWidget {
  const ButtonBackWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: InkWell(
            onTap: () {
              print('1');
              Modular.to.pop();
            },
            child: Container(
                color: AppColors.primary.withOpacity(0.8),
                child: const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(
                    Icons.chevron_left,
                    size: 36,
                    color: AppColors.background,
                  ),
                )),
          )),
    );
  }
}
