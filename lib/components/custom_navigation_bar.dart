import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  final Function(int) onUpdateIndex;
  final int currentIndex;
  const CustomNavigationBar({super.key, required this.currentIndex, required this.onUpdateIndex});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: currentIndex,
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.medication), label: 'Medication'),
        NavigationDestination(icon: Icon(Icons.health_and_safety), label: 'Allergies'),
        NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
      ],
      onDestinationSelected: (value) {
        onUpdateIndex(value);
      },
    );
  }
}
