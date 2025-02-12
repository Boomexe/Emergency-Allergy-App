import 'package:flutter/material.dart';

class FormTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController textController;
  final String Function(String)? validator;
  final String? errorMsg;
  final TextInputType? keyboardType;
  final int? maxLength;
  const FormTextField({
    super.key,
    required this.hintText,
    this.obscureText = false,
    required this.textController,
    this.validator,
    this.errorMsg,
    this.keyboardType,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      keyboardType: keyboardType ?? TextInputType.text,
      cursorColor: Theme.of(context).colorScheme.surfaceContainerLow,
      controller: textController,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.primary)),
        focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.secondary)),
        hintText: hintText,
        hintStyle:
            TextStyle(color: Theme.of(context).colorScheme.onSecondary),
        errorText: errorMsg,
        filled: true,
        fillColor: Theme.of(context).colorScheme.secondary,
      ),
      obscureText: obscureText,
      validator: (value) => validator!(value!),
    );
  }
}
