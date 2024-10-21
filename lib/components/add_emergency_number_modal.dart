import 'package:emergency_allergy_app/components/form_button.dart';
import 'package:emergency_allergy_app/components/form_textfield.dart';
import 'package:emergency_allergy_app/models/emergency_number.dart';
import 'package:emergency_allergy_app/services/firestore_service.dart';
import 'package:emergency_allergy_app/utils/modal_utils.dart';
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

    String validatedPhoneNumberText =
        phoneNumberController.text.replaceAll(RegExp(r'\D'), '');

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

    EmergencyNumber contact = EmergencyNumber(
      userId: user.uid,
      name: nameController.text,
      phoneNumber: validatedPhoneNumberText,
    );

    FirestoreService.addEmergencyNumber(contact);
    showSnackBar(context, 'Added emergency number');
    Navigator.pop(context);
  }

  void switchAddEmergencyContactModal() {
    Navigator.pop(context);
    showAddEmergencyContactModal(context);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.27,
      width: 500,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FormTextField(
              hintText: 'Enter contact name',
              textController: nameController,
              errorMsg: nameError,
            ),
            const SizedBox(height: 10),
            FormTextField(
              hintText: 'Enter contact phone number',
              textController: phoneNumberController,
              keyboardType: TextInputType.phone,
              errorMsg: phoneNumberError,
            ),
            const SizedBox(height: 10),
            FormButton(
              onTap: () => onAddEmergencyContactButtonPressed(),
              text: 'Add Emergency Number',
            ),
            const SizedBox(height: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Adding someone with the app? '),
                GestureDetector(
                  onTap: () => switchAddEmergencyContactModal(),
                  child: const Text(
                    'Add Account',
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
