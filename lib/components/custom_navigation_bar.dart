import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class CustomNavigationBar extends StatelessWidget {
  final Function(int) onUpdateIndex;
  final int currentIndex;
  const CustomNavigationBar(
      {super.key, required this.currentIndex, required this.onUpdateIndex});

  bool isCurrentIndex(int index) {
    return currentIndex == index;
  }

  double fillAtIndex(int index) {
    return isCurrentIndex(index) ? 1 : 0;
  }

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
          backgroundColor: Theme.of(context).colorScheme.secondary,
          // indicatorColor: Theme.of(context).colorScheme.surfaceContainerHighest,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          destinations: [
            NavigationDestination(
              icon: Icon(
                Symbols.home,
                size: 32,
                fill: fillAtIndex(0),
                color: Theme.of(context).colorScheme.onSurface,
              ),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(
                Symbols.medication,
                size: 32,
                fill: fillAtIndex(1),
                color: Theme.of(context).colorScheme.onSurface,
              ),
              label: 'Medications',
            ),
            NavigationDestination(
              icon: Icon(
                Symbols.allergies,
                size: 32,
                fill: fillAtIndex(2),
                color: Theme.of(context).colorScheme.onSurface,
              ),
              label: 'Allergies',
            ),
            NavigationDestination(
              icon: Icon(
                Symbols.contacts,
                size: 32,
                fill: fillAtIndex(3),
                color: Theme.of(context).colorScheme.onSurface,
              ),
              label: 'Profile',
            ),
          ],
          onDestinationSelected: (value) {
            onUpdateIndex(value);
          },
        ),
      ),
    );
  }
}
