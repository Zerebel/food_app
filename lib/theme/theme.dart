import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    appBarTheme: const AppBarTheme(
      color: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    brightness: Brightness.light,
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        color: Colors.grey,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        color: Colors.grey,
      ),
      labelSmall: TextStyle(
        fontSize: 10,
        color: Colors.grey,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: Colors.black45,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        splashFactory: NoSplash.splashFactory,
      ),
    ),
  );
}
