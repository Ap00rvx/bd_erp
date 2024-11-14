import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppThemes {
  String themeString = "auto";
  Future<String> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return themeString = prefs.getString('xTheme') ?? 'auto';
  }

  Future<void> setTheme(String theme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    themeString = theme; 
    prefs.setString('xTheme', theme);
  }

  Future<ThemeData> getThemeData(BuildContext context) async {
    String theme = await getTheme();
    if (theme == 'auto') {
      var brightness = MediaQuery.of(context).platformBrightness;
      theme = brightness == Brightness.dark ? 'dark' : 'light';
    }
    return theme == 'dark' ? darkTheme : lightTheme;
  }

  static const Color primaryColor = Colors.black;
  static const Color backgroundLightGrey = Color(0xFFF5F5F5);
  static const Color darkerGrey = Color(0xFFE0E0E0);
  static const Color highlightYellow = Color(0xFFFFD366);
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color lightGrey = Color(0xFFC8C8C8);

  static final ThemeData lightTheme = ThemeData(
    fontFamily: 'nun',
    brightness: Brightness.light,
    primaryColor: black,
    scaffoldBackgroundColor: white,
    appBarTheme: const AppBarTheme(
      backgroundColor: white,
      titleTextStyle: TextStyle(color: black),
      iconTheme: IconThemeData(color: black),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: black),
      bodyMedium: TextStyle(color: black),
    ),
    iconTheme: const IconThemeData(color: black),
    cardColor: lightGrey,
    dividerColor: darkerGrey,
    colorScheme: const ColorScheme.light(
      primary: black,
      secondary: highlightYellow,
      background: backgroundLightGrey,
      surface: white,
      onPrimary: white,
      onSecondary: black,
      onBackground: black,
      onSurface: black,
    ).copyWith(background: backgroundLightGrey),
  );

  static final ThemeData darkTheme = ThemeData(
    fontFamily: 'nun',
    brightness: Brightness.dark,
    primaryColor: white,
    scaffoldBackgroundColor: black,
    appBarTheme: const AppBarTheme(
      backgroundColor: black,
      titleTextStyle: TextStyle(color: white),
      iconTheme: IconThemeData(color: white),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: white),
      bodyMedium: TextStyle(color: white),
    ),
    iconTheme: const IconThemeData(color: white),
    cardColor: backgroundLightGrey,
    dividerColor: lightGrey,
    colorScheme: const ColorScheme.dark(
      primary: white,
      secondary: highlightYellow,
      background: darkerGrey,
      surface: black,
      onPrimary: black,
      onSecondary: white,
      onBackground: white,
      onSurface: white,
    ).copyWith(background: darkerGrey),
  );
}
