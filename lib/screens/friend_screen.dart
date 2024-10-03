import 'package:emergency_allergy_app/components/form_button.dart';
import 'package:emergency_allergy_app/utils/modal_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FriendScreen extends StatefulWidget {
  const FriendScreen({super.key});

  @override
  State<FriendScreen> createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Friends'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Welcome to the Friends screen!',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigator.pushNamed(context, '/friend-details');
              },
              child: Text('Go to Friend Details'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddFriendModal(
            context,
            (String friendId) {
              print('Adding friend with ID: $friendId');
            },
          );
        },
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: const Icon(Icons.add),
      ),
    );
  }
}
