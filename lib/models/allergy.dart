class Allergy {
  final String name;
  final String description;

  final AllergyType type;
  final AllergySeverity severity;

  final List<String> medicationIds;

  Allergy(
      {required this.name,
      required this.description,
      required this.type,
      required this.severity,
      required this.medicationIds});

  factory Allergy.fromJson(Map<String, dynamic> json) {
    return Allergy(
        name: json['name'],
        description: json['description'],
        type: AllergyType.values[json['type']],
        severity: AllergySeverity.values[json['severity']],
        medicationIds: json['medications']);
  }

  static List<Allergy> fromJsonList(List<dynamic> jsonList) {
    List<Allergy> allergies = [];
    for (var json in jsonList) {
      allergies.add(Allergy.fromJson(json));
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

enum AllergySeverity { mild, moderate, severe }

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