import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  final Function(int) onUpdateIndex;
  final int currentIndex;
  const CustomNavigationBar({super.key, required this.currentIndex, required this.onUpdateIndex});

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
            NavigationDestination(icon: Icon(Icons.home, color: Theme.of(context).colorScheme.onSurface), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.medication, color: Theme.of(context).colorScheme.onSurface), label: 'Medication'),
            NavigationDestination(icon: Icon(Icons.health_and_safety, color: Theme.of(context).colorScheme.onSurface), label: 'Allergies'),
            NavigationDestination(icon: Icon(Icons.person, color: Theme.of(context).colorScheme.onSurface), label: 'Profile'),
          ],
          onDestinationSelected: (value) {
            onUpdateIndex(value);
          },
        ),
      ),
    );
  }
}
