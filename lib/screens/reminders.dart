import 'package:emergency_allergy_app/components/nav_bar.dart';
import 'package:flutter/material.dart';

class Reminders extends StatefulWidget {
  const Reminders({super.key});

  @override
  State<Reminders> createState() => _RemindersState();
}

class _RemindersState extends State<Reminders> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Reminders'),
      ),
      // bottomNavigationBar: CustomNavigationBar(
      //   currentIndex: 1,
      // ),
    );
  }
}
