import 'package:emergency_allergy_app/components/custom_navigation_bar.dart';
import 'package:emergency_allergy_app/screens/allergy_screen.dart';
import 'package:emergency_allergy_app/screens/dashboard_screen.dart';
import 'package:emergency_allergy_app/screens/emergency_contacts_screen.dart';
import 'package:emergency_allergy_app/screens/medication_screen.dart';
import 'package:emergency_allergy_app/services/notification_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final int selectedIndex;
  final int selectedEmergencyContactIndex;
  const HomeScreen(
      {super.key,
      required this.selectedIndex,
      this.selectedEmergencyContactIndex = 0});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int selectedIndex;

  late List<Widget> screens = [];

  @override
  void initState() {
    selectedIndex = widget.selectedIndex;
    screens = [
      const Dashboard(),
      const Medications(),
      const Allergies(),
      EmergencyContactsScreen(
        openIndex: widget.selectedEmergencyContactIndex,
      ),
    ];
    NotificationService.getDeviceToken();
    super.initState();
  }

  void onUpdateIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 100),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: screens[selectedIndex],
        ),
        bottomNavigationBar: CustomNavigationBar(
          currentIndex: selectedIndex,
          onUpdateIndex: onUpdateIndex,
        ),
      ),
    );
  }
}
