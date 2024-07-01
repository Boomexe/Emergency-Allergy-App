import 'package:emergency_allergy_app/models/medication.dart';

class AllergyInfo {
  final String name;
  final String description;

  final AllergyType type;
  final AllergySeverity severity;

  final List<Medication> medications;

  AllergyInfo({required this.name, required this.description, required this.type, required this.severity, required this.medications});
}

enum AllergyType {
  food,
  drug,
  contact,
  latex,
  seasonal,
  animal,
  mold,
  venom,
  other
}

enum AllergySeverity {
  mild,
  moderate,
  severe,
  lifeThreatening
}

// enum AllergyReaction {
//   hives,
//   itching,
//   rash,
//   swelling,
//   abdominalPain,
//   diarrhea,
//   vomiting,
//   wheezing,
//   anaphylaxis,
// }