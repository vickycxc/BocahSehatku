import 'package:app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final theme = ThemeData(
    fontFamily: 'Poppins',
    primaryColor: Pallete.accentColor,
    scaffoldBackgroundColor: Pallete.backgroundPrimaryColor,
    textTheme: TextTheme(
      titleLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      titleMedium: TextStyle(fontSize: 16),
    ),
  );
}
