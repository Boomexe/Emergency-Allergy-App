import 'package:flutter/material.dart';

class FormTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController textController;
  final String Function(String)? validator;
  final String? errorMsg;
  final TextInputType? keyboardType;
  const FormTextField(
      {super.key,
      required this.hintText,
      this.obscureText = false,
      required this.textController,
      this.validator,
      this.errorMsg, this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextFormField(
        keyboardType: keyboardType ?? TextInputType.text,
        controller: textController,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.secondary)),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.secondary)),
          hintText: hintText,
          errorText: errorMsg,
          filled: true,
          fillColor: Theme.of(context).colorScheme.primary,
        ),
        obscureText: obscureText,
        validator: (value) => validator!(value!),
      ),
    );
  }
}
