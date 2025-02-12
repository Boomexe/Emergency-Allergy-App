import 'package:emergency_allergy_app/components/detail_card.dart';
import 'package:emergency_allergy_app/components/list_view_seperator.dart';
import 'package:emergency_allergy_app/components/reminder_list_tile.dart';
import 'package:emergency_allergy_app/models/medication.dart';
import 'package:emergency_allergy_app/screens/medication_screen.dart';
import 'package:emergency_allergy_app/utils/modal_utils.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class MedicationDetails extends StatefulWidget {
  final Medication medication;
  const MedicationDetails({super.key, required this.medication});

  @override
  State<MedicationDetails> createState() => _MedicationDetailsState();
}

class _MedicationDetailsState extends State<MedicationDetails> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 300,
              child: Text(
                '${widget.medication.name} Details',
                // softWrap: false,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
            TextButton(
              onPressed: () async => showCustomBottomSheet(
                context,
                CreateMedication(
                  medicationToEdit: widget.medication,
                ),
              ),
              child: Text(
                'Edit',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.surfaceContainerLow,
                ),
              ),
            ),
          ],
        ),
        widget.medication.note.isNotEmpty
            ? Text(
                widget.medication.note,
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              )
            : Container(),
        const SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DetailCard(
              width: 200,
              color: Theme.of(context).colorScheme.surfaceContainer,
              textColor: Theme.of(context).colorScheme.onPrimary,
              title: 'Dosage: ${widget.medication.dosage}',
              icon: Symbols.medication,
            ),
          ],
        ),
        Text(
          widget.medication.reminders.isNotEmpty ? 'Reminders' : 'No Reminders',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.medication.reminders.length,
          separatorBuilder: (context, index) => const ListViewSeperator(),
          itemBuilder: (context, index) {
            return ReminderListTile(
              reminder: widget.medication.reminders[index],
              isInteractable: false,
            );
          },
        ),
      ],
    );
  }
}
