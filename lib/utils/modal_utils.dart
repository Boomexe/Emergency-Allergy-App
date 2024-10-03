import 'package:emergency_allergy_app/components/add_friend_modal.dart';
import 'package:emergency_allergy_app/components/allergy_details.dart';
import 'package:emergency_allergy_app/components/medication_details.dart';
import 'package:emergency_allergy_app/models/allergy.dart';
import 'package:emergency_allergy_app/models/medication.dart';
import 'package:flutter/material.dart';

Future<void> showButtomSheet(BuildContext context, Widget content) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    enableDrag: false,
    useSafeArea: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.zero,
    ),
    builder: (context) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: content,
    ),
  );
}

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}

void showAlertDialog({required BuildContext context, required Widget title, required Widget content}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: title,
      content: Padding(
        padding: const EdgeInsets.all(0.0),
        child: content,
      ),
    ),
  );
}

void showAddFriendModal(BuildContext context, Function(String) onAdd) {
  showAlertDialog(
    context: context,
    title: const Text('Add Friend'),
    content: AddFriendModal(onAdd: onAdd),
  );
}

void showMedicationInformationSheet(
    BuildContext context, Medication medication) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (_) {
      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.3,
        minChildSize: 0.25,
        maxChildSize: 0.5,
        builder: (_, ScrollController scrollController) {
          return SizedBox(
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20.0),
                ),
              ),
              // width: double.infinity,
              child: SingleChildScrollView(
                controller: scrollController,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                  child: MedicationDetails(medication: medication),
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

void showAllergyInformationSheet(BuildContext context, Allergy allergy) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (_) {
      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.4,
        minChildSize: 0.1,
        maxChildSize: 0.6,
        builder: (_, ScrollController scrollController) {
          return SizedBox(
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20.0),
                ),
              ),
              // width: double.infinity,
              child: SingleChildScrollView(
                controller: scrollController,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                  child: AllergyDetails(allergy: allergy),
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
