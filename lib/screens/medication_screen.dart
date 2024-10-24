import 'package:emergency_allergy_app/auth/auth_service.dart';
import 'package:emergency_allergy_app/components/custom_list_tile.dart';
import 'package:emergency_allergy_app/components/form_textfield.dart';
import 'package:emergency_allergy_app/components/list_view_seperator.dart';
import 'package:emergency_allergy_app/components/reminder_list_tile.dart';
import 'package:emergency_allergy_app/models/medication.dart';
import 'package:emergency_allergy_app/models/reminder.dart';
import 'package:emergency_allergy_app/screens/create_reminder_screen.dart';
import 'package:emergency_allergy_app/screens/home_screen.dart';
import 'package:emergency_allergy_app/services/firestore_service.dart';
import 'package:emergency_allergy_app/utils/modal_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:material_symbols_icons/symbols.dart';

class Medications extends StatefulWidget {
  const Medications({super.key});

  @override
  State<Medications> createState() => _MedicationsState();
}

class _MedicationsState extends State<Medications> {
  void showMedicationInformation(Medication medication) {
    showMedicationInformationSheet(
        context, medication); //, MedicationInformation(allergy: allergy));
  }

  void deleteMedication(Medication medication) {
    FirestoreService.deleteMedication(medication.id!);

    setState(() {});
  }

  void editMedication(Medication medication) {
    showCustomBottomSheet(
        context, CreateMedication(medicationToEdit: medication));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Medications',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder(
        future: FirestoreService.getMedications(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error retrieving data: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Created medications will appear here'),
            );
          }

          return ListView.separated(
              itemCount: snapshot.data!.length,
              separatorBuilder: (context, index) => const ListViewSeperator(),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => showMedicationInformation(snapshot.data![index]),
                  child: Slidable(
                    endActionPane: ActionPane(
                      motion: const DrawerMotion(),
                      children: [
                        SlidableAction(
                          flex: 2,
                          onPressed: (context) =>
                              editMedication(snapshot.data![index]),
                          icon: Symbols.edit,
                          label: 'Edit',
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .surfaceContainerHigh,
                        ),
                        SlidableAction(
                          flex: 2,
                          onPressed: (context) =>
                              deleteMedication(snapshot.data![index]),
                          icon: Symbols.delete,
                          label: 'Delete',
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .surfaceContainerHighest,
                        ),
                      ],
                    ),
                    child: CustomListTile(
                      title: snapshot.data![index].name,
                      subtitle: snapshot.data![index].note,
                      trailing: snapshot.data![index].dosage,
                    ),
                  ),
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showCustomBottomSheet(
            context,
            const CreateMedication(),
          );
        },
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: const Icon(Symbols.add),
      ),
    );
  }
}

class CreateMedication extends StatefulWidget {
  final Medication? medicationToEdit;
  const CreateMedication({super.key, this.medicationToEdit});

  @override
  State<CreateMedication> createState() => _CreateMedicationState();
}

class _CreateMedicationState extends State<CreateMedication> {
  TextEditingController name = TextEditingController();
  TextEditingController note = TextEditingController();
  TextEditingController dosage = TextEditingController();

  String? nameError;
  String? noteError;
  String? dosageError;

  TimeOfDay? medicationReminderTime;

  List<Reminder> reminders = [];

  bool isEditing = false;

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

  void editMedication() {
    isEditing = true;
    name.text = widget.medicationToEdit!.name;
    note.text = widget.medicationToEdit!.note;
    dosage.text = widget.medicationToEdit!.dosage;
    reminders = widget.medicationToEdit!.reminders;
  }

  void saveButtonPressed() async {
    setState(() {
      nameError = null;
      noteError = null;
      dosageError = null;
    });

    if (name.text.isEmpty) {
      setState(() {
        nameError = 'Please enter a name.';
      });
      return;
    }

    if (dosage.text.isEmpty) {
      setState(() {
        dosageError = 'Please enter a dosage.';
      });
      return;
    }

    AuthService auth = AuthService();
    User? user = auth.auth.currentUser;

    Medication medication = Medication(
      name: name.text,
      note: note.text,
      dosage: dosage.text,
      reminders: reminders,
      userId: user!.uid,
    );

    if (isEditing) {
      FirestoreService.updateMedication(
          widget.medicationToEdit!.id!, medication);
    } else {
      FirestoreService.addMedication(medication);
    }

    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(selectedIndex: 1),
      ),
    );
  }

  @override
  void initState() {
    if (widget.medicationToEdit != null) {
      editMedication();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          isEditing
              ? 'Edit ${widget.medicationToEdit!.name}'
              : 'Add Medication',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
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
            onPressed: () => saveButtonPressed(),
            icon: Icon(
              isEditing ? Symbols.edit : Symbols.add,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormTextField(
                hintText: 'Name',
                textController: name,
                errorMsg: nameError,
                maxLength: 25,
              ),
              const SizedBox(height: 10),
              FormTextField(
                hintText: 'Note',
                textController: note,
                errorMsg: noteError,
                maxLength: 300,
              ),
              const SizedBox(height: 10),
              FormTextField(
                hintText: 'Dosage',
                textController: dosage,
                errorMsg: dosageError,
                maxLength: 25,
              ),
              const SizedBox(height: 25),
              Text(
                'Reminders',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 16,
                ),
              ),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: reminders.length,
                separatorBuilder: (context, index) => const ListViewSeperator(),
                itemBuilder: (context, index) {
                  return ReminderListTile(
                    key: ValueKey(reminders[index]),
                    isInteractable: true,
                    index: index,
                    reminder: reminders[index],
                    onUpdateReminder: onUpdateReminder,
                    onDeleteReminder: onDeleteReminder,
                  );
                },
              ),
              ListTile(
                onTap: () {
                  showCustomBottomSheet(
                    context,
                    CreateReminderScreen(onSaveReminder: onAddReminder),
                  );
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
                    color: Theme.of(context).colorScheme.surfaceContainer,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
