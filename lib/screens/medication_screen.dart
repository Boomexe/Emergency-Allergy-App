import 'package:emergency_allergy_app/components/form_textfield.dart';
import 'package:emergency_allergy_app/components/reminder_list_tile.dart';
import 'package:emergency_allergy_app/models/medication.dart';
import 'package:emergency_allergy_app/models/reminder.dart';
import 'package:emergency_allergy_app/screens/create_reminder_screen.dart';
import 'package:emergency_allergy_app/services/firestore.dart';
import 'package:flutter/material.dart';

class Medications extends StatefulWidget {
  const Medications({super.key});

  @override
  State<Medications> createState() => _MedicationsState();
}

class _MedicationsState extends State<Medications> {
  // late Future<List<Medication>> medications;

  // Future<List<Medication>> fetchMedications() async {
  //   return await Services.loadMedications();
  // }

  void onSaveMedication(newMedications) {
    // FirestoreService.addMedication(newMedications);
    // setState(() {
    //   medications = newMedications;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: FirestoreService.getMedications(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
                child: Text('Error retrieving data: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No medications found'));
          }

          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                // print(
                //     'snapshot.data: ${'${snapshot.data![index].name} ${snapshot.data![index].dosage} ${snapshot.data![index].note}'}');
                return ListTile(
                  title: Text(snapshot.data![index].name),
                  subtitle: Text(
                    snapshot.data![index].note,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary),
                  ),
                  trailing: Text(
                    snapshot.data![index].dosage,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary),
                  ),
                );
              });
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
                    child: CreateMedication(onSaveMedication: onSaveMedication),
                  ));
        },
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: const Icon(Icons.add),
      ),
    );
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

  TimeOfDay? medicationReminderTime;

  List<Reminder> reminders = [];

  void onAddReminder(Reminder reminder) {
    setState(() {
      reminders.add(reminder);
    });
    Navigator.pop(context);
  }

  void onUpdateReminder(Reminder reminder, int index) {
    setState(() {
      reminders[index] = reminder;
    });
    Navigator.pop(context);
  }

  void onDeleteReminder(int index) {
    setState(() {
      reminders.removeAt(index);
    });
    Navigator.pop(context);
  }

  void saveButtonPressed() async {
    // List<Reminder> reminders = [];

    // if (medicationHasReminderSwitch) {
    //   // print(medicationReminderTime);
    //   Reminder reminder = Reminder(
    //     days: days
    //         .where((day) => day.isSelected)
    //         .map((day) => day.dayKey)
    //         .toList(),
    //     time: medicationReminderTime!,
    //   );
    //   reminders.add(reminder);
    //   print('REMINDER: ${Reminder.toJson(reminder)}');
    // }

    Medication medication = Medication(
      name: name.text,
      note: note.text,
      dosage: dosage.text,
      reminders: reminders,
    );

    // widget.onSaveMedication(medications);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add Medication',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Theme.of(context).colorScheme.onPrimary)),
        // leading: TextButton(
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        //   child: Text('Cancel',
        //       style: TextStyle(
        //           color: Theme.of(context).colorScheme.surfaceContainerLow)),
        // ),
        actions: [
          IconButton(
              onPressed: () {
                saveButtonPressed();
              },
              icon: Icon(
                Icons.add,
                color: Theme.of(context).colorScheme.onPrimary,
              ))
          // TextButton(
          //     onPressed: () {
          //       saveButtonPressed();
          //     },
          //     child: Text('Add',
          //         style: TextStyle(
          //             color:
          //                 Theme.of(context).colorScheme.surfaceContainerLow))),
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            FormTextField(hintText: 'Name', textController: name),
            const SizedBox(height: 10),
            FormTextField(hintText: 'Note', textController: note),
            const SizedBox(height: 10),
            FormTextField(hintText: 'Dosage', textController: dosage),
            const SizedBox(height: 25),
            Text(
              'Reminders',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary, fontSize: 16),
            ),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: reminders.length + 1,
                itemBuilder: (context, index) {
                  if (index == reminders.length) {
                    return ListTile(
                      onTap: () {
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
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom,
                                  ),
                                  child: CreateReminderScreen(
                                      onSaveReminder: onAddReminder),
                                ));
                      },
                      // leading: Icon(
                      //   null,
                      //   color: Theme.of(context)
                      //       .colorScheme
                      //       .surfaceContainerHighest,
                      // ),
                      title: Text(
                        'Add Reminder',
                        style: TextStyle(
                            color:
                                Theme.of(context).colorScheme.surfaceContainer),
                      ),
                    );
                  }

                  return ReminderListTile(
                      key: ValueKey(reminders[index]),
                      index: index,
                      reminder: reminders[index],
                      onUpdateReminder: onUpdateReminder,
                      onDeleteReminder: onDeleteReminder);
                }),
          ]),
        ),
      ),
    );
  }
}
