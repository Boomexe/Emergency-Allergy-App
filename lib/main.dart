import 'package:emergency_allergy_app/auth/auth_gate.dart';
import 'package:flutter/material.dart';

import 'package:emergency_allergy_app/themes/dark_theme.dart';
import 'package:emergency_allergy_app/themes/light_theme.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:emergency_allergy_app/firebase_options.dart';

// todo: add google-services.json and GoogleService-Info.plist to gitignore

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
      home: const AuthGate(),
    );
  }
}
