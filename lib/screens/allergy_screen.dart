import 'package:choice/choice.dart';
import 'package:emergency_allergy_app/auth/auth_service.dart';
import 'package:emergency_allergy_app/components/form_textfield.dart';
import 'package:emergency_allergy_app/components/multi_choice_prompt.dart';
import 'package:emergency_allergy_app/components/single_choice_prompt.dart';
import 'package:emergency_allergy_app/models/medication.dart';
import 'package:emergency_allergy_app/screens/home_screen.dart';
import 'package:emergency_allergy_app/services/firestore.dart';
import 'package:emergency_allergy_app/models/allergy.dart';
import 'package:emergency_allergy_app/utils/modal_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class Allergies extends StatefulWidget {
  const Allergies({super.key});

  @override
  State<Allergies> createState() => _AllergiesState();
}

class _AllergiesState extends State<Allergies> {
  void onFloatingActionButtonPressed() async {
    List<Medication> medications = await FirestoreService.getMedications();

    // print('medication: ${medications.map((e) => e.id)}');

    showAllergyCreationScreen(medications);
  }

  void showAllergyCreationScreen(List<Medication> medications) {
    showModal(context, CreateAllergy(medications: medications));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: FirestoreService.getAllergies(),
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
                      snapshot.data![index].description,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary),
                    ),
                    trailing: Text(
                      snapshot.data![index].severity.name,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary),
                    ),
                  );
                });
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          onFloatingActionButtonPressed();
        },
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CreateAllergy extends StatefulWidget {
  final List<Medication> medications;
  const CreateAllergy({super.key, required this.medications});

  @override
  State<CreateAllergy> createState() => _CreateAllergyState();
}

class _CreateAllergyState extends State<CreateAllergy> {
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();

  AllergyType? allergyType;
  AllergySeverity? allergySeverity;

  late List<MultiSelectItem<Medication>> medicationMultiSelectItems;
  List<String> selectedMedicationIds = [];

  void updateSelectedMedications(List<ChoiceData<dynamic>> selected) {
    selectedMedicationIds = selected.map((e) {
      dynamic medication = e.value as Medication;
      return medication.id as String;
    }).toList();
  }

  void updateSelectedAllergyType(AllergyType selected) {
    allergyType = selected;
  }

  void updateSelectedAllergySeverity(AllergySeverity selected) {
    allergySeverity = selected;
  }

  void saveButtonPressed() {
    AuthService auth = AuthService();
    User? user = auth.auth.currentUser;

    Allergy allergy = Allergy(
      name: name.text,
      description: description.text,
      type: allergyType!,
      severity: allergySeverity!,
      medicationIds: selectedMedicationIds,
      userId: user!.uid,
    );

    FirestoreService.addAllergy(allergy);
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const HomeScreen(selectedIndex: 2)));
  }

  @override
  void initState() {
    super.initState();
    medicationMultiSelectItems =
        widget.medications.map((e) => MultiSelectItem(e, e.name)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add Allergy',
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
              onPressed: () => saveButtonPressed(),
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
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormTextField(hintText: 'Name', textController: name),
              const SizedBox(height: 10),
              FormTextField(
                  hintText: 'Description', textController: description),
              const SizedBox(height: 25),
              Card(
                color: Theme.of(context).colorScheme.secondary,
                child: SingleChoicePrompt<AllergyType>(
                  title: 'Allergy Type',
                  choices: AllergyType.values,
                  onSelected: (selected) => updateSelectedAllergyType(selected),
                ),
              ),
              Card(
                color: Theme.of(context).colorScheme.secondary,
                child: SingleChoicePrompt<AllergySeverity>(
                  title: 'Allergy Severity',
                  choices: AllergySeverity.values,
                  onSelected: (selected) =>
                      updateSelectedAllergySeverity(selected),
                ),
              ),
              const SizedBox(height: 25),
              Card(
                color: Theme.of(context).colorScheme.secondary,
                child: MultiChoicePrompt<Medication>(
                  title: 'Medications',
                  choices: widget.medications,
                  choiceTitles:
                      widget.medications.map<String>((e) => e.name).toList(),
                  onSelected: (selected) => updateSelectedMedications(selected),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
