import 'package:flutter/material.dart';
import 'package:pstb/utils/colors.dart';
import 'package:pstb/utils/styles.dart';

class ThemeDataWidget {
  /// titleMedium = style appbar
  /// headline4 =  style headline trong item
  /// subtitle1 =  style các description
  ThemeData themeDataCustom({
    Color? selectedItemColor,
    Color? primary,
    TextStyle? styleTitleAppBar,
    TextStyle? styleItem,
    TextStyle? styleDescription,
    Color? appbarColor,
    String? fontFamily,
  }) {
    return ThemeData(
      fontFamily: fontFamily ?? "Inter",
      primaryColor: primary ?? AppColors.newbg900,
      primaryColorLight: AppColors.newbg600,
      scaffoldBackgroundColor: primary ?? AppColors.background,
      // Remove bottomAppBarColor and customize it through bottomNavigationBarTheme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: selectedItemColor ?? AppColors.primary,
        unselectedItemColor: AppColors.grayLight,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        unselectedLabelStyle: Styles.subtitleSmall,
        selectedLabelStyle: Styles.subtitleSmall,
        backgroundColor: AppColors
            .background, // This will set the background color of the bottom navigation bar
      ),
      textTheme: TextTheme(
        titleMedium: styleTitleAppBar, // Previously titleMedium
        headlineMedium: styleItem, // Change headline4 to headlineMedium
        bodyMedium: styleDescription,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: appbarColor ?? AppColors.primary,
        titleTextStyle: styleTitleAppBar,
      ),
    );
  }
}
