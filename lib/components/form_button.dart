import 'package:flutter/material.dart';

class FormButton extends StatelessWidget {
  final void Function() onTap;
  final String text;
  final Color? backgroundColor;
  final double verticalPadding;
  const FormButton({
    super.key,
    required this.onTap,
    required this.text,
    this.backgroundColor,
    this.verticalPadding = 10,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color:
              backgroundColor ?? Theme.of(context).colorScheme.surfaceContainer,
        ),
        padding: EdgeInsets.symmetric(vertical: verticalPadding),
        // margin: const EdgeInsets.symmetric(horizontal: 25),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}
