import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'color_scheme_theme_data.dart';
import 'elevated_button_theme_data.dart';
import 'input_decorator_theme_data.dart';
import 'text_theme_data.dart';

@singleton
class ThemeConfig {
  ThemeData get light => _getThemeData(colorScheme: ColorTheme.light);

  ThemeData get dark => _getThemeData(colorScheme: ColorTheme.dark);

  ThemeData _getThemeData({
    required ColorScheme colorScheme,
  }) {
    return ThemeData(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.background,
      brightness: colorScheme.brightness,
      visualDensity: VisualDensity.standard,
      elevatedButtonTheme: CustomElevatedButtonThemeData.themeData(
        colorScheme,
      ),
      textTheme: TextThemeData.themeData(
        colorScheme,
      ),
      inputDecorationTheme: CustomInputDecoratorThemeData.themeData(
        colorScheme,
      ),
    );
  }
}
