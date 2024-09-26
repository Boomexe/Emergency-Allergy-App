class Allergy {
  final String userId;
  final String? id;

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
      required this.medicationIds,
      required this.userId,
      this.id});

  factory Allergy.fromJson(Map<String, dynamic> json, {String? id}) {
    return Allergy(
      name: json['name'],
      description: json['description'],
      type: AllergyType.values[json['type']],
      severity: AllergySeverity.values[json['severity']],
      medicationIds: List<String>.from(json['medications']),
      userId: json['userId'],
      id: id
    );
  }

  static List<Allergy> fromJsonList(List<dynamic> jsonList) {
    List<Allergy> allergies = [];
    for (var json in jsonList) {
      allergies.add(Allergy.fromJson(json));
    }

    return allergies;
  }

  static Map<String, dynamic> toJson(Allergy allergy) {
    return {
      'name': allergy.name,
      'description': allergy.description,
      'type': allergy.type.index,
      'severity': allergy.severity.index,
      'medications': allergy.medicationIds,
      'userId': allergy.userId,
    };
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