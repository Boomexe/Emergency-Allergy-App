import 'package:emergency_allergy_app/components/nav_bar.dart';
import 'package:emergency_allergy_app/screens/allergies.dart';
import 'package:emergency_allergy_app/screens/dashboard.dart';
import 'package:emergency_allergy_app/screens/medications.dart';
import 'package:emergency_allergy_app/screens/profile.dart';
import 'package:emergency_allergy_app/screens/reminders.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const List<Widget> screens = [
    Dashboard(),
    Medications(),
    Allergies(),
    Profile(),
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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: screens[selectedIndex],
        bottomNavigationBar: CustomNavigationBar(
          onUpdateIndex: onUpdateIndex,
          currentIndex: selectedIndex,
        ),
      ),
      // routes: {
      //   // '/reminders': (context) => const Reminders(),
      //   '/medications': (context) => const Medications(),
      //   '/allergies': (context) => const Allergies(),
      //   '/profile': (context) => const Profile(),
      // },
    );
  }
}
