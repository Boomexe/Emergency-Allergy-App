import 'package:emergency_allergy_app/auth/auth_service.dart';
import 'package:emergency_allergy_app/components/form_button.dart';
import 'package:emergency_allergy_app/components/form_textfield.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final void Function() onTap;
  LoginScreen({super.key, required this.onTap});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login(BuildContext context) async {
    final authService = AuthService();

    try {
      await authService.signInWithEmailAndPassword(
          emailController.text, passwordController.text);
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(title: Text(e.toString())));
    }
  }

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
            FormTextField(
                hintText: 'Password',
                obscureText: true,
                textController: passwordController),
            const SizedBox(height: 25),
            FormButton(onTap: () => login(context), text: 'Login'),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t have an account? '),
                GestureDetector(
                  onTap: onTap,
                  child: const Text(
                    'Sign Up',
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
