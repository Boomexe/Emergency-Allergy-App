import 'package:emergency_allergy_app/models/reminder.dart';
import 'package:emergency_allergy_app/screens/create_reminder_screen.dart';
import 'package:emergency_allergy_app/utils/modal_utils.dart';
import 'package:emergency_allergy_app/utils/reminder_utils.dart';
import 'package:flutter/material.dart';

class ReminderListTile extends StatefulWidget {
  final Reminder reminder;
  final int? index;
  final Function(Reminder, int)? onUpdateReminder;
  final Function(int)? onDeleteReminder;
  final bool isInteractable;
  const ReminderListTile({
    super.key,
    required this.reminder,
    required this.isInteractable,
    this.index,
    this.onUpdateReminder,
    this.onDeleteReminder,
  });

  @override
  State<ReminderListTile> createState() => _ReminderListTileState();
}

class _ReminderListTileState extends State<ReminderListTile> {
  late String titleText;
  late String subtitleText;
  late String trailingText;

  @override
  void initState() {
    titleText =
        ReminderUtils.timeOfDayToString(widget.reminder.time, usePeriod: true);
    subtitleText = ReminderUtils.getSelectedDayString(widget.reminder.days);
    trailingText = widget.reminder.active ? 'On' : 'Off';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        onTap: () {
          if (widget.isInteractable &&
              widget.index != null &&
              widget.index != null) {
            showModal(
              context,
              CreateReminderScreen(
                onSaveReminder: (reminder) =>
                    widget.onUpdateReminder!(reminder, widget.index!),
                reminder: widget.reminder,
                onDeleteReminder: () => widget.onDeleteReminder!(widget.index!),
              ),
            );
          }
        },
        title: Text(
          titleText,
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
        subtitle: Text(
          subtitleText,
          style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
        ),
        // isThreeLine: true,
        trailing: Wrap(
          children: [
            Text(
              trailingText,
              style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onSecondary),
            ),
            const SizedBox(width: 3),
            if (widget.isInteractable)
              Icon(
                Icons.arrow_forward,
                size: 20,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
          ],
        ),
      ),
    );
  }
}
