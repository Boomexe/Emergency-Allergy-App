import 'package:emergency_allergy_app/auth/auth_service.dart';
import 'package:emergency_allergy_app/components/form_textfield.dart';
import 'package:emergency_allergy_app/components/reminder_list_tile.dart';
import 'package:emergency_allergy_app/models/medication.dart';
import 'package:emergency_allergy_app/models/reminder.dart';
import 'package:emergency_allergy_app/screens/create_reminder_screen.dart';
import 'package:emergency_allergy_app/screens/home_screen.dart';
import 'package:emergency_allergy_app/services/firestore.dart';
import 'package:emergency_allergy_app/utils/modal_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Medications extends StatefulWidget {
  const Medications({super.key});

  @override
  State<Medications> createState() => _MedicationsState();
}

class _MedicationsState extends State<Medications> {
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
                // print(Medication.toJson(snapshot.data![index]));
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
          showModal(
            context,
            const CreateMedication(),
          );
        },
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CreateMedication extends StatefulWidget {
  const CreateMedication({super.key});

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
    AuthService auth = AuthService();
    User? user = auth.auth.currentUser;

    Medication medication = Medication(
      name: name.text,
      note: note.text,
      dosage: dosage.text,
      reminders: reminders,
      userId: user!.uid,
    );

    FirestoreService.addMedication(medication);

    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const HomeScreen(selectedIndex: 1)));
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
                        showModal(
                            context,
                            CreateReminderScreen(
                                onSaveReminder: onAddReminder));
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
