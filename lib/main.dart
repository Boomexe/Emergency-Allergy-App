import 'package:emergency_allergy_app/screens/allergies.dart';
import 'package:emergency_allergy_app/screens/dashboard.dart';
import 'package:emergency_allergy_app/screens/medications.dart';
import 'package:emergency_allergy_app/screens/profile.dart';
import 'package:emergency_allergy_app/screens/reminders.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Allergy Emergency',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const Dashboard(),
      routes: {
        '/reminders': (context) => const Reminders(),
        '/medications': (context) => const Medications(),
        '/allergies': (context) => const Allergies(),
        '/profile': (context) => const Profile(),
      },
    );
  }
}