import 'package:emergency_allergy_app/components/custom_navigation_bar.dart';
import 'package:emergency_allergy_app/screens/allergy_screen.dart';
import 'package:emergency_allergy_app/screens/dashboard_screen.dart';
import 'package:emergency_allergy_app/screens/medication_screen.dart';
import 'package:emergency_allergy_app/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final int selectedIndex;
  const HomeScreen({super.key, required this.selectedIndex});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int selectedIndex;

  static List<Widget> screens = [
    const Dashboard(),
    const Medications(),
    const Allergies(),
    const Profile(),
  ];

  @override
  void initState() {
    selectedIndex = widget.selectedIndex;
    super.initState();
  }

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
