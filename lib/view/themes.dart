import 'package:flutter/material.dart';

const primaryColor = Color(0xFF3883FB);
const focusLight = Color.fromRGBO(2, 51, 83, 1.0);
const focusDark = Colors.grey;
const backgroundLightColor = Colors.white;
const backgroundDarkColor = Color(0xFF1F2026);
const navigationBarLightColor = Colors.white;
const navigationBarDarkColor = Color(0xFF30313C);

class Themes {
  static final themeLight = ThemeData.light().copyWith(
    primaryColor: primaryColor,
    focusColor: focusLight,
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: focusLight),
    ),
    scaffoldBackgroundColor: backgroundLightColor,
  );

  static final themeDark = ThemeData.dark().copyWith(
    primaryColor: primaryColor,
    focusColor: focusDark,
    scaffoldBackgroundColor: backgroundDarkColor,
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: focusDark),
    ),
  );
}
