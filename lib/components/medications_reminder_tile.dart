import 'package:emergency_allergy_app/models/medication.dart';
import 'package:emergency_allergy_app/utils/modal_utils.dart';
import 'package:emergency_allergy_app/utils/reminder_utils.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class MedicationReminderTile extends StatelessWidget {
  final Medication medication;
  final int reminderIndex;
  final bool isFirstMedication;

  const MedicationReminderTile({
    super.key,
    required this.medication,
    required this.reminderIndex,
    required this.isFirstMedication,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      tileColor: Theme.of(context).colorScheme.secondary,
      visualDensity: VisualDensity.comfortable,
      dense: false,
      contentPadding: isFirstMedication ? const EdgeInsets.symmetric(vertical: 10, horizontal: 20) : null,
      title: Text(
        medication.name,
        style: TextStyle(
          fontSize: isFirstMedication ? 20 : 16,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      subtitle: Text(
        'Dose: ${medication.dosage}',
        style: TextStyle(
          fontSize: isFirstMedication ? 16 : 14,
          color: Theme.of(context).colorScheme.onSecondary,
        ),
      ),
      trailing: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Icon(
            Symbols.schedule,
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            size: 20,
            applyTextScaling: true,
          ),
          const SizedBox(width: 5),
          Text(
            ReminderUtils.timeOfDayToString(
              medication.reminders[reminderIndex].time,
            ),
            softWrap: false,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondary,
              fontSize: isFirstMedication ? 24 : 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      onTap: () => showMedicationInformationSheet(context, medication),
    );
    // return SizedBox(
    //   width: 150,
    //   height: 150,
    //   child: Card.filled(
    //     color: Theme.of(context).colorScheme.secondary,
    //     child: Padding(
    //       padding: const EdgeInsets.all(8),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Text(
    //             widget.medication.name,
    //             softWrap: false,
    //             style: TextStyle(
    //               color: Theme.of(context).colorScheme.onPrimary,
    //               fontSize: 16,
    //             ),
    //           ),
    //           Text(
    //             widget.medication.dosage,
    //             softWrap: false,
    //             style: TextStyle(
    //               color: Theme.of(context).colorScheme.onSecondary,
    //               fontSize: 14,
    //             ),
    //           ),
    //           // const SizedBox(height: 10),
    //           Text(
    //             ReminderUtils.timeOfDayToString(widget.medication.reminders[widget.reminderIndex].time),
    //             softWrap: false,
    //             style: TextStyle(
    //               color: Theme.of(context).colorScheme.onSecondary,
    //               fontSize: 16,
    //             ),
    //           ),
    //           // Text(
    //           //   ReminderUtils.getSelectedDayString(widget.medication.reminders[widget.reminderIndex].days),
    //           //   style: TextStyle(
    //           //     color: Theme.of(context).colorScheme.onSecondary,
    //           //     fontSize: 14,
    //           //   ),
    //           // )
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
