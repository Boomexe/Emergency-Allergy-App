import 'package:emergency_allergy_app/models/allergy.dart';
import 'package:emergency_allergy_app/models/medication.dart';
import 'package:emergency_allergy_app/screens/allergy_screen.dart';
import 'package:emergency_allergy_app/screens/medication_screen.dart';
import 'package:emergency_allergy_app/services/firestore.dart';
import 'package:flutter/material.dart';

Future<void> showModal(BuildContext context, Widget content) {
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
          ));
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
                    // borderRadius: BorderRadius.vertical(
                    //   top: Radius.circular(20.0),
                    // ),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 15, left: 15, right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Medication Details',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                            ),
                            TextButton(
                              onPressed: () async => showModal(
                                  context,
                                  CreateMedication(
                                      medicationToEdit: medication)),
                              child: Text('Edit',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surfaceContainerLow)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
      });
}

void showAllergyInformationSheet(BuildContext context, Allergy allergy) {
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
                // borderRadius: BorderRadius.vertical(
                //   top: Radius.circular(20.0),
                // ),
              ),
              // width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Allergy Details',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.onPrimary),
                        ),
                        TextButton(
                          onPressed: () async => showModal(
                              context,
                              CreateAllergy(
                                  medications:
                                      await FirestoreService.getMedications(),
                                  allergyToEdit: allergy)),
                          child: Text('Edit',
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .surfaceContainerLow)),
                        ),
                      ],
                    ),
                    Text(
                      allergy.name,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      allergy.description,
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                    Text('Type: ${allergy.type.name}'),
                    Text('Severity: ${allergy.severity.name}'),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
