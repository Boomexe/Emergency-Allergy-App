import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  final int currentIndex;
  const CustomNavigationBar({super.key, this.currentIndex = 0});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      useLegacyColorScheme: false,
      currentIndex: currentIndex,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month), label: 'Reminders'),
        BottomNavigationBarItem(
            icon: Icon(Icons.medication), label: 'Medication'),
        BottomNavigationBarItem(
            icon: Icon(Icons.health_and_safety), label: 'Allergies'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
      onTap: (index) {
        if (currentIndex == index) return;
        
        switch (index) {
          case 0:
            Navigator.popAndPushNamed(context, '/');
            break;
          case 1:
            Navigator.popAndPushNamed(context, '/reminders');
            break;
          case 2:
            Navigator.popAndPushNamed(context, '/medications');
            break;
          case 3:
            Navigator.popAndPushNamed(context, '/allergies');
            break;
          case 4:
            Navigator.popAndPushNamed(context, '/profile');
            break;
        }
      },
    );
  }
}
