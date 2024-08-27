import 'package:emergency_allergy_app/models/allergy.dart';
import 'package:flutter/material.dart';

class AllergyDetails extends StatefulWidget {
  final Allergy allergy;

  const AllergyDetails({super.key, required this.allergy});

  @override
  State<AllergyDetails> createState() => _AllergyDetailsState();
}

class _AllergyDetailsState extends State<AllergyDetails> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TextFormField(
        decoration: const InputDecoration(labelText: 'Name'),
        readOnly: true,
      ),
      TextFormField(
        decoration: const InputDecoration(labelText: 'Description'),
        maxLines: 3,
        readOnly: true,
      ),
      TextFormField(
        decoration: const InputDecoration(labelText: 'Type'),
        readOnly: true,
      ),
      TextFormField(
        decoration: const InputDecoration(labelText: 'Severity'),
        readOnly: true,
      ),
    ]);
  }
}
