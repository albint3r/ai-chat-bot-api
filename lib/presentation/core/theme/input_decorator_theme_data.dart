import 'package:flutter/material.dart';

abstract class CustomInputDecoratorThemeData {
  static InputDecorationTheme? themeData(ColorScheme colorScheme) {
    return InputDecorationTheme(
      // Personaliza el borde del TextField de manera global
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        borderSide: BorderSide(
          color: Colors.white, // Establece el color del borde a blanco
          width: .25,
        ),
      ),
      // Personaliza el relleno del TextField de manera global
      fillColor: colorScheme.background,
      filled: true,
      // Otros ajustes de decoración global según sea necesario
    );
  }
}
