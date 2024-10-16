import 'package:emergency_allergy_app/components/form_button.dart';
import 'package:emergency_allergy_app/components/form_textfield.dart';
import 'package:emergency_allergy_app/models/emergency_number.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddEmergencyNumberModal extends StatefulWidget {
  const AddEmergencyNumberModal({super.key});

  @override
  State<AddEmergencyNumberModal> createState() =>
      _AddEmergencyNumberModalState();
}

class _AddEmergencyNumberModalState extends State<AddEmergencyNumberModal> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  String? nameError;
  String? phoneNumberError;

  void onAddEmergencyContactButtonPressed() {
    setState(() {
      nameError = null;
      phoneNumberError = null;
    });

    if (nameController.text.isEmpty) {
      setState(() {
        nameError = 'Please enter a name';
      });
      return;
    }

    if (phoneNumberController.text.isEmpty) {
      setState(() {
        phoneNumberError = 'Please enter a phone number';
      });
      return;
    }

    String validatedPhoneNumberText = phoneNumberController.text.replaceAll(RegExp(r'\D'), '');

    if (validatedPhoneNumberText.length != 10) {
      setState(() {
        phoneNumberError = 'Please enter a valid phone number';
      });
      return;
    }

    User? user = FirebaseAuth.instance.currentUser;
    
    if (user == null) {
      return;
    }

    EmergencyContact contact = EmergencyContact(
      userId: user.uid,
      name: nameController.text,
      phoneNumber: validatedPhoneNumberText,
    );

    // FirestoreService.addEmergencyContact(contact);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 500,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FormTextField(
            hintText: 'Enter emergency contact name',
            textController: nameController,
            errorMsg: nameError,
          ),
          const SizedBox(height: 10),
          FormTextField(
            hintText: 'Enter phone number',
            textController: phoneNumberController,
            keyboardType: TextInputType.phone,
            errorMsg: phoneNumberError,
          ),
          const SizedBox(height: 10),
          FormButton(
            onTap: () => onAddEmergencyContactButtonPressed(),
            text: 'Add Emergency Contact',
          ),
        ],
      ),
    );
  }
}
