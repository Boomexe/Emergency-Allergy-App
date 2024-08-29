import 'package:emergency_allergy_app/auth/auth_service.dart';
import 'package:emergency_allergy_app/components/form_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  void logout() async {
    final auth = AuthService();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Welcome to the Allergy Emergency App!'),
          FormButton(onTap: logout, text: 'Sign Out')
        ],
      ),
    ));
  }
}
