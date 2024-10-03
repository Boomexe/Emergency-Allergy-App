import 'package:choice/choice.dart';
import 'package:emergency_allergy_app/auth/auth_service.dart';
import 'package:emergency_allergy_app/components/custom_list_tile.dart';
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
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class Allergies extends StatefulWidget {
  const Allergies({super.key});

  @override
  State<Allergies> createState() => _AllergiesState();
}

class _AllergiesState extends State<Allergies> {
  void onFloatingActionButtonPressed() async {
    List<Medication> medications = await FirestoreService.getMedications();

    showAllergyCreationScreen(medications);
  }

  void showAllergyCreationScreen(List<Medication> medications) {
    showBottomSheet(context, CreateAllergy(medications: medications));
  }

  void showAllergyInformation(Allergy allergy) {
    showAllergyInformationSheet(context, allergy);
  }

  void deleteAllergy(Allergy allergy) {
    FirestoreService.deleteAllergy(allergy.id!);

    setState(() {});
  }

  void editAllergy(Allergy allergy) async {
    List<Medication> medications = await FirestoreService.getMedications();

    if (!mounted) return;

    showBottomSheet(
      context,
      CreateAllergy(
        medications: medications,
        allergyToEdit: allergy,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Allergies'),
      ),
      body: FutureBuilder(
          future: FirestoreService.getAllergies(),
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
                child: Text('Created allergies will appear here'),
              );
            }

            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => showAllergyInformation(snapshot.data![index]),
                    child: Slidable(
                      endActionPane: ActionPane(
                        motion: const DrawerMotion(),
                        children: [
                          SlidableAction(
                            flex: 2,
                            onPressed: (context) =>
                                editAllergy(snapshot.data![index]),
                            icon: Icons.edit,
                            label: 'Edit',
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .surfaceContainerHigh,
                          ),
                          SlidableAction(
                            flex: 2,
                            onPressed: (context) =>
                                deleteAllergy(snapshot.data![index]),
                            icon: Icons.delete,
                            label: 'Delete',
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .surfaceContainerHighest,
                          ),
                        ],
                      ),
                      child: CustomListTile(
                        title: snapshot.data![index].name,
                        subtitle: snapshot.data![index].description,
                        trailing: snapshot.data![index].severity.name,
                      ),
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
  final Allergy? allergyToEdit;
  const CreateAllergy(
      {super.key, required this.medications, this.allergyToEdit});

  @override
  State<CreateAllergy> createState() => _CreateAllergyState();
}

class _CreateAllergyState extends State<CreateAllergy> {
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();

  String? nameError;
  String? descriptionError;

  AllergyType? allergyType;
  AllergySeverity? allergySeverity;

  late List<MultiSelectItem<Medication>> medicationMultiSelectItems;
  List<String> selectedMedicationIds = [];
  List<Medication> selectedMedications =
      []; // ONLY USED WHEN EDITING MEDICATIONS

  bool isEditing = false;

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
    setState(() {
      nameError = null;
      descriptionError = null;
    });

    if (name.text.isEmpty) {
      setState(() {
        nameError = 'Name cannot be empty';
      });
      return;
    }

    if (allergyType == null) {
      setState(() {
        showSnackBar(context, 'Please select an allergy type.');
      });
      return;
    }

    if (allergySeverity == null) {
      setState(() {
        showSnackBar(context, 'Please select an allergy severity.');
      });
      return;
    }

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

    if (isEditing) {
      FirestoreService.updateAllergy(widget.allergyToEdit!.id!, allergy);
      showSnackBar(context, 'Updated ${allergy.name.toLowerCase()}');
    } else {
      FirestoreService.addAllergy(allergy);
      showSnackBar(context, 'Added ${allergy.name.toLowerCase()}');
    }

    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(selectedIndex: 2),
      ),
    );
  }

  void editAllergy() {
    isEditing = true;
    name.text = widget.allergyToEdit!.name;
    description.text = widget.allergyToEdit!.description;
    allergyType = widget.allergyToEdit!.type;
    allergySeverity = widget.allergyToEdit!.severity;
    selectedMedicationIds = widget.allergyToEdit!.medicationIds;
    selectedMedications = widget.medications
        .where((element) => selectedMedicationIds.contains(element.id))
        .toList();
  }

  @override
  void initState() {
    if (widget.allergyToEdit != null) {
      editAllergy();
    }

    medicationMultiSelectItems =
        widget.medications.map((e) => MultiSelectItem(e, e.name)).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          isEditing
              ? 'Edit ${widget.allergyToEdit!.name} Allergy'
              : 'Add Allergy',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Theme.of(context).colorScheme.onPrimary),
        ),
        actions: [
          IconButton(
            onPressed: () => saveButtonPressed(),
            icon: Icon(
              isEditing ? Icons.edit : Icons.add,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          )
        ],
      ),
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
              ),
              const SizedBox(height: 10),
              FormTextField(
                hintText: 'Description',
                textController: description,
                errorMsg: descriptionError,
              ),
              const SizedBox(height: 25),
              Card(
                color: Theme.of(context).colorScheme.secondary,
                child: SingleChoicePrompt<AllergyType>(
                  title: 'Allergy Type',
                  choices: AllergyType.values,
                  onSelected: (selected) => updateSelectedAllergyType(selected),
                  initialValue: allergyType,
                ),
              ),
              Card(
                color: Theme.of(context).colorScheme.secondary,
                child: SingleChoicePrompt<AllergySeverity>(
                  title: 'Allergy Severity',
                  choices: AllergySeverity.values,
                  onSelected: (selected) =>
                      updateSelectedAllergySeverity(selected),
                  initialValue: allergySeverity,
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
                  initialValues: selectedMedications,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
