import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateful/stateful_widget.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final TextStyle? textStyle;
  final Icon? icon;
  final Color? backgroundColor;
  final Widget? actionIcon;
  final Function()? actionFunc;
  final bool? isBack;
  final Function()? onBack;
  final Widget? flexibleSpaceImage;
  final Widget? leading;
  final double? titleSpacing;
  @override
  final Size preferredSize;

  CustomAppBar({
    Key? key,
    this.title = "",
    this.icon,
    this.textStyle,
    this.backgroundColor,
    this.actionIcon,
    this.actionFunc,
    this.flexibleSpaceImage,
    this.onBack,
    this.isBack = true,
    //leading active when [is back = false]
    this.leading, this.titleSpacing,
  })  : preferredSize = const Size.fromHeight(50.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title ?? '',
          style: Styles.titleAppbar.copyWith(color: AppColors.primary)),
      titleSpacing: titleSpacing ?? 0,
      backgroundColor: backgroundColor ?? AppColors.background,
      elevation: 0,
      flexibleSpace: flexibleSpaceImage,
      centerTitle: false,
      leading: isBack ?? false
          ? TouchableOpacity(
              onTap: () {
                if (onBack != null) {
                  onBack!();
                } else {
                  Modular.to.pop();
                }
              },
              child: const Icon(
                Icons.chevron_left,
                size: 36,
                color: AppColors.primary,
              ),
            )
          : leading ?? const SizedBox(),
      actions: actionFunc != null
          ? <Widget>[
              actionIcon != null
                  ? IconButton(icon: actionIcon!, onPressed: actionFunc)
                  : Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(8.0),
                      child: TouchableOpacity(
                          child: Text(
                            l10n(context)!.app_bar_save,
                            style: Styles.heading5.copyWith(
                                foreground: Styles.defaultGradientPaint),
                          ),
                          onTap: () {
                            if (actionFunc == null) return;
                            actionFunc!();
                          }),
                    ),
            ]
          : null,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: AppColors.primary,
          height: 1.0,
        ),
      ),
    );
  }
}
