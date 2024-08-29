import 'package:emergency_allergy_app/auth/login_or_register_screen.dart';
import 'package:emergency_allergy_app/screens/allergy_screen.dart';
import 'package:emergency_allergy_app/screens/medications.dart';
import 'package:emergency_allergy_app/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class NewCustomNavbar extends StatefulWidget {
  const NewCustomNavbar({super.key});

  @override
  State<NewCustomNavbar> createState() => _NewCustomNavbarState();
}

class _NewCustomNavbarState extends State<NewCustomNavbar> {
  int currentIndex = 0;

  static List<Widget> screens = [
    // Dashboard(),
    const LoginOrRegister(),
    const Medications(),
    const Allergies(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      // padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
      child: ClipRRect(
        // borderRadius: BorderRadius.circular(20),
        child: NavigationBar(
          selectedIndex: currentIndex,
          height: 64,
          backgroundColor: Theme.of(context).colorScheme.primary,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          destinations: [
            NavigationDestination(
                icon: Icon(Icons.home,
                    color: Theme.of(context).colorScheme.onSurface),
                label: 'Home'),
            NavigationDestination(
                icon: Icon(Icons.medication,
                    color: Theme.of(context).colorScheme.onSurface),
                label: 'Medication'),
            NavigationDestination(
                icon: Icon(Icons.health_and_safety,
                    color: Theme.of(context).colorScheme.onSurface),
                label: 'Allergies'),
            NavigationDestination(
                icon: Icon(Icons.person,
                    color: Theme.of(context).colorScheme.onSurface),
                label: 'Profile'),
          ],
          onDestinationSelected: (value) {
            if (value != currentIndex) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => screens[value]));
            }
          },
        ),
      ),
    );
  }
}
