import 'package:flutter/material.dart';

class SingleChoicePromptTheme extends StatelessWidget {
  final Widget child;
  const SingleChoicePromptTheme({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = Theme.of(context).colorScheme;

    return Theme(
        data: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.red,
            cardColor: scheme.surface,
          ),
        ),
        child: child);
  }
}

class MultiChoicePromptTheme extends StatelessWidget {
  final Widget child;
  const MultiChoicePromptTheme({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = Theme.of(context).colorScheme;

    return Theme(
        data: ThemeData(
          colorScheme: ColorScheme(
              brightness: scheme.brightness,
              primary: scheme.primary,
              onPrimary: scheme.onPrimary,
              secondary: scheme.secondary,
              onSecondary: scheme.onSecondary,
              error: scheme.error,
              onError: scheme.onError,
              surface: scheme.surface,
              onSurface: scheme.onSurface),
        ),
        child: child);
  }
}
