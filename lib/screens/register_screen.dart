import 'package:emergency_allergy_app/auth/auth_service.dart';
import 'package:emergency_allergy_app/components/form_button.dart';
import 'package:emergency_allergy_app/components/form_textfield.dart';
import 'package:emergency_allergy_app/utils/modal_utils.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  final void Function() onTap;
  const RegisterScreen({super.key, required this.onTap});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  String? nameTextFieldError;
  String? emailTextFieldError;
  String? passwordTextFieldError;
  String? confirmPasswordTextFieldError;

  void register(BuildContext context) async {
    final auth = AuthService();

    setState(() {
      nameTextFieldError = null;
      emailTextFieldError = null;
      passwordTextFieldError = null;
      confirmPasswordTextFieldError = null;
    });

    if (nameController.text.isEmpty) {
      setState(() {
        nameTextFieldError = 'Please enter your name.';
      });
      return;
    }

    if (emailController.text.isEmpty) {
      setState(() {
        emailTextFieldError = 'Please enter your email.';
      });
      return;
    }

    if (!emailController.text.contains('@')) {
      setState(() {
        emailTextFieldError = 'Please format your email correctly.';
      });
      return;
    }

    if (passwordController.text.isEmpty) {
      setState(() {
        passwordTextFieldError = 'Please enter your password.';
      });
      return;
    }

    if (confirmPasswordController.text.isEmpty) {
      setState(() {
        confirmPasswordTextFieldError = 'Please confirm your password.';
      });
      return;
    }

    if (passwordController.text.length < 6) {
      setState(() {
        passwordTextFieldError = 'Password must be at least 6 characters.';
      });
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      setState(() {
        confirmPasswordTextFieldError = 'Passwords do not match.';
      });
      return;
    }

    try {
      await auth
          .signUpWithEmailAndPassword(emailController.text,
              passwordController.text, nameController.text)
          .then((value) {
        showSnackBar(context, 'Successfully registered.');
      });
    } catch (e) {
      List<String> errorMessage =
          AuthService.getMessageFromErrorCode(e.toString().split(' ').last);
      showSnackBar(context, '${errorMessage[0]}: ${errorMessage[1]}');
      // showAlertDialog(context, errorMessage[0], errorMessage[1]);
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
              // const Icon(Symbols.medical_services, size: 100),
              Image.asset('assets/images/app_icon.png', width: 100),
              const SizedBox(height: 25),
              FormTextField(
                hintText: 'Name',
                textController: nameController,
                errorMsg: nameTextFieldError,
                keyboardType: TextInputType.name,
                maxLength: 50,
              ),
              const SizedBox(height: 10),
              FormTextField(
                hintText: 'Email',
                textController: emailController,
                errorMsg: emailTextFieldError,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 10),
              FormTextField(
                hintText: 'Password',
                obscureText: true,
                textController: passwordController,
                errorMsg: passwordTextFieldError,
              ),
              const SizedBox(height: 10),
              FormTextField(
                hintText: 'Confirm Password',
                obscureText: true,
                textController: confirmPasswordController,
                errorMsg: confirmPasswordTextFieldError,
              ),
              const SizedBox(height: 25),
              FormButton(onTap: () => register(context), text: 'Sign Up'),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account? '),
                  GestureDetector(
                    onTap: widget.onTap,
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
      ),
    );
  }
}
