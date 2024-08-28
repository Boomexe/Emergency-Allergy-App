import 'package:emergency_allergy_app/auth/login_or_register_screen.dart';
import 'package:flutter/material.dart';

import 'package:emergency_allergy_app/components/custom_navigation_bar.dart';

import 'package:emergency_allergy_app/screens/allergy_screen.dart';
import 'package:emergency_allergy_app/screens/dashboard_screen.dart';
import 'package:emergency_allergy_app/screens/medication_screen.dart';
import 'package:emergency_allergy_app/screens/profile_screen.dart';

import 'package:emergency_allergy_app/themes/dark_theme.dart';
import 'package:emergency_allergy_app/themes/light_theme.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:emergency_allergy_app/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static List<Widget> screens = [
    // Dashboard(),
    const LoginOrRegister(),
    const Medications(),
    const Allergies(),
    const Profile(),
  ];

  int selectedIndex = 0;

  void onUpdateIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Allergy Emergency',
      theme: lightTheme,
      darkTheme: darkTheme,
      home: Scaffold(
        body: screens[selectedIndex],
        bottomNavigationBar: CustomNavigationBar(
          onUpdateIndex: onUpdateIndex,
          currentIndex: selectedIndex,
        ),
      ),
    );
  }
}
