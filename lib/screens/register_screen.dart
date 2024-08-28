import 'package:emergency_allergy_app/components/form_button.dart';
import 'package:emergency_allergy_app/components/form_textfield.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  final void Function() onTap;
  RegisterScreen({super.key, required this.onTap});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.medical_services, size: 100),
            const SizedBox(height: 25),
            FormTextField(hintText: 'Email', textController: emailController),
            const SizedBox(height: 10),
            FormTextField(hintText: 'Password', obscureText: true, textController: passwordController),
            const SizedBox(height: 10),
            FormTextField(hintText: 'Confirm Password', obscureText: true, textController: confirmPasswordController),
            const SizedBox(height: 25),
            FormButton(onTap: () {}, text: 'Login'),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account? '),
                GestureDetector(
                  onTap: onTap,
                  child: const Text(
                    'Login',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
