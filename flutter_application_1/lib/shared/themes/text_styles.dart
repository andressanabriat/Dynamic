import 'package:flutter/material.dart';

class TextStyles {
  static const TextTheme textTheme = TextTheme(
    displayLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold), // Equivalente a headline1
    headlineLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600), // Equivalente a headline2
    bodyLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal), // Equivalente a bodyText1
    bodyMedium: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal), // Equivalente a bodyText2
    labelSmall: TextStyle(fontSize: 12.0, color: Colors.grey), // Equivalente a overline
  );
}
