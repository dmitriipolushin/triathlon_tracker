// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final styleProvider = ChangeNotifierProvider<Style>((ref) {
  return Style();
});

class Style extends ChangeNotifier {
  ThemeColor _themeColor;
  Style({
    ThemeColor? themeColor,
  }) : _themeColor = themeColor ?? ThemeColor.light;

  set themeColor(ThemeColor themeColor) {
    bool hasChanged = themeColor != _themeColor;

    _themeColor = themeColor;

    if (hasChanged) notifyListeners();
  }

  ThemeColor get themeColor => _themeColor;

  ColorsBundle get colors => mapThemeToColors(_themeColor);

  ColorsBundle mapThemeToColors(ThemeColor themeColor) => LightThemeColors();
  // themeColor == ThemeColor.light ? LightThemeColors() : DarkThemeColors();
}

enum ThemeColor { light, dark }

abstract class ColorsBundle {
  ColorsBundle();

  Color get backPrimary;
  Color get backSecondary;
  Color get backTertiary;

  Color get accentPrimary;
  Color get unselected;

  Color get textPrimary;
  Color get textSecondary;
  Color get textTertiary;
}

class LightThemeColors extends ColorsBundle {
  LightThemeColors();

  @override
  Color get accentPrimary => const Color(0xFF4A4999);

  @override
  Color get backPrimary => const Color(0xFFE0F0FF);

  @override
  Color get backSecondary => const Color(0xFFFFFFFF);

  @override
  Color get backTertiary => const Color(0xFFF2F3F4);

  @override
  Color get textPrimary => const Color(0xFF40445C);

  @override
  Color get textSecondary => const Color(0xFF000000);

  @override
  Color get textTertiary => const Color(0xFF9EA1B2);

  @override
  Color get unselected => const Color(0xFFD6D7E4);
}

// class DarkThemeColors extends ColorsBundle {
//   @override
//   Color get backPrimary => const Color(0xff161618);
// }

class TextStyles {}
