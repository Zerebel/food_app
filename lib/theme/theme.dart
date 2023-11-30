import 'package:flutter/material.dart';

class AppTheme {
  ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        textTheme: Typography.blackCupertino,
      );

  ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.black,
        textTheme: Typography.whiteCupertino,
      );
}
