import 'package:emergency_allergy_app/features/authentication/domain/usecases/signup.dart';
import 'package:emergency_allergy_app/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:emergency_allergy_app/features/authentication/data/models/create_user_req.dart';
import 'package:emergency_allergy_app/components/form_button.dart';
import 'package:emergency_allergy_app/components/form_textfield.dart';
import 'package:emergency_allergy_app/utils/modal_utils.dart';

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

    var result = await sl<SignupUseCase>().call(
      params: CreateUserReq(
        displayName: nameController.text,
        email: emailController.text,
        password: passwordController.text,
      ),
    );

    result.fold(
      (l) => showSnackBar(context, l),
      (r) => showSnackBar(context, r),
    );
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
