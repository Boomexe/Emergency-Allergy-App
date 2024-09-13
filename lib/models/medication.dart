import 'package:emergency_allergy_app/models/reminder.dart';

class Medication {
  final String userId;
  final String? id;

  final String name;
  final String note;
  final String dosage;

  final List<Reminder> reminders;

  Medication({
    required this.name,
    required this.note,
    required this.dosage,
    required this.reminders,
    required this.userId,
    this.id,
  });

  factory Medication.fromJson(Map<String, dynamic> json, {String? id}) {
    Medication medication = Medication(
      name: json['name'],
      note: json['note'],
      dosage: json['dosage'],
      reminders: Reminder.fromJsonList(json['reminders']),
      userId: json['userId'],
      id: id,
    );

    return medication;
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
      'userId': medication.userId,
      'name': medication.name,
      'note': medication.note,
      'dosage': medication.dosage,
      'reminders': Reminder.toJsonList(medication.reminders),
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
