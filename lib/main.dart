import 'package:emergency_allergy_app/components/custom_navigation_bar.dart';
import 'package:emergency_allergy_app/screens/allergy_screen.dart';
import 'package:emergency_allergy_app/screens/dashboard_screen.dart';
import 'package:emergency_allergy_app/screens/medication_screen.dart';
import 'package:emergency_allergy_app/screens/profile_screen.dart';
// import 'package:emergency_allergy_app/screens/reminder_screen.dart';
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
