import 'package:emergency_allergy_app/components/form_button.dart';
import 'package:emergency_allergy_app/components/form_textfield.dart';
import 'package:emergency_allergy_app/utils/modal_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddFriendModal extends StatefulWidget {
  final Function(String) onAdd;
  const AddFriendModal({super.key, required this.onAdd});

  @override
  State<AddFriendModal> createState() => _AddFriendModalState();
}

class _AddFriendModalState extends State<AddFriendModal> {
  String? userId;

  String? friendTextFieldError;

  TextEditingController friendId = TextEditingController();

  void onAddFriendButtonPressed() {
    setState(() {
      friendTextFieldError = null;
    });

    if (friendId.text.isEmpty) {
      setState(() {
        friendTextFieldError = 'Please enter a friend ID';
      });
      return;
    }

    if (friendId.text == userId) {
      setState(() {
        friendTextFieldError = 'You cannot add yourself as a friend...';
      });
      return;
    }

    widget.onAdd(friendId.text);
    showSnackBar(context, 'Added friend');
    Navigator.pop(context);
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
      height: 265,
      width: 500,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 25),
          InkWell(
            onTap: copyUserIdToClipboard,
            child: Column(
              children: [
                Text('Give your ID to a friend:', style: TextStyle(color: Theme.of(context).colorScheme.onSecondary)),
                Text(userId ?? 'No user logged in', style: const TextStyle(fontSize: 16),),
                Text('(click to copy)', style: TextStyle(color: Theme.of(context).colorScheme.onSecondary)),
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
          FormTextField(hintText: 'Enter friend ID', textController: friendId, errorMsg: friendTextFieldError),
          const SizedBox(height: 10),
          FormButton(onTap: () => onAddFriendButtonPressed(), text: 'Add Friend')
        ],
      ),
    );
  }
}
