import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  colorScheme: ColorScheme(
    // seedColor: Colors.red.shade800,
    brightness: Brightness.light,
    primaryContainer: Colors.black,
    primary: Colors.grey.shade300,
    onPrimary: Colors.grey.shade900,
    secondary: Colors.grey.shade100,
    onSecondary: Colors.grey.shade600,
    tertiary: Colors.red,
    onTertiary: Colors.white,
    surface: Colors.white,
    onSurface: Colors.grey.shade900,
    error: Colors.red,
    onError: Colors.white,
    surfaceContainerLow: const Color.fromARGB(255, 51, 142, 199),
    surfaceContainer: const Color.fromRGBO(76, 181, 246, 1),
    surfaceContainerHighest: Colors.red.shade600,
    onSurfaceVariant: Colors.white,

    // primary: Color.fromRGBO(217, 217, 217, 1),
    // onPrimary: Color.fromRGBO(13, 13, 13, 1),
    // secondary: Color.fromRGBO(255, 0, 0, 1),
    // onSecondary: Color.fromRGBO(13, 13, 13, 1),
    // surface: Color.fromRGBO(240, 240, 240, 1),
    // onSurface: Color.fromRGBO(13, 13, 13, 1),
    // error: Colors.red,
    // onError: Colors.white,
  ),
);
