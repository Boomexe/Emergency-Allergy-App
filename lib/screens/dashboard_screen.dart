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

  void testingButton() {
    final auth = AuthService();
    auth.updateDisplayName('Test User');
  }

  @override
  Widget build(BuildContext context) {
    String? userName = AuthService().auth.currentUser?.displayName;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('Welcome', style: TextStyle(fontSize: 24)),
            if (userName != null)
              Text(
                ', ${userName.split(' ')[0]}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              )
            else
              const Text(
                '',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormButton(
              onTap: () => emergency(),
              text: 'Having a medical emergency?',
              backgroundColor:
                  Theme.of(context).colorScheme.surfaceContainerHighest,
              verticalPadding: 25,
            ),
            const SizedBox(height: 50),
            const Text('Upcoming Medications', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            FormButton(onTap: () => logout(), text: 'Sign Out'),
            // FormButton(onTap: () => testingButton(), text: 'Testing Button'),
          ],
        ),
      ),
    );
  }
}
