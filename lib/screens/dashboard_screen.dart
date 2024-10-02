import 'package:emergency_allergy_app/auth/auth_service.dart';
import 'package:emergency_allergy_app/components/form_button.dart';
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

  void testingButton() {}

  @override
  Widget build(BuildContext context) {
    String? userName = AuthService().auth.currentUser?.email;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to the Allergy Emergency App, $userName!'),
            FormButton(onTap: logout, text: 'Sign Out'),
            FormButton(onTap: testingButton, text: 'Testing Button'),
          ],
        ),
      ),
    );
  }
}
