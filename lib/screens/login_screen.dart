import 'package:emergency_allergy_app/auth/auth_service.dart';
import 'package:emergency_allergy_app/components/form_button.dart';
import 'package:emergency_allergy_app/components/form_textfield.dart';
import 'package:emergency_allergy_app/utils/modal_utils.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final void Function() onTap;
  const LoginScreen({super.key, required this.onTap});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  String? emailTextFieldError;
  String? passwordTextFieldError;

  void login(BuildContext context) async {
    final auth = AuthService();

    setState(() {
      emailTextFieldError = null;
      passwordTextFieldError = null;
    });

    if (emailController.text.isEmpty) {
      setState(() {
        emailTextFieldError = 'Please enter your email.';
      });
      return;
    }

    if (!emailController.text.contains('@')) {
      setState(() {
        emailTextFieldError = 'Please enter a valid email.';
      });
      return;
    }

    if (passwordController.text.isEmpty) {
      setState(() {
        passwordTextFieldError = 'Please enter your password.';
      });
      return;
    }

    try {
      await auth.signInWithEmailAndPassword(
          emailController.text, passwordController.text).then((value) {
            showSnackBar(context, 'Successfully signed in');
          });
    } catch (e) {
      List<String> errorMessage =
          AuthService.getMessageFromErrorCode(e.toString().split(' ').last);
      showSnackBar(context, '${errorMessage[0]}: ${errorMessage[1]}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/app_icon.png', width: 100),
              // const Icon(Symbols.medical_services, size: 100),
              const SizedBox(height: 25),
              FormTextField(
                hintText: 'Email',
                textController: emailController,
                keyboardType: TextInputType.emailAddress,
                errorMsg: emailTextFieldError,
              ),
              const SizedBox(height: 10),
              FormTextField(
                hintText: 'Password',
                obscureText: true,
                textController: passwordController,
                errorMsg: passwordTextFieldError,
              ),
              const SizedBox(height: 25),
              FormButton(onTap: () => login(context), text: 'Log in'),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account? '),
                  GestureDetector(
                    onTap: widget.onTap,
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
      ),
    );
  }
}
