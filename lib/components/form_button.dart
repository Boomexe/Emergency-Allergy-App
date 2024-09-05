import 'package:flutter/material.dart';

class FormButton extends StatelessWidget {
  final void Function() onTap;
  final String text;
  const FormButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.surfaceContainer,
        ),
        padding: const EdgeInsets.symmetric(vertical: 10),
        // margin: const EdgeInsets.symmetric(horizontal: 25),
        child: Center(
          child: Text(text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                )),
        ),
      ),
    );
  }
}
