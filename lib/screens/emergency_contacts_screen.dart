import 'package:emergency_allergy_app/services/firestore_service.dart';
import 'package:emergency_allergy_app/utils/modal_utils.dart';
import 'package:flutter/material.dart';

class EmergencyContactsScreen extends StatefulWidget {
  const EmergencyContactsScreen({super.key});

  @override
  State<EmergencyContactsScreen> createState() =>
      _EmergencyContactsScreenState();
}

class _EmergencyContactsScreenState extends State<EmergencyContactsScreen> {
  void onAddEmergencyContact(String emergencyContactId) {
    FirestoreService.addEmergencyContact(emergencyContactId);
    print('Adding emergency contact with ID: $emergencyContactId');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Contacts'),
        automaticallyImplyLeading: false,
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // const Text(
            //   'Welcome to the Friends screen!',
            //   style: TextStyle(
            //     fontSize: 24,
            //   ),
            // ),
            // ElevatedButton(
            //   onPressed: () {
            //     // Navigator.pushNamed(context, '/friend-details');
            //   },
            //   child: const Text('Go to Friend Details'),
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddEmergencyContactModal(
            context,
            (id) => onAddEmergencyContact(id),
          );
        },
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: const Icon(Icons.add),
      ),
    );
  }
}
