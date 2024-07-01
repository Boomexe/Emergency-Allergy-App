import 'package:emergency_allergy_app/components/custom_navigation_bar.dart';
import 'package:flutter/material.dart';

class Medications extends StatefulWidget {
  const Medications({super.key});

  @override
  State<Medications> createState() => _MedicationsState();
}

class _MedicationsState extends State<Medications> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          child: Text('Medications'),
        ),
        bottomNavigationBar: CustomNavigationBar(currentIndex: 2,));
  }
}