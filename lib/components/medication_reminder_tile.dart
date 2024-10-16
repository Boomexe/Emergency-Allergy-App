import 'package:emergency_allergy_app/models/medication.dart';
import 'package:emergency_allergy_app/utils/reminder_utils.dart';
import 'package:flutter/material.dart';

class MedicationReminderTile extends StatefulWidget {
  final Medication medication;
  final int reminderIndex;

  const MedicationReminderTile({
    super.key,
    required this.medication,
    required this.reminderIndex,
  });

  @override
  State<MedicationReminderTile> createState() => _MedicationReminderTileState();
}

class _MedicationReminderTileState extends State<MedicationReminderTile> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: Card.filled(
        color: Theme.of(context).colorScheme.secondary,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.medication.name,
                softWrap: false,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 16,
                ),
              ),
              Text(
                widget.medication.dosage,
                softWrap: false,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontSize: 14,
                ),
              ),
              // const SizedBox(height: 10),
              Text(
                ReminderUtils.timeOfDayToString(widget.medication.reminders[widget.reminderIndex].time),
                softWrap: false,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontSize: 16,
                ),
              ),
              // Text(
              //   ReminderUtils.getSelectedDayString(widget.medication.reminders[widget.reminderIndex].days),
              //   style: TextStyle(
              //     color: Theme.of(context).colorScheme.onSecondary,
              //     fontSize: 14,
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
