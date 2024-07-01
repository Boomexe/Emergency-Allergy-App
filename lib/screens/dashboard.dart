import 'package:flutter/material.dart';

import '../components/custom_navigation_bar.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          child: Text('Welcome to the Allergy Emergency App!'),
        ),
        bottomNavigationBar: CustomNavigationBar());
  }
}
