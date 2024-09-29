import 'package:flutter/material.dart';

Color primaryContainer = Colors.black;
Color primary = Colors.grey.shade300;
Color onPrimary = Colors.grey.shade900;
Color secondary = Colors.grey.shade100;
Color onSecondary = Colors.grey.shade600;
const Color tertiary = Colors.red;
const Color onTertiary = Colors.white;
const Color surface = Colors.white;
Color onSurface = Colors.grey.shade900;
const Color error = Colors.red;
const Color onError = Colors.white;
Color surfaceContainerLow = const Color.fromARGB(255, 51, 142, 199);
Color surfaceContainer = const Color.fromRGBO(76, 181, 246, 1);
Color surfaceContainerHigh = Colors.amber.shade400;
Color surfaceContainerHighest = Colors.red.shade600;
const Color onSurfaceVariant = Colors.white;

// FOR CHOICE PROMPT THEME
MaterialColor primarySwatch = Colors.red;

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  colorScheme: ColorScheme(
    // seedColor: Colors.red.shade800,
    brightness: Brightness.light,
    primaryContainer: primaryContainer,
    primary: primary,
    onPrimary: onPrimary,
    secondary: secondary,
    onSecondary: onSecondary,
    tertiary: tertiary,
    onTertiary: onTertiary,
    surface: surface,
    onSurface: onSurface,
    error: error,
    onError: onError,
    surfaceContainerLow: surfaceContainerLow,
    surfaceContainer: surfaceContainer,
    surfaceContainerHigh: surfaceContainerHigh,
    surfaceContainerHighest: surfaceContainerHighest,
    onSurfaceVariant: onSurfaceVariant,
  ),
  appBarTheme: AppBarTheme(
    surfaceTintColor: onSecondary, // SAME AS onSecontary
    backgroundColor: Colors.transparent,
    scrolledUnderElevation: 20,
  ),
  timePickerTheme: TimePickerThemeData(
    confirmButtonStyle: ButtonStyle(
      foregroundColor: WidgetStatePropertyAll(onSurface),
    ),
    cancelButtonStyle: ButtonStyle(
      foregroundColor: WidgetStatePropertyAll(onSurface),
    ),
    backgroundColor: surface,
    hourMinuteColor: secondary,
    hourMinuteTextColor: onPrimary,
    dayPeriodTextColor: WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return onSurfaceVariant;
      }

      return onSurface;
    }),
    dayPeriodTextStyle: const TextStyle(fontWeight: FontWeight.w500),
    dialBackgroundColor: secondary,
    dialHandColor: primary,
    dialTextColor: onPrimary,
    dialTextStyle: TextStyle(color: onPrimary, fontWeight: FontWeight.bold),
  ),
);
