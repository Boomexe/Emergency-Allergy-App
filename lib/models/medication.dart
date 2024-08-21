import 'package:uuid/uuid.dart';

class Medication {
  final String id;

  final String name;
  final String note;
  final String dosage;

  final List<String> reminders;

  Medication({
    required this.name,
    required this.note,
    required this.dosage,
    required this.reminders,
  }) : id = const Uuid().v4();

  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
      name: json['name'],
      note: json['note'],
      dosage: json['dosage'],
      reminders: List<String>.from(json['reminders']),
    );
  }

  static List<Medication> fromJsonList(List<dynamic> jsonList) {
    List<Medication> medications = [];
    for (var json in jsonList) {
      medications.add(Medication.fromJson(json));
    }

    return medications;
  }

  static Map<String, dynamic> toJson(Medication medication) {
    return {
      'id': medication.id,
      'name': medication.name,
      'note': medication.note,
      'dosage': medication.dosage,
      'reminders': medication.reminders,
    };
  }

  static Map<String, dynamic> toJsonList(List<Medication> medications) {
    List<Map<String, dynamic>> jsonList = [];
    for (var medication in medications) {
      jsonList.add(Medication.toJson(medication));
    }

    return {'medications': jsonList};
  }
}
