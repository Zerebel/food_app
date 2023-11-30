import 'package:flutter/material.dart';
import 'package:food_app/presentation/home.dart';
import 'package:food_app/theme/theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppTheme().lightTheme,
      darkTheme: AppTheme().darkTheme,
      home: const HomeScreen(),
    );
  }
}
