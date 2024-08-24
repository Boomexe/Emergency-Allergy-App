import 'package:emergency_allergy_app/components/custom_navigation_bar.dart';
import 'package:emergency_allergy_app/models/allergy.dart';
import 'package:emergency_allergy_app/services/services.dart';
import 'package:flutter/material.dart';

class Allergies extends StatefulWidget {
  const Allergies({super.key});

  @override
  State<Allergies> createState() => _AllergiesState();
}

class _AllergiesState extends State<Allergies> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Allergies'),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                useSafeArea: true,
                builder: (context) => Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                          left: 20,
                          right: 20),
                      child: const CreateAllergy(),
                    ));
          },
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(Icons.add, color: Colors.white)),
    );
  }
}

class CreateAllergy extends StatefulWidget {
  const CreateAllergy({super.key});

  @override
  State<CreateAllergy> createState() => _CreateAllergyState();
}

class _CreateAllergyState extends State<CreateAllergy> {
  TextEditingController name = TextEditingController();
  TextEditingController note = TextEditingController();
  TextEditingController type = TextEditingController();
  TextEditingController severity = TextEditingController();
  TextEditingController medications = TextEditingController();

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
            TextFormField(
              decoration: const InputDecoration(labelText: 'Dosage'),
            ),
            TextButton(
                onPressed: () {
                  // AllergyInfo allergy = AllergyInfo(name: name.text, description: note.text, type: type.text, severity: severity.text, medications: medications.text)
                  // Services.saveAllergy(allergy);
                },
                child: const Text("Save")),
          ]),
        ),
      ),
    );
  }
}
