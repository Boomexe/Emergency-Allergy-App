import 'package:emergency_allergy_app/auth/auth_service.dart';
import 'package:emergency_allergy_app/components/form_button.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

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

  void emergency() async {
    launchUrlString('tel:1234567890');
  }

  void testingButton() {}

  @override
  Widget build(BuildContext context) {
    String? userName = AuthService().auth.currentUser?.displayName;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to the Allergy Emergency App, $userName!'),
            FormButton(onTap: () => emergency(), text: 'Emergency'),
            FormButton(onTap: () => logout(), text: 'Sign Out'),
            FormButton(onTap: () => testingButton(), text: 'Testing Button'),
          ],
        ),
      ),
    );
  }
}
