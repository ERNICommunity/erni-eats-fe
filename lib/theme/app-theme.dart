import 'package:flutter/material.dart';

class AppThemeColors {
  static const White = Color.fromRGBO(241, 240, 241, 1.0);
  static const Gray = Color.fromRGBO(101, 100, 101, 1.0);
  static const Black = Color.fromRGBO(26, 25, 26, 1.0);
  static const Red = Color.fromRGBO(250, 25, 26, 1.0);
}

Map<String, ThemeData> appThemesMap = {
  'light': AppTheme.lightTheme,
  'dark': AppTheme.darkTheme,
  'erni': AppTheme.erniTheme,
};
// final appThemes = {AppTheme.lightTheme, AppTheme.darkTheme, AppTheme.erniTheme};

class AppTheme with ChangeNotifier {
  ThemeData currentTheme = AppTheme.lightTheme;

  void toggleTheme(ThemeData themeData) {
    currentTheme = themeData;
    notifyListeners();
  }

  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme(
        primary: AppThemeColors.Black,
        primaryVariant: ColorScheme.light().primaryVariant,
        secondary: ColorScheme.light().secondary,
        secondaryVariant: ColorScheme.light().secondaryVariant,
        surface: ColorScheme.light().surface,
        background: ColorScheme.light().background,
        error: ColorScheme.light().error,
        onPrimary: ColorScheme.light().onPrimary,
        onSecondary: ColorScheme.light().onSecondary,
        onSurface: ColorScheme.light().onSurface,
        onBackground: ColorScheme.light().onBackground,
        onError: ColorScheme.light().onError,
        brightness: ColorScheme.light().brightness,
      ),
      scaffoldBackgroundColor: Colors.white70,
      appBarTheme: AppBarTheme(
        color: Colors.white,
        foregroundColor: Colors.black,
      ),
      cardTheme: CardTheme(
        // color: AppThemeColors.Black,
        // shadowColor: AppThemeColors.Black,
        margin: EdgeInsets.symmetric(horizontal: 52, vertical: 8),
      ),
      listTileTheme: ListTileThemeData(
        textColor: AppThemeColors.Black,
        iconColor: AppThemeColors.Gray,
      ),
      checkboxTheme: CheckboxThemeData(
        checkColor: MaterialStateProperty.all(AppThemeColors.White),
        fillColor: MaterialStateProperty.all(AppThemeColors.Gray),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      colorScheme: ColorScheme(
        primary: AppThemeColors.White,
        primaryVariant: ColorScheme.dark().primaryVariant,
        secondary: ColorScheme.dark().secondary,
        secondaryVariant: ColorScheme.dark().secondaryVariant,
        surface: ColorScheme.dark().surface,
        background: ColorScheme.dark().background,
        error: ColorScheme.dark().error,
        onPrimary: ColorScheme.dark().onPrimary,
        onSecondary: ColorScheme.dark().onSecondary,
        onSurface: ColorScheme.dark().onSurface,
        onBackground: ColorScheme.dark().onBackground,
        onError: ColorScheme.dark().onError,
        brightness: ColorScheme.dark().brightness,
      ),
      scaffoldBackgroundColor: Colors.black87,
      appBarTheme: AppBarTheme(
        color: Color.fromRGBO(16, 15, 16, 1),
        foregroundColor: AppThemeColors.White,
      ),
      cardTheme: CardTheme(
        color: AppThemeColors.Black,
        shadowColor: AppThemeColors.Black,
        margin: EdgeInsets.symmetric(horizontal: 52, vertical: 8),
      ),
      listTileTheme: ListTileThemeData(
        textColor: AppThemeColors.White,
        tileColor: AppThemeColors.Black,
        iconColor: AppThemeColors.White,
      ),
      drawerTheme: DrawerThemeData(backgroundColor: AppThemeColors.Black),
      checkboxTheme: CheckboxThemeData(
        checkColor: MaterialStateProperty.all(AppThemeColors.Black),
        fillColor: MaterialStateProperty.all(AppThemeColors.White),
      ),
      iconTheme: IconThemeData(color: AppThemeColors.White),
    );
  }

  static ThemeData get erniTheme {
    // 0x 073779 - dark blue // 0x 00aadb - light blue // 0x 626362 - gray // 0x ddeaee - light green blue
    return ThemeData(
      colorScheme: ColorScheme(
        primary: AppThemeColors.Black,
        primaryVariant: ColorScheme.light().primaryVariant,
        secondary: ColorScheme.light().secondary,
        secondaryVariant: ColorScheme.light().secondaryVariant,
        surface: ColorScheme.light().surface,
        background: ColorScheme.light().background,
        error: ColorScheme.light().error,
        onPrimary: ColorScheme.light().onPrimary,
        onSecondary: ColorScheme.light().onSecondary,
        onSurface: ColorScheme.light().onSurface,
        onBackground: ColorScheme.light().onBackground,
        onError: ColorScheme.light().onError,
        brightness: ColorScheme.light().brightness,
      ),
      scaffoldBackgroundColor: Color.fromRGBO(221, 234, 238, 0.8),
      appBarTheme: AppBarTheme(
        color: Color.fromRGBO(7, 55, 121, 1.0),
        foregroundColor: Colors.white,
      ),
      cardTheme: CardTheme(
        color: Color.fromRGBO(250, 250, 250, 1.0),
        shadowColor: AppThemeColors.Black,
        margin: EdgeInsets.symmetric(horizontal: 52, vertical: 8),
      ),
      listTileTheme: ListTileThemeData(
        textColor: AppThemeColors.Black,
        iconColor: AppThemeColors.Gray,
      ),
      checkboxTheme: CheckboxThemeData(
        checkColor: MaterialStateProperty.all(AppThemeColors.White),
        fillColor: MaterialStateProperty.all(AppThemeColors.Gray),
      ),
    );
  }
}
