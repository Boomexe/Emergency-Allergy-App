import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color.fromRGBO(217, 217, 217, 1),
    onPrimary: Color.fromRGBO(13, 13, 13, 1),
    secondary: Color.fromRGBO(255, 0, 0, 1),
    onSecondary: Color.fromRGBO(13, 13, 13, 1),
    surface: Color.fromRGBO(240, 240, 240, 1),
    onSurface: Color.fromRGBO(13, 13, 13, 1),
    error: Colors.red,
    onError: Colors.white,
  ),
);
