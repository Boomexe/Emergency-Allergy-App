import 'package:flutter/material.dart';

class FormTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController textController;
  const FormTextField({super.key, required this.hintText, this.obscureText = false, required this.textController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        controller: textController,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.secondary)),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.secondary)),
          hintText: hintText,
          filled: true,
          fillColor: Theme.of(context).colorScheme.primary,
        ),

        obscureText: obscureText,
      ),
    );
  }
}
