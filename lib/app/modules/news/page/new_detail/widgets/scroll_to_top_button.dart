import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateful/stateful_widget.dart';

class ScrollToTopButton extends StatelessWidget {
  final Function onTab;
  final bool scrollIsReached;

  const ScrollToTopButton({
    Key? key,
    required this.onTab,
    required this.scrollIsReached,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        if (!scrollIsReached) {
          return const SizedBox();
        }
        return TouchableOpacity(
          child: Container(
            decoration: Styles.shadowBase.copyWith(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: AppColors.grayLight,
                width: 1,
              ),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: widthConvert(context, 18),
              vertical: widthConvert(context, 8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.arrow_upward,
                  size: 18,
                  color: AppColors.neutral700,
                ),
                SizedBox(width: widthConvert(context, 8)),
                Text(
                  l10n(context)!.new_scrollTop!.toUpperCase(),
                  style: Styles.buttonLargeUppercase.copyWith(
                    color: AppColors.neutral700,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
          onTap: onTab,
        );
      },
    );
  }
}
