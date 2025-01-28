import 'package:emergency_allergy_app/features/authentication/presentation/pages/auth_gate.dart';
import 'package:emergency_allergy_app/features/authentication/data/sources/auth_firebase_service.dart';
import 'package:emergency_allergy_app/components/form_button.dart';
import 'package:emergency_allergy_app/screens/home_screen.dart';
import 'package:emergency_allergy_app/utils/modal_utils.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  void signOut() async {
    final auth = AuthFirebaseServiceImpl();
    auth.signout();

    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AuthGate(),
      ),
    );
    showSnackBar(context, 'Successfully signed out');
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
        leading: IconButton(onPressed: () => exitSettingsScreen(), icon: const Icon(Symbols.arrow_back)),
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
