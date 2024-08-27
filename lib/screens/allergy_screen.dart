import 'package:emergency_allergy_app/models/medication.dart';
import 'package:emergency_allergy_app/services/services.dart';
import 'package:emergency_allergy_app/models/allergy.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class Allergies extends StatefulWidget {
  const Allergies({super.key});

  @override
  State<Allergies> createState() => _AllergiesState();
}

class _AllergiesState extends State<Allergies> {
  void onFloatingActionButtonPressed() async {
    List<Medication> medications = await Services.loadMedications();

    showAllergyCreationScreen(medications);
  }

  void showAllergyCreationScreen(List<Medication> medications) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        builder: (context) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  left: 20,
                  right: 20),
              child: CreateAllergy(medications: medications),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Allergies'),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            onFloatingActionButtonPressed();
          },
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(Icons.add, color: Colors.white)),
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
  TextEditingController nameController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  AllergyType? allergyType;
  AllergySeverity? allergySeverity;

  late List<MultiSelectItem<Medication>> medicationMultiSelectItems;
  List<Medication> selectedMedications = [];

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Note'),
            ),
            DropdownButton(
              hint: const Text('Allergy Type'),
              value: allergyType,
              items: AllergyType.values.map(
                (e) {
                  return DropdownMenuItem(
                      value: e,
                      child:
                          Text(e.name[0].toUpperCase() + e.name.substring(1)));
                },
              ).toList(),
              onChanged: (value) {
                setState(() {
                  allergyType = value as AllergyType;
                });
              },
            ),
            DropdownButton(
              hint: const Text('Allergy Severity'),
              value: allergySeverity,
              items: AllergySeverity.values.map(
                (e) {
                  return DropdownMenuItem(
                      value: e,
                      child:
                          Text(e.name[0].toUpperCase() + e.name.substring(1)));
                },
              ).toList(),
              onChanged: (value) {
                setState(() {
                  allergySeverity = value as AllergySeverity;
                });
              },
            ),
            Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  children: [
                    MultiSelectDialogField(
                      decoration: const BoxDecoration(),
                      searchable: true,
                      listType: MultiSelectListType.CHIP,
                      buttonText: const Text('Select Medications'),
                      title: const Text('Medications'),
                      items: medicationMultiSelectItems,
                      onConfirm: (values) {
                        setState(() {
                          selectedMedications = values.cast<Medication>();
                        });
                      },
                      chipDisplay: MultiSelectChipDisplay.none(),
                    ),
                    Divider(
                      height: 2,
                      thickness: 2,
                      color: Colors.grey.shade400,
                    ),
                    MultiSelectChipDisplay(
                      decoration: const BoxDecoration(),
                      height: 50,
                      items: selectedMedications
                          .map((e) => MultiSelectItem(e, e.name))
                          .toList(),
                      scroll: true,
                      onTap: (value) {
                        setState(() {
                          selectedMedications.remove(value);
                        });
                      },
                    ),
                    selectedMedications.isEmpty
                        ? const SizedBox(
                            height: 50,
                            child:
                                Center(child: Text('No medications selected')))
                        : const SizedBox.shrink(),
                  ],
                )),
            TextButton(
                onPressed: () {
                  print('${nameController.text} ${noteController.text} $allergyType $allergySeverity ${selectedMedications.map((e) => e.id).toList()}');
                  Allergy allergy = Allergy(
                      name: nameController.text,
                      description: noteController.text,
                      type: allergyType!,
                      severity: allergySeverity!,
                      medicationIds:
                          selectedMedications.map((e) => e.id).toList());
                  Services.saveAllergy(allergy);
                },
                child: const Text('Save')),
          ]),
        ),
      ),
    );
  }
}
