import 'package:emergency_allergy_app/components/custom_navigation_bar.dart';
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
        bottomNavigationBar: const CustomNavigationBar(
          currentIndex: 3,
        ));
  }
}

class CreateAllergy extends StatefulWidget {
  const CreateAllergy({super.key});

  @override
  State<CreateAllergy> createState() => _CreateAllergyState();
}

class _CreateAllergyState extends State<CreateAllergy> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: 400,
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
        ]),
      ),
    );
  }
}
