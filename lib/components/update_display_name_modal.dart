import 'package:emergency_allergy_app/features/authentication/data/sources/auth_firebase_service.dart';
import 'package:emergency_allergy_app/components/form_button.dart';
import 'package:emergency_allergy_app/components/form_textfield.dart';
import 'package:emergency_allergy_app/utils/modal_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UpdateDisplayNameModal extends StatefulWidget {
  const UpdateDisplayNameModal({super.key});

  @override
  State<UpdateDisplayNameModal> createState() => _UpdateDisplayNameModalState();
}

class _UpdateDisplayNameModalState extends State<UpdateDisplayNameModal> {
  final TextEditingController displayNameController = TextEditingController();
  String? displayNameError;

  @override
  void initState() {
    displayNameController.text =
        FirebaseAuth.instance.currentUser?.displayName ?? '';
    super.initState();
  }

  void onUpdate() {
    setState(() {
      displayNameError = null;
    });

    if (displayNameController.text.isEmpty) {
      setState(() {
        displayNameError = 'Display name cannot be empty';
      });
      return;
    }

    AuthFirebaseServiceImpl auth = AuthFirebaseServiceImpl();
    auth.updateDisplayName(displayNameController.text);
    showSnackBar(context, 'Updated display name');
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: 500,
      child: Column(
        children: [
          FormTextField(
            hintText: 'Enter your name',
            textController: displayNameController,
            maxLength: 50,
            errorMsg: displayNameError,
          ),
          // const SizedBox(height: 15),
          FormButton(onTap: () => onUpdate(), text: 'Update'),
        ],
      ),
    );
  }
}
