import 'package:emergency_allergy_app/auth/auth_service.dart';
import 'package:emergency_allergy_app/components/form_button.dart';
import 'package:emergency_allergy_app/screens/home_screen.dart';
import 'package:emergency_allergy_app/utils/modal_utils.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  void signOut() async {
    final auth = AuthService();
    auth.signOut();

    Navigator.pop(context);
  }

  void exitSettingsScreen() {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(selectedIndex: 0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: () => exitSettingsScreen(), icon: const Icon(Icons.arrow_back)),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Change Display Name'),
            onTap: () => showChangeDisplayNameModal(context),
          ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: FormButton(
              onTap: () => signOut(),
              text: 'Sign Out',
              backgroundColor: Theme.of(context).colorScheme.tertiary,
            ),
          ),
        ],
      ),
    );
  }
}
