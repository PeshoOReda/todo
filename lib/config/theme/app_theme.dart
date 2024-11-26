import 'package:flutter/material.dart';

import '../../core/utils/app_styles.dart';
import '../../core/utils/colors_manager.dart';

class AppTheme {
  static ThemeData light = ThemeData(
      colorScheme: ColorScheme.fromSeed(
          seedColor: ColorsManager.blue,
          primary: ColorsManager.blue,
          onPrimary: ColorsManager.white),
      useMaterial3: false,
      appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: ColorsManager.blue,
          titleTextStyle: LightAppStyle.appBar),
      scaffoldBackgroundColor: ColorsManager.greenAccent,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: ColorsManager.blue,
        unselectedItemColor: ColorsManager.grey,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedIconTheme: IconThemeData(size: 33),
        unselectedIconTheme: IconThemeData(size: 33),
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
        shape: CircularNotchedRectangle(),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        shape: StadiumBorder(
            side: BorderSide(color: ColorsManager.white, width: 4)),
        backgroundColor: ColorsManager.blue,
        iconSize: 26,
        foregroundColor: ColorsManager.white,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: ColorsManager.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        )),
      ));
  static ThemeData dark = ThemeData();
}
