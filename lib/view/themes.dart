import 'package:flutter/material.dart';

const primaryColor = Color(0xFF3883FB);
const backgroundLightColor = Color(0xFFCFCFC);
const backgroundDarkColor = Color(0xFF1F2026);
const navigationBarLightColor = Colors.white;
const navigationBarDarkColor = Color(0xFF30313C);
class Themes{
  static final themeLight = ThemeData.light().copyWith(
      scaffoldBackgroundColor: backgroundLightColor,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: navigationBarLightColor,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.red
      ),
      canvasColor: backgroundLightColor
  );


}