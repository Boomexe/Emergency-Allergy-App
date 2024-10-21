import 'package:emergency_allergy_app/components/form_button.dart';
import 'package:emergency_allergy_app/components/form_textfield.dart';
import 'package:emergency_allergy_app/screens/home_screen.dart';
import 'package:emergency_allergy_app/services/firestore_service.dart';
import 'package:emergency_allergy_app/utils/modal_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddEmergencyContactModal extends StatefulWidget {
  const AddEmergencyContactModal({super.key});

  @override
  State<AddEmergencyContactModal> createState() =>
      _AddEmergencyContactModalState();
}

class _AddEmergencyContactModalState extends State<AddEmergencyContactModal> {
  String? userId;

  String? friendTextFieldError;

  TextEditingController friendId = TextEditingController();

  void onAddFriendButtonPressed() async {
    setState(() {
      friendTextFieldError = null;
    });

    if (friendId.text.isEmpty) {
      setState(() {
        friendTextFieldError = 'Please enter an emergency contact ID';
      });
      return;
    }

    if (friendId.text == userId) {
      setState(() {
        friendTextFieldError =
            'You cannot add yourself as an emergency contact...';
      });
      return;
    }
    if (await FirestoreService.getNameFromUserId(friendId.text) == null) {
      setState(() {
        friendTextFieldError = 'Incorrect ID - user does not exist';
      });

      return;
    }

    FirestoreService.addEmergencyContact(friendId.text);
    showSnackBar(context, 'Added emergency contact');
    Navigator.pop(context);
    // Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(selectedIndex: 3),
      ),
    );
  }

  void switchAddEmergencyNumberModal() {
    Navigator.pop(context);
    showAddEmergencyNumberModal(context);
  }

  String? getUserId() {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      return user.uid;
    }

    return null;
  }

  void copyUserIdToClipboard() {
    if (userId == null) {
      return;
    }

    Clipboard.setData(ClipboardData(text: userId!));
    showSnackBar(context, 'ID copied to clipboard');
  }

  @override
  void initState() {
    userId = getUserId();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.35,
      width: 500,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: copyUserIdToClipboard,
              child: Column(
                children: [
                  Text('Give your ID to a friend/family member:',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary)),
                  Text(
                    userId ?? 'ERROR - No user logged in',
                    style: const TextStyle(fontSize: 16),
                    softWrap: false,
                  ),
                  Text('(click to copy)',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary)),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 5, right: 20),
                    child: Divider(
                      color: Theme.of(context).colorScheme.onPrimary,
                      height: 36,
                    ),
                  ),
                ),
                const Text('OR'),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, right: 5),
                    child: Divider(
                      color: Theme.of(context).colorScheme.onPrimary,
                      height: 36,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            FormTextField(
                hintText: 'Enter emergency contact ID',
                textController: friendId,
                errorMsg: friendTextFieldError),
            const SizedBox(height: 10),
            FormButton(
              onTap: () => onAddFriendButtonPressed(),
              text: 'Add Emergency Contact',
            ),
            const SizedBox(height: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Adding someone without the app? '),
                GestureDetector(
                  onTap: () => switchAddEmergencyNumberModal(),
                  child: const Text(
                    'Add Phone Number',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
