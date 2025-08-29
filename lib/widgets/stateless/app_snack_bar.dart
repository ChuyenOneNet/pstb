import 'package:flutter/material.dart';
import 'package:pstb/utils/colors.dart';
import 'package:pstb/utils/helper.dart';
import 'package:pstb/utils/styles.dart';

enum AppSnackBarType { Info, Warning, Error, Success }

class AppSnackBar {
  static Widget createIcon(AppSnackBarType? type) {
    final Icon icon;
    switch (type) {
      case AppSnackBarType.Warning:
        icon = const Icon(
          Icons.warning_amber_rounded,
          color: AppColors.warning900,
        );
        break;
      case AppSnackBarType.Info:
        icon = Icon(
          Icons.info_outline_rounded,
          color: AppColors.primary,
        );
        break;
      case AppSnackBarType.Success:
        icon = const Icon(
          Icons.check,
          color: AppColors.success800,
        );
        break;
      default:
        icon = const Icon(
          Icons.cancel_outlined,
          color: AppColors.error500,
        );
        break;
    }
    return icon;
  }

  static Color createColor(AppSnackBarType? type) {
    Color color = AppColors.error700;
    switch (type) {
      case AppSnackBarType.Warning:
        color = AppColors.warning900;
        break;
      case AppSnackBarType.Info:
        color = AppColors.infor900;
        break;
      case AppSnackBarType.Success:
        color = AppColors.success800;
        break;
      default:
        color = AppColors.error700;
        break;
    }
    return color;
  }

  static Color createColorbg(AppSnackBarType? type) {
    final Color color;
    switch (type) {
      case AppSnackBarType.Warning:
        color = AppColors.warning100;
        break;
      case AppSnackBarType.Info:
        color = AppColors.infor50;
        break;
      case AppSnackBarType.Success:
        color = AppColors.success50;
        break;
      default:
        color = AppColors.error50;
        break;
    }
    return color;
  }

  static void show(
    BuildContext context,
    AppSnackBarType? type,
    String? msg,
  ) {
    FocusScope.of(context).unfocus();
    try {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          elevation: 0,
          backgroundColor: AppColors.transparent,
          duration: const Duration(milliseconds: 3000),
          width: widthConvert(context, 375),
          behavior: SnackBarBehavior.floating,
          content: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 13.0,
                  right: widthConvert(context, 16),
                  left: widthConvert(context, 16),
                ),
                decoration: Styles.cardShadow.copyWith(
                  color: createColorbg(type),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: heightConvert(context, 17),
                        horizontal: widthConvert(context, 12),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          createIcon(type),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: widthConvert(context, 12),
                              ),
                              child: Wrap(
                                children: [
                                  Text(
                                    msg!,
                                    style: Styles.content
                                        .copyWith(color: createColor(type)),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } catch (e) {
      print(e);
    }
  }
}
