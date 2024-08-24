// import 'package:emergency_allergy_app/models/medication.dart';
// import 'package:flutter/foundation.dart';

class AllergyInfo {
  final String name;
  final String description;

  final AllergyType type;
  final AllergySeverity severity;

  final List<int> medications;

  AllergyInfo({required this.name, required this.description, required this.type, required this.severity, required this.medications});

  factory AllergyInfo.fromJson(Map<String, dynamic> json) {
    return AllergyInfo(
      name: json['name'],
      description: json['description'],
      type: AllergyType.values[json['type']],
      severity: AllergySeverity.values[json['severity']],
      medications: json['medications']
    );
  }

  static List<AllergyInfo> fromJsonList(List<dynamic> jsonList) {
    List<AllergyInfo> allergies = [];
    for (var json in jsonList) {
      allergies.add(AllergyInfo.fromJson(json));
    }

    return allergies;
  }
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