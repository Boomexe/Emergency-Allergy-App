import 'package:day_picker/day_picker.dart';
import 'package:emergency_allergy_app/components/form_button.dart';
import 'package:emergency_allergy_app/models/reminder.dart';
import 'package:emergency_allergy_app/utils/reminder_utils.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class CreateReminderScreen extends StatefulWidget {
  final Reminder? reminder;
  final Function(Reminder) onSaveReminder;
  final Function()?
      onDeleteReminder; // Only used for when screen is opened by interacting with list tile

  const CreateReminderScreen(
      {super.key,
      required this.onSaveReminder,
      this.reminder,
      this.onDeleteReminder});

  @override
  State<CreateReminderScreen> createState() => _CreateReminderScreenState();
}

class _CreateReminderScreenState extends State<CreateReminderScreen> {
  late List<DayInWeek> days;
  late List<String> selectedDays;
  late TimeOfDay selectedTime;
  late bool isReminderEnabled;

  void onSaveReminderButtonPressed() {
    print(selectedTime);
    Reminder reminder = Reminder(
      days: selectedDays,
      time: selectedTime,
      active: isReminderEnabled,
    );

    widget.onSaveReminder(reminder);
  }

  @override
  void initState() {
    selectedDays = widget.reminder?.days ?? [];
    selectedTime = widget.reminder?.time ?? TimeOfDay.now();
    isReminderEnabled = widget.reminder?.active ?? true;

    days = [
      DayInWeek('S',
          dayKey: 'sunday',
          isSelected: widget.reminder?.days.contains('sunday') ?? false),
      DayInWeek('M',
          dayKey: 'monday',
          isSelected: widget.reminder?.days.contains('monday') ?? false),
      DayInWeek('T',
          dayKey: 'tuesday',
          isSelected: widget.reminder?.days.contains('tuesday') ?? false),
      DayInWeek('W',
          dayKey: 'wednesday',
          isSelected: widget.reminder?.days.contains('wednesday') ?? false),
      DayInWeek('T',
          dayKey: 'thursday',
          isSelected: widget.reminder?.days.contains('thursday') ?? false),
      DayInWeek('F',
          dayKey: 'friday',
          isSelected: widget.reminder?.days.contains('friday') ?? false),
      DayInWeek('S',
          dayKey: 'saturday',
          isSelected: widget.reminder?.days.contains('saturday') ?? false),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: Text(
            widget.reminder != null ? 'Edit Reminder' : 'Create Reminder',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Theme.of(context).colorScheme.onPrimary)),
        actions: [
          IconButton(
            icon: Icon(
              Symbols.done,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            onPressed: () {
              onSaveReminderButtonPressed();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 25),
            widget.reminder != null
                ? Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          color: Theme.of(context).colorScheme.secondary,
                          child: SwitchListTile(
                              activeTrackColor:
                                  Theme.of(context).colorScheme.primary,
                              inactiveTrackColor:
                                  Theme.of(context).colorScheme.primary,
                              title: const Text('Enabled'),
                              value: isReminderEnabled,
                              onChanged: (value) =>
                                  setState(() => isReminderEnabled = value)),
                        ),
                      ),
                      const SizedBox(height: 25),
                    ],
                  )
                : Container(),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Column(
                children: [
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Edit Time',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontSize: 16),
                          ),
                          InkWell(
                            onTap: () {
                              showTimePicker(
                                      context: context,
                                      initialEntryMode:
                                          TimePickerEntryMode.dial,
                                      initialTime: selectedTime)
                                  .then((value) {
                                if (value != null) {
                                  setState(() {
                                    selectedTime = value;
                                  });
                                }
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .surfaceContainerLowest,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              // width: 75,
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Text(
                                      ReminderUtils.timeOfDayPeriodString(
                                          selectedTime),
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      ' ${ReminderUtils.timeOfDayPeriodOnly(selectedTime)}',
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: Theme.of(context).colorScheme.primary,
                    thickness: 1,
                    height: 1,
                  ),
                  SelectWeekDays(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      daysBorderColor: Theme.of(context).colorScheme.primary,
                      daysFillColor: Theme.of(context).colorScheme.tertiary,
                      selectedDayTextColor:
                          Theme.of(context).colorScheme.onTertiary,
                      unSelectedDayTextColor:
                          Theme.of(context).colorScheme.onPrimary,
                      onSelect: (values) {
                        setState(() {
                          selectedDays = values;
                        });
                      },
                      days: days),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Text(ReminderUtils.getSelectedDayString(selectedDays),
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onSecondary,
                    fontSize: 14)),
            const SizedBox(
              height: 25,
            ),
            widget.reminder != null
                ? FormButton(
                    onTap: () => widget.onDeleteReminder!(),
                    text: 'Delete Reminder',
                    backgroundColor:
                        Theme.of(context).colorScheme.surfaceContainerHighest,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
