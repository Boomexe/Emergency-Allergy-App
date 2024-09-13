import 'package:emergency_allergy_app/auth/login_or_register_screen.dart';
import 'package:emergency_allergy_app/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomeScreen(selectedIndex: 0);
          }

          else {
            return const LoginOrRegister();
          }
        }
      ),
    );
  }
}