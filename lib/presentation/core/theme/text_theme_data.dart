import 'package:flutter/material.dart';

import 'const_values.dart';

abstract class TextThemeData {
  static TextTheme themeData(ColorScheme colorScheme) {
    return TextTheme(
      titleLarge: TextStyle(
        fontSize: h1,
        fontWeight: FontWeight.bold,
        color: colorScheme.onPrimary,
      ),
      titleMedium: TextStyle(
        fontSize: h2,
        fontWeight: FontWeight.bold,
        color: colorScheme.onBackground,
      ),
      titleSmall: TextStyle(
        fontSize: h3,
        fontWeight: FontWeight.bold,
        color: colorScheme.onBackground,
      ),
      bodyMedium: TextStyle(
        fontSize: bodyMedium,
        color: colorScheme.onPrimary,
      ),
    );
  }
}
