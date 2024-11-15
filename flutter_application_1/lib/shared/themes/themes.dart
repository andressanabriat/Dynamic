import 'package:flutter/material.dart';
import 'colors.dart';
import 'text_styles.dart';

final ThemeData appTheme = ThemeData(
  useMaterial3: true, // Activa Material Design 3
  primaryColor: AppColors.primary,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    //secondary: AppColors.accent,
  ),
  textTheme: TextStyles.textTheme, // Asegúrate de que esto sea correcto
  // Otros ajustes de tema
);
