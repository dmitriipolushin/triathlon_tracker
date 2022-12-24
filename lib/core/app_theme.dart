import 'package:flutter/material.dart';
import 'package:triathlon_tracker/core/style.dart';

class AppTheme {
  static const _defaultFontFamily = 'Roboto';

  static ThemeData theme(ThemeColor themeColor, ColorsBundle colors) {
    final brightness =
        themeColor == ThemeColor.light ? Brightness.dark : Brightness.light;
    final theme = ThemeData(
      brightness: brightness,
      fontFamily: _defaultFontFamily,
      backgroundColor: colors.backPrimary,
      scaffoldBackgroundColor: colors.backPrimary,
      appBarTheme: AppBarTheme(backgroundColor: colors.backPrimary),
    );
    return theme;
  }
}
