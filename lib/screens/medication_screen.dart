import 'package:day_picker/day_picker.dart';
import 'package:emergency_allergy_app/models/medication.dart';
import 'package:emergency_allergy_app/models/reminder.dart';
import 'package:emergency_allergy_app/services/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Medications extends StatefulWidget {
  const Medications({super.key});

  @override
  State<Medications> createState() => _MedicationsState();
}

class _MedicationsState extends State<Medications> {
  late Future<List<Medication>> medications;

  Future<List<Medication>> fetchMedications() async {
    return await Services.loadMedications();
  }

  void onSaveMedication(newMedications) {
    setState(() {
      medications = newMedications;
    });
  }

  @override
  void initState() {
    super.initState();
    medications = fetchMedications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
          future: medications,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isNotEmpty) {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(snapshot.data![index].name),
                        subtitle: Text(snapshot.data![index].note),
                        trailing: Text(snapshot.data![index].dosage),
                      );
                    });
              } else {
                return const Center(child: Text('No medications found'));
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
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
                      child:
                          CreateMedication(onSaveMedication: onSaveMedication),
                    ));
          },
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(Icons.add, color: Colors.white),
        ),);
  }
}

class CreateMedication extends StatefulWidget {
  final Function(Future<List<Medication>>) onSaveMedication;

  const CreateMedication({super.key, required this.onSaveMedication});

  @override
  State<CreateMedication> createState() => _CreateMedicationState();
}

class _CreateMedicationState extends State<CreateMedication> {
  TextEditingController name = TextEditingController();
  TextEditingController note = TextEditingController();
  TextEditingController dosage = TextEditingController();

  bool medicationHasReminderSwitch = false;
  DateTime? medicationReminderTime = DateTime.now();

  final List<DayInWeek> days = [
    DayInWeek('Sun', dayKey: 'sunday'),
    DayInWeek('Mon', dayKey: 'monday'),
    DayInWeek('Tue', dayKey: 'tuesday'),
    DayInWeek('Wed', dayKey: 'wednesday'),
    DayInWeek('Thu', dayKey: 'thursday'),
    DayInWeek('Fri', dayKey: 'friday'),
    DayInWeek('Sat', dayKey: 'saturday'),
  ];

  void saveButtonPressed() async {
    List<Reminder> reminders = [];

    if (medicationHasReminderSwitch) {
      print(medicationReminderTime);
      reminders.add(Reminder(
        days: days
            .where((day) => day.isSelected)
            .map((day) => day.dayKey)
            .toList(),
        time: medicationReminderTime!,
      ));
    }

    Medication medication = Medication(
      name: name.text,
      note: note.text,
      dosage: dosage.text,
      reminders: reminders,
    );

    Future<List<Medication>> medications =
        Services.saveAndReturnMedications(medication);

    widget.onSaveMedication(medications);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Name'),
                      controller: name,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Note'),
                      controller: note,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Dosage'),
                      controller: dosage,
                    ),
                    TextButton(
                        onPressed: () {
                          saveButtonPressed();
                        },
                        child: const Text('Save')),
                    TextButton(
                        onPressed: () {
                          Services.clearData();
                        },
                        child: const Text('Clear all')),
                    SwitchListTile(
                        title: const Text('Has Reminder'),
                        value: medicationHasReminderSwitch,
                        onChanged: (value) {
                          setState(() {
                            medicationHasReminderSwitch = value;
                          });
                        }),
                    SelectWeekDays(
                        onSelect: (values) {
                          List<String> days = values;
                          print('days: $days');
                        },
                        days: days),
                    SizedBox(
                      height: 200,
                      child: CupertinoDatePicker(
                        initialDateTime: DateTime.now(),
                        mode: CupertinoDatePickerMode.time,
                        use24hFormat: false,
                        onDateTimeChanged: (DateTime newDate) {
                          setState(() => medicationReminderTime = newDate);
                        },
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
