import 'package:flutter/material.dart';

abstract class CustomInputDecoratorThemeData {
  static InputDecorationTheme? themeData(ColorScheme colorScheme) =>
      const InputDecorationTheme(
        // Personaliza el borde del TextField de manera global
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        // Personaliza el relleno del TextField de manera global
        fillColor: Colors.white,
        filled: true,
        // Otros ajustes de decoración global según sea necesario
      );
}
