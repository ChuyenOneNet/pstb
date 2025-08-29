import 'package:flutter/material.dart';
import '../../utils/colors.dart';

class AppThemes extends InheritedWidget {
  final AppColors appColors;

  const AppThemes({
    Key? key,
    required this.appColors,
    required Widget child,
  }) : super(child: child);

  static AppThemes of(BuildContext context) {
    final inheritedTheme =
        context.dependOnInheritedWidgetOfExactType<AppThemes>();
    if (inheritedTheme == null) {
      throw Exception("Theme not found in context");
    }
    return inheritedTheme;
  }

  @override
  bool updateShouldNotify(AppThemes oldWidget) {
    return appColors != oldWidget.appColors; // Rebuild only if color changes
  }
}
