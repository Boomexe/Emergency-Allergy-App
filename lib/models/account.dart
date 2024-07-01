import 'package:emergency_allergy_app/models/allergy_info.dart';

class Account {
  String firstName;
  String lastName;

  DateTime birthDate;
  int weightInLbs;
  int heightInInches;

  List<AllergyInfo> allergies = [];

  Account({required this.firstName, required this.lastName, required this.birthDate, required this.weightInLbs, required this.heightInInches, required this.allergies});

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      firstName: json['firstName'],
      lastName: json['lastName'],
      birthDate: json['birthDate'],
      weightInLbs: json['weightInLbs'],
      heightInInches: json['heightInInches'],
      allergies: json['allergies'],
    );
  }

  Map<String, dynamic> toJson() => {
    'firstName': firstName,
    'lastName': lastName,
    'birthDate': birthDate,
    'weightInLbs': weightInLbs,
    'heightInInches': heightInInches,
    'allergies': allergies,
  };

  Duration getAge() {
    return DateTime.now().difference(birthDate);
  }
}