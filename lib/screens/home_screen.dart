import 'package:emergency_allergy_app/components/custom_navigation_bar.dart';
import 'package:emergency_allergy_app/components/new_custom_navbar.dart';
import 'package:emergency_allergy_app/screens/allergy_screen.dart';
import 'package:emergency_allergy_app/screens/dashboard_screen.dart';
import 'package:emergency_allergy_app/screens/medications.dart';
import 'package:emergency_allergy_app/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  static List<Widget> screens = [
    const Dashboard(),
    const Medications(),
    const Allergies(),
    const Profile(),
  ];

  void onUpdateIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: selectedIndex,
        onUpdateIndex: onUpdateIndex,
      ),
    );
  }
}
